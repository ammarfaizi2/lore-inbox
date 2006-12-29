Return-Path: <linux-kernel-owner+w=401wt.eu-S1755052AbWL2ROB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755052AbWL2ROB (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 12:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755055AbWL2ROB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 12:14:01 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:57310 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755042AbWL2ROA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 12:14:00 -0500
Date: Fri, 29 Dec 2006 18:13:11 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Sergei Organov <osv@javad.com>
cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: irq 4: nobody cared and I/O errors on serial ports.
In-Reply-To: <874prfm42p.fsf@javad.com>
Message-ID: <Pine.LNX.4.61.0612291808220.9799@yvahk01.tjqt.qr>
References: <874prfm42p.fsf@javad.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 29 2006 12:41, Sergei Organov wrote:
>
>It seems that the kernel has some problems/races in opening/closing of
>serial ports. Simple C program below just opens/closes a port in a loop:
>[..]
>I've noticed 2 problems running this program. I run 2.6.19.1 smp kernel
>(I've also tested Debian 2.6.18.3 kernel, and it has the same issues) on
>hyper-threaded Pentium 4 CPU.

Also happens on 2.6.18.5 on AMD AXP2000 (UP, CONFIG_SMP=y), standard 
x86 pc serial port
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A

>1. When I run the program, I begin to get "irq 4: nobody cared" in dmesg even
>   though the port is not connected (idle). Please find relevant part of dmesg
>   below.

Running said program repeatedly produces one stack trace every 4 
seconds (CONFIG_HZ=100). Maybe knowing this interval helps finding the 
problem.
[ 9545.167750] Disabling IRQ #4
[ 9549.599704] Disabling IRQ #4
[ 9554.034803] Disabling IRQ #4
[ 9558.455093] Disabling IRQ #4
[ 9562.876508] Disabling IRQ #4


	-`J'
-- 
