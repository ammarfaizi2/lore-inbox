Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262582AbTCURjO>; Fri, 21 Mar 2003 12:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262583AbTCURjO>; Fri, 21 Mar 2003 12:39:14 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:33696 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S262582AbTCURjN>; Fri, 21 Mar 2003 12:39:13 -0500
Date: Fri, 21 Mar 2003 17:50:11 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.65 RCU oops.
Message-ID: <20030321175011.GB15652@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hand transcribed oops (top bit missing from screen unfortunatly,
and box locked up solid).

Call trace:
 d_callback
 d_callback
 rcu_do_batch
 rcu_process_callbacks
 timer_interrupt
 tasklet_action
 do_softirq
 do_IRQ
 common_interrupt
 acpi_processor_idle
 default_idle
 cpu_idle
 _stext

Code: 0f 0b 2e 06 d6 de 54 c0 e9 d7 fe ff ff 8b 55 08 8b 5a 34 e9

Judging by the Code: line, it hit a BUG() somewhere, but the
rest of the code line looks like gibberish. Worst still, an
objdump -D of the vmlinux doesn't have the corresponding 
bytes in that order.  kernel text corruption ?

		Dave

