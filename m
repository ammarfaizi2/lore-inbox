Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131526AbRCUQdE>; Wed, 21 Mar 2001 11:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131626AbRCUQcy>; Wed, 21 Mar 2001 11:32:54 -0500
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:29472 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S131526AbRCUQcr>; Wed, 21 Mar 2001 11:32:47 -0500
Date: Wed, 21 Mar 2001 11:32:05 -0500 (EST)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: SMP on assym. x86
In-Reply-To: <20010321165541.H3514@garloff.casa-etp.nl>
Message-ID: <Pine.LNX.4.10.10103211122500.10337-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> recently upgrading one of my two CPUs, I found kernel-2.4.2 to be unable to
> handle the situation with 2 different CPUs (AMP = Assymmetric
> multiprocessing ;-) correctly.

"correctly".  Intel doesn't support this (mis)configuration:
especially with different steppings, not to mention models.

Alan has, or is working on, a workaround to handle differing 
multipliers by turning off the use of RDTSC.  this is the right approach 
to take in the kernel: disable features not shared by both processors, 
so correctly-configured machines are not penalized. 
and the kernel should LOUDLY WARN ABOUT this stuff on boot.

regards, mark hahn.

