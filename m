Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266241AbUAQXqK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 18:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266245AbUAQXqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 18:46:09 -0500
Received: from dsl-hkigw4j21.dial.inet.fi ([80.222.57.33]:51842 "EHLO
	dsl-hkigw4j21.dial.inet.fi") by vger.kernel.org with ESMTP
	id S266241AbUAQXps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 18:45:48 -0500
Date: Sun, 18 Jan 2004 01:45:46 +0200 (EET)
From: Petri Koistinen <petri.koistinen@iki.fi>
X-X-Sender: petri@dsl-hkigw4j21.dial.inet.fi
To: len.brown@intel.com
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: 2.6 kernel jam: acpi_processor_set_thermal_limit problem?
Message-ID: <Pine.LNX.4.58.0401180115160.1008@dsl-hkigw4j21.dial.inet.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

My computer hanged today when running latest linux 2.6 kernel (synced
today, from rsync/cvs). I noticed this from /var/log/kern.log after I had
rebooted machine by hand.

kernel: Warning: kfree_skb on hard IRQ c0396684
kernel: bad: scheduling while atomic!
kernel: Call Trace:
kernel:  [<c0119893>] schedule+0x563/0x570
kernel:  [acpi_processor_set_thermal_limit+1022229/1118449] tcp_poll+0x34/0x160
kernel:  [<c0124fc5>] schedule_timeout+0xb5/0xc0
kernel:  [acpi_processor_set_thermal_limit+893242/1118449] sock_poll+0x29/0x40
kernel:  [<c016079f>] do_pollfd+0x4f/0x90
kernel:  [<c016088a>] do_poll+0xaa/0xd0
kernel:  [<c0160a46>] sys_poll+0x196/0x290
kernel:  [<c015fdb0>] __pollwait+0x0/0xd0
kernel:  [<c0108f47>] syscall_call+0x7/0xb

and this repeated many times on log. More info, too much to be include
here, is available at http://juu.ath.cx/~petri/kernel-jam-2004-01-17/
including System.map, config, kern.log, info about machine and kernel
image. I am happy to help more, if I can.

Best regards,
Petri Koistinen
