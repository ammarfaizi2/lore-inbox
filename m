Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUI0Ozh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUI0Ozh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 10:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266296AbUI0Ozh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 10:55:37 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:23787 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261234AbUI0Oza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 10:55:30 -0400
To: Timothy Miller <miller@techsource.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, jmerkey@comcast.net,
       alan@lxorguk.ukuu.org.uk, wli@holomorphy.com,
       linux-kernel@vger.kernel.org, jmerkey@drdos.com
X-Message-Flag: Warning: May contain useful information
References: <083020040556.26446.4132C1810009E19F0000674E2200751150970A059D0A0306@comcast.net>
	<20040830111019.5ddc99ab.rddunlap@osdl.org>
	<4151C9FB.8040100@techsource.com> <52r7oukuh5.fsf@topspin.com>
	<4151DF1F.2050202@techsource.com>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 27 Sep 2004 07:55:26 -0700
Message-ID: <528yaviwwx.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: 1GB/2GB/3GB User Space Splitting Patch 2.6.8.1 (PSEUDO SPAM)
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 27 Sep 2004 14:55:27.0029 (UTC) FILETIME=[06488650:01C4A4A2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Timothy> Ok, I understand now.  I think.  With 0xc0000000, you
    Timothy> have 128M of highmem, right?  Why do you add 256M to the
    Timothy> kernel address space?  Is there a further advantage to that?

No real reason, just laziness.  It's easier to change "0xc" to "0xb"
and not think rather than figuring out if 0xb8000000 will let me use
every last byte of RAM.  (I'm not sure if I end up with exactly 128 MB
of highmem, or perhaps a shade more)  For userspace, there's no
practical difference between having 2.75 GB of address space and 2.875
GB given that I have only 1 GB of real RAM.

 - Roland
