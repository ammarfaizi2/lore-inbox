Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbTICACu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 20:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbTICACu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 20:02:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:35749 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261357AbTICACs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 20:02:48 -0400
Date: Tue, 2 Sep 2003 16:59:40 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: =?iso-8859-1?Q?=C9ric?= Brunet <Eric.Brunet@lps.ens.fr>
cc: <benh@kernel.crashing.org>, Mathieu LESNIAK <maverick@eskuel.com>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Power Management Update
In-Reply-To: <20030902235023.GA21645@lps.ens.fr>
Message-ID: <Pine.LNX.4.33.0309021657440.9537-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The result is a panic at different place when resuming from suspend to
> disk. Hand written partial debugging info:
> 
> EIP is at swsusp_arch_suspend
> eax: 07200720 ebx: 07200720 ecx: c1700000 edx=esi=edi=ebp=0 esp=df793fac
> Process swapper 
> Call trace:
> 	swsusp_restore
> 	pm_resume
> 	do_initcalls
> 	init_workqueues
> 	init
> 	init
> 	kernel_thread_helper
> Code: 8a 04 02 88 04 1a 0f 20 d8 0f 22 d8 a1 18 70 37 c0 8d 50 01
> Panic: attempted to kill init !

Ouch, thanks for the report. 

Can you tell me if and when swsusp last worked for you? 

> By the way, how comes the computer suspends when echoing 4 to
> /proc/acpi/sleep, and nothing happens when echoing disk to
> /sys/power/state ? Aren't those two things supposed to be equivalent ?
> Regards,

Try 'echo -n disk > /sys/power/state'.


	Pat

