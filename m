Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274727AbRIUBDE>; Thu, 20 Sep 2001 21:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274729AbRIUBCo>; Thu, 20 Sep 2001 21:02:44 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18704 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274727AbRIUBCn>; Thu, 20 Sep 2001 21:02:43 -0400
Subject: Re: [PATCH] Preemption Latency Measurement Tool
To: roger.larsson@norran.net (Roger Larsson)
Date: Fri, 21 Sep 2001 02:03:37 +0100 (BST)
Cc: oxymoron@waste.org (Oliver Xymoron),
        Dieter.Nuetzel@hamburg.de (Dieter =?iso-8859-1?q?N=FCtzel?=),
        stefan@space.twc.de (Stefan Westerfeld), rml@tech9.net (Robert Love),
        andrea@suse.de (Andrea Arcangeli),
        linux-kernel@vger.kernel.org (linux-kernel),
        reiserfs-list@namesys.com (ReiserFS List)
In-Reply-To: <200109210047.f8L0lkv26045@maile.telia.com> from "Roger Larsson" at Sep 21, 2001 02:42:56 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15kEjB-0006n9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If this analysis is correct:
> We really need to run RT processes with RT priorities!
> 
> It is also possible that multimedia applications needs to be rewritten =
> to

I dont believe this is an application problem. Applications allocating
memory can end up doing page outs for other people. Its really important
they dont get stuck doing a huge amount of pageout work for someone else.
Thats one thing I seem to be seeing with the 10pre11 VM.

Sound cards have a lot of buffering, we are talking 64-128Kbytes + on card
buffers. Thats 0.25-0.5 seconds at 48Khz 16bit stereo

Alan
