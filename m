Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbVADOVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbVADOVD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 09:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVADOVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 09:21:03 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:11999 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261653AbVADOU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 09:20:59 -0500
Date: Mon, 3 Jan 2005 10:42:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Georg Schild <dangertools@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cpu throttling powernow-k8 and acpi in kernel
Message-ID: <20050103094245.GD2473@openzaurus.ucw.cz>
References: <41D80CAB.1060903@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41D80CAB.1060903@gmx.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have an acer aspire 1501 lmi with amd64 @3000+. i am running a 
> gentoo 64bit dist with vanilla 2.6.10 kernel on it.
> 
> i encounter some problems with the speed throttling of the cpu. this 
> kind of cpu has 3 steps which a gouvernor can reach, 1800, 1600 and 
> 800Mhz. i am using the ondemand gouvernor. so far this works quite 
> good, ondemand puts it at 800 until i do something. as it should be. 
> i have also CONFIG_ACPI_PROCESSOR=y and CONFIG_ACPI_THERMAL=y 
> enabled. when acpi thinks the temperature is too high (95 for cpu) 
> it throttles the cpu down to 800Mhz, no care what ondemand tells it. 
> okay, why not, is a good protection for overheating. but i don't 
> think the cpu has 95, i have run the laptop much hotter once, and 
> there was no downthrottling. it cannot be that i am not able to 
> compile a simple package without getting a critical temperature. i am 
> watching the temps in gkrellm and this leads me to the thing that 
> there is something wrong with it cause it jumps a bit when the temps 
> are getting higher and one thing more, when the laptop is doing 
> nothing, e.g. over night, screen is off, cpu is at 800 the temp is 
> still at about 55 and more, how can that be? but i cannot disable 
> the two acpi-options mentionend above. at first the cpu runs at 800, 
> no problem, fan is almost off. but when i start e.g. a compilation 
> first the fan starts spinning up a bit, the cpu goes to 1800mhz but 
> after a while the fan gives all the speed it is able to, much noise, 
> and after one or 2 minutes the laptop switches off immediate.
> 

It seems your machine indeed is overheating. Modern cpus produce a lot
of heat.

55C idle temperature seems okay. Open machine and attach your
own temperature sensor to cpu to verify...
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

