Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbUBUKIU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 05:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbUBUKIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 05:08:20 -0500
Received: from 0x50c49cd1.adsl-fixed.tele.dk ([80.196.156.209]:64516 "EHLO
	redeeman") by vger.kernel.org with ESMTP id S261538AbUBUKIS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 05:08:18 -0500
Message-ID: <1271.192.168.1.7.1077358097.squirrel@redeeman.linux.dk>
In-Reply-To: <20040220230529.GB32153@elf.ucw.cz>
References: <33009.192.168.1.7.1077217546.squirrel@redeeman.linux.dk>
    <20040220230529.GB32153@elf.ucw.cz>
Date: Sat, 21 Feb 2004 11:08:17 +0100 (CET)
Subject: Re: powernow-k8 havent been tested on preemptive - have now
From: "Redeeman" <redeeman@metanurb.dk>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mime-Autoconverted: from 8bit to 7bit by courier 0.44
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yes, this is how i fixed it myself too, but i thought it would need more
than this. but obviously not.

Greets, Redeeman


> Hi!
>
>> hi, i have been seeing the message that powernow-k8 havent been tested
>> on
>> a preemptive system, for a couple of kernel versions i have been
>> running,
>> and i just want to tell you that it is working absolutely perfect, great
>> job!
>>
>> if there is any questions/comments i would be glad if you would cc them
>> to
>> redeeman@<no-spam>metanurb.dk , thanks!
>
> Okay, in such case we should probably do this:
> 									Pavel
>
> --- tmp/linux/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2004-02-21
> 00:04:41.000000000 +0100
> +++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2004-02-21
> 00:04:20.000000000 +0100
> @@ -34,10 +34,6 @@
>  #define VERSION "version 1.00.08a"
>  #include "powernow-k8.h"
>
> -#ifdef CONFIG_PREEMPT
> -#warning this driver has not been tested on a preempt system
> -#endif
> -
>  static u32 vstable;	/* voltage stabalization time, from PSB, units 20 us
> */
>  static u32 plllock;	/* pll lock time, from PSB, units 1 us */
>  static u32 numps;	/* number of p-states, from PSB */
>
>
> --
> When do you have a heart between your knees?
> [Johanka's followup: and *two* hearts?]
>
>

