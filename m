Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131834AbRCUXkZ>; Wed, 21 Mar 2001 18:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131836AbRCUXkG>; Wed, 21 Mar 2001 18:40:06 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:58897 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131834AbRCUXjv>; Wed, 21 Mar 2001 18:39:51 -0500
Subject: Re: SMP on assym. x86
To: hahn@coffee.psychology.mcmaster.ca (Mark Hahn)
Date: Wed, 21 Mar 2001 23:41:33 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux kernel list)
In-Reply-To: <Pine.LNX.4.10.10103211122500.10337-100000@coffee.psychology.mcmaster.ca> from "Mark Hahn" at Mar 21, 2001 11:32:05 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14fsET-0001Mg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > handle the situation with 2 different CPUs (AMP = Assymmetric
> > multiprocessing ;-) correctly.
> 
> "correctly".  Intel doesn't support this (mis)configuration:
> especially with different steppings, not to mention models.

Actually for a lot of cases its quite legal.

> Alan has, or is working on, a workaround to handle differing 
> multipliers by turning off the use of RDTSC.  this is the right approach 
> to take in the kernel: disable features not shared by both processors, 
> so correctly-configured machines are not penalized. 
> and the kernel should LOUDLY WARN ABOUT this stuff on boot.

I've been working on reading the multipliers directly from the MSR 0x2A data,
Kurt is redoing the timing each run - possibly thats not so clean but its 
more robust.

I rather like Kurt's patch
