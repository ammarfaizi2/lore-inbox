Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbTKZOOZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 09:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbTKZOOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 09:14:24 -0500
Received: from bay2-f116.bay2.hotmail.com ([65.54.247.116]:24584 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262569AbTKZOOW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 09:14:22 -0500
X-Originating-IP: [212.143.73.102]
X-Originating-Email: [yuval_yeret@hotmail.com]
From: "yuval yeret" <yuval_yeret@hotmail.com>
To: sct@redhat.com, khali@linux-fr.org
Cc: linux-kernel@vger.kernel.org, yuval@exanet.com
Subject: Re: 2.4.20-18 size-4096 memory leaks
Date: Wed, 26 Nov 2003 16:14:21 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY2-F116ARR9DCsLXN00011c97@hotmail.com>
X-OriginalArrivalTime: 26 Nov 2003 14:14:22.0078 (UTC) FILETIME=[96A759E0:01C3B427]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: "Stephen C. Tweedie" <sct@redhat.com>
>
>That's not a leak, it simply sounds like cache effects.  atime updates
>result in journal commits under ext3, and those use at least a couple of
>buffers at a time (one for the metadata descriptor block in the journal,
>one for the journal commit.)  Those aren't leaks --- they are temporary
>use of cache, and once the IO has complete the memory can be immediately
>reclaimed by the kernel if it is needed for anything else.

I'm using noatime for my ext3 mount points ...

>
>Cheers,
>  Stephen
>
>

_________________________________________________________________
Help STOP SPAM with the new MSN 8 and get 2 months FREE*  
http://join.msn.com/?page=features/junkmail

