Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbTIMTak (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 15:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbTIMTak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 15:30:40 -0400
Received: from home.nightdaughter.de ([194.95.224.141]:22538 "EHLO
	a141.shuttle.de") by vger.kernel.org with ESMTP id S262162AbTIMTai
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 15:30:38 -0400
Date: Sat, 13 Sep 2003 21:30:36 +0200
From: Joerg Hoh <joerg@devone.org>
To: linux-kernel@vger.kernel.org
Subject: [SEGFAULT] waking up from S3 fails (ACPI)
Message-ID: <20030913193036.GB3616@hydra.joerghoh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

The kernel crashes when I want to wake up the systems from Suspend to RAM
(S3). Kernel is 2.6.0-test5 on a IBM R32 Notebook.

When I do the

echo -n "mem" >> /sys/power/state

the notebook goes immediately off (no led is on. When I do suspend to RAM 
via APM, there is still a led on - the halfmoon one). Pressing the power button 
turns the notebook on (the display is on) and there are some messages on
the console (don't know, which are from going to suspend and which are from 
trying to wake up):

hdc: start_power_step(step:0)
hdc: completing PM request, suspend
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_request(step:1, stat:50, err: 0)
hda: completing PM request suspend
 hwsleep-0257 [29] acpi_enter_sleep_state: Entering sleep state [S1]
double fault, gdt at c0449a80 [255 bytes]
double fault, tss at c04d5800
eip = 00000000, esp = 00000000
eax = 00000000, ebx = 00000000, ecx = 00000000, edx = 00000000
esi = 00000000, edi = 00000000


Joerg

-- 
...Wenn man sich bei NetBSD auf eines verlassen kann, dann: Egal, WAS[...]
man updated, mplayer hat mit Sicherheit dependencies drauf.
  Rene Schickbauer, news:2591532.ZKZXAUW3eG@gandalf.grumpfzotz.org
