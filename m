Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265209AbSJaH4T>; Thu, 31 Oct 2002 02:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265210AbSJaH4T>; Thu, 31 Oct 2002 02:56:19 -0500
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:36014 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S265209AbSJaH4R>; Thu, 31 Oct 2002 02:56:17 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.45 - oops in reap_timer_fnc
Date: Thu, 31 Oct 2002 09:02:55 +0100
User-Agent: KMail/1.4.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200210310902.55414.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got this on booting 2.5.45.  Not seen on subsequent reboot.
I was too lazy to copy everything down, plus not everything
was on screen.

EIP is at free_block+0x4e/0xe4

Call trace:
reap_timer_fnc
run_timer_tasklet
reap_timer_fnc
tasklet_hi_action
do_softirq
do_IRQ
common_interrupt
system_call

Arf!  Killed in interrupt handler etc.
