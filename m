Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266681AbUBMCGW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 21:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266682AbUBMCGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 21:06:22 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:59324 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266681AbUBMCGR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 21:06:17 -0500
Message-ID: <402C30F7.9040407@cyberone.com.au>
Date: Fri, 13 Feb 2004 13:05:43 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: Helge Hafting <helgehaf@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       Michael Frank <mhf@linuxmail.org>, Giuliano Pochini <pochini@shiny.it>,
       Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: ext2/3 performance regression in 2.6 vs 2.4 for small interl
References: <XFMail.20040212104215.pochini@shiny.it> <402B5502.2010207@cyberone.com.au> <200402130105.22554.mhf@linuxmail.org> <200402121718.i1CHITFf018390@turing-police.cc.vt.edu> <20040212205503.GA13934@hh.idb.hist.no> <20040213015757.GC25499@mail.shareable.org>
In-Reply-To: <20040213015757.GC25499@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jamie Lokier wrote:

>Helge Hafting wrote:
>
>>Something similiar could be done for io niceness.  If we run out of
>>normal priority io, how about not issuing the low priority io
>>right away.  Anticipate there will be more high-priority io
>>and wait for some idle time before letting low-priority
>>requests through.  And of course some maximum wait to prevent
>>total starvation.
>>
>
>The problem is quite similar to scheduling for quality on a network
>device.  Once a packet has started going it, usually you cannot abort
>the packet for a higher priority one.
>
>I thought there was a CBQ I/O scheduling patch or such to offer some
>kind of I/O niceness these days?
>
>

Yeah its Jens' CFQ io scheduler. It is in -mm, and I think it
has adjustable priorities now.

I have plans to do IO priorities in the anticipatory scheduler
(significantly differently to CFQ). One day...

