Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262903AbTIGHtH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 03:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbTIGHtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 03:49:06 -0400
Received: from law10-oe29.law10.hotmail.com ([64.4.14.86]:14345 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262903AbTIGHtE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 03:49:04 -0400
X-Originating-IP: [208.48.228.132]
X-Originating-Email: [jyau_kernel_dev@hotmail.com]
From: "Johnny Yau" <jyau_kernel_dev@hotmail.com>
To: "Nick Piggin" <piggin@cyberone.com.au>
Cc: "'Robert Love'" <rml@tech9.net>, <linux-kernel@vger.kernel.org>
References: <000201c374c8$1124ee20$f40a0a0a@Aria> <3F5ABE90.2040003@cyberone.com.au>
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
Date: Sun, 7 Sep 2003 03:48:57 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Message-ID: <Law10-OE296cRyiOYbp00008b23@hotmail.com>
X-OriginalArrivalTime: 07 Sep 2003 07:49:03.0889 (UTC) FILETIME=[8217A810:01C37514]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> Heh, your logic is entertaining. I don't know how you got from step 1
> to step 3 ;)

LOL...I got a bit scatterbrained.  My basic argument is the fewer context
switches while maintaining interactivity the better because it's less
overhead and less cache thrashing.  If we don't care about the overhead and
thrashing at all, then might as well be very aggressive with the scheduler
and use uniform 1 ms timeslices in a RR fashion.  I've coded such a
scheduler in an embedded systems context; response time is awesome, but I
highly doubt it'd work for Linux workloads.

>
> Anyway, you don't have to dump different timeslice lengths because you
> don't really have them to begin with. See how "Nick's scheduler policy
> v12" fixes your problems by mostly reducing complexity, not adding to
> it.
>

I just started monitoring the list and I'm still quite a bit behind, so I'm
playing catch up on reading whenever I have a bit of free time.  I'll look
for your patch and check out your code.


John Yau
