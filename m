Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbTIYRnG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 13:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbTIYRl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 13:41:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:54470 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261709AbTIYRkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 13:40:43 -0400
Date: Thu, 25 Sep 2003 10:36:54 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@localhost.localdomain
To: Joerg Hoh <joerg@devone.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [SEGFAULT] waking up from S3 fails (ACPI)
In-Reply-To: <20030913193036.GB3616@hydra.joerghoh.de>
Message-ID: <Pine.LNX.4.44.0309251035020.947-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The kernel crashes when I want to wake up the systems from Suspend to RAM
> (S3). Kernel is 2.6.0-test5 on a IBM R32 Notebook.

Sorry about the delay in getting back to you. 

> When I do the
> 
> echo -n "mem" >> /sys/power/state
> 
> the notebook goes immediately off (no led is on. When I do suspend to RAM 
> via APM, there is still a led on - the halfmoon one). Pressing the power button 
> turns the notebook on (the display is on) and there are some messages on
> the console (don't know, which are from going to suspend and which are from 
> trying to wake up):
> 
> hdc: start_power_step(step:0)
> hdc: completing PM request, suspend
> hda: start_power_step(step: 0)
> hda: start_power_step(step: 1)
> hda: complete_power_request(step:1, stat:50, err: 0)
> hda: completing PM request suspend
>  hwsleep-0257 [29] acpi_enter_sleep_state: Entering sleep state [S1]
> double fault, gdt at c0449a80 [255 bytes]
> double fault, tss at c04d5800
> eip = 00000000, esp = 00000000
> eax = 00000000, ebx = 00000000, ecx = 00000000, edx = 00000000
> esi = 00000000, edi = 00000000

That's not a segfault, that's a double fault - much more interesting. :) 

Could you send me the output of 'cat /proc/cpuinfo' and 'lspci -v' please?

Thanks,


	Pat

