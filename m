Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263204AbSKEAGR>; Mon, 4 Nov 2002 19:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263188AbSKEAFL>; Mon, 4 Nov 2002 19:05:11 -0500
Received: from f165.law11.hotmail.com ([64.4.17.165]:28429 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S263267AbSKEAEo>;
	Mon, 4 Nov 2002 19:04:44 -0500
X-Originating-IP: [144.92.164.196]
From: "Tom Reinhart" <rhino_tom@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Filesystem Capabilities in 2.6?
Date: Mon, 04 Nov 2002 16:11:13 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F165WEHoQoPDOfXQnEi00004b56@hotmail.com>
X-OriginalArrivalTime: 05 Nov 2002 00:11:13.0473 (UTC) FILETIME=[DA0B5310:01C2845F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'be been reading this discussion with interest, but it seems like people 
are missing the obvious.  There's already an infrastructure in 2.5 that is 
perfect for features like this: the LSM.  Consider the advantages:
1) It's filesystem independent, and doesn't bloat the filesystem, VFS, and 
exec code.  Just hook the exec call in an LSM module and twiddle the 
permissions appropriately according to policy.
2) More importantly, this kind of feature isn't really that useful on its 
own, but makes the most sense in the context of overall system security, 
which is exactly what LSM is designed to enable.

I haven't studies the LSM in any detail, but I'm sure the appropriate hooks 
to implement this kind of policy are either available already, or easily 
added.

_________________________________________________________________
Broadband? Dial-up? Get reliable MSN Internet Access. 
http://resourcecenter.msn.com/access/plans/default.asp

