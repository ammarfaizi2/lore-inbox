Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287657AbSANQzW>; Mon, 14 Jan 2002 11:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287720AbSANQzN>; Mon, 14 Jan 2002 11:55:13 -0500
Received: from zeus.kernel.org ([204.152.189.113]:17882 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S287657AbSANQyw>;
	Mon, 14 Jan 2002 11:54:52 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Daniel Phillips <phillips@bonn-fries.net>
To: J Sloan <jjs@pobox.com>,
        Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Mon, 14 Jan 2002 10:08:51 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020113201352Z288089-13997+4417@vger.kernel.org> <3C421946.6020607@pobox.com>
In-Reply-To: <3C421946.6020607@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <E16QAAF-0000mg-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 14, 2002 12:33 am, J Sloan wrote:
> Dieter Nützel wrote:
> >You told me that TUX show some problems with preempt before. What
> >problems? Are they TUX specific?
>
> On a kernel with both tux and preempt, upon
> access to the tux webserver the kernel oopses
> and tux dies...

Ah yes, I suppose this is because TUX uses per-cpu data as a replacement 
for spinlocks.  Patches that use per-cpu shared data have to be 
preempt-aware.  Ingo didn't know this when he wrote TUX since preempt didn't 
exist at that time and didn't even appear to be on the horizon.  He's 
certainly aware of it now.

> OTOH the low latency patch plays quite well
> with tux. As said, I have no anti-preempt agenda,
> I just need for whatever solution I use to work,
> and not crash programs and services we use.

Right, and of course that requires testing - sometimes a lot of it.  This one 
is a 'duh' that escaped notice. temporarily.  It probably would have been 
caught sooner if we'd started serious testing/discussion sooner.

--
Daniel
