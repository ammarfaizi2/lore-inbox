Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbUBTXF5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 18:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbUBTXF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 18:05:57 -0500
Received: from gprs151-132.eurotel.cz ([160.218.151.132]:28290 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261409AbUBTXFs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 18:05:48 -0500
Date: Sat, 21 Feb 2004 00:05:30 +0100
From: Pavel Machek <pavel@ucw.cz>
To: redeeman@redeeman.linux.dk, redeeman@metanurb.dk
Cc: linux-kernel@vger.kernel.org,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: Re: powernow-k8 havent been tested on preemptive - have now
Message-ID: <20040220230529.GB32153@elf.ucw.cz>
References: <33009.192.168.1.7.1077217546.squirrel@redeeman.linux.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33009.192.168.1.7.1077217546.squirrel@redeeman.linux.dk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> hi, i have been seeing the message that powernow-k8 havent been tested on
> a preemptive system, for a couple of kernel versions i have been running,
> and i just want to tell you that it is working absolutely perfect, great
> job!
> 
> if there is any questions/comments i would be glad if you would cc them to
> redeeman@<no-spam>metanurb.dk , thanks!

Okay, in such case we should probably do this:
									Pavel

--- tmp/linux/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2004-02-21 00:04:41.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2004-02-21 00:04:20.000000000 +0100
@@ -34,10 +34,6 @@
 #define VERSION "version 1.00.08a"
 #include "powernow-k8.h"
 
-#ifdef CONFIG_PREEMPT
-#warning this driver has not been tested on a preempt system
-#endif
-
 static u32 vstable;	/* voltage stabalization time, from PSB, units 20 us */
 static u32 plllock;	/* pll lock time, from PSB, units 1 us */
 static u32 numps;	/* number of p-states, from PSB */


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
