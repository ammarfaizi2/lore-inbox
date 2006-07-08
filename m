Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbWGHNL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWGHNL2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 09:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWGHNL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 09:11:28 -0400
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:63391 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S964823AbWGHNL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 09:11:28 -0400
To: linux-kernel@vger.kernel.org
Subject: lockdep BUG: warning (2.6.18-rc1, TP T60)
Date: Sat, 08 Jul 2006 14:11:21 +0100
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FzCaf-0003OL-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying 2.6.18-rc1 on a Thinkpad T60 (dual-core T2400, SATA hard
drive) running Ubuntu 6.06.  The kernel is SMP and PREEMPT and has
many lock validation options turned on.  During boot the lockdep
checker reports good news:

[   20.936404] Good, all 218 testcases passed! |

When I pressed Fn-F4 (for suspend-to-ram), it began to suspend,
blanked the screen, and then came back right away to the X session.  I
don't think it ever made it into suspend mode (I've reported the
suspend problem to linux-acpi).  And this lockdep warning showed up:

[  459.756000] BUG: warning at kernel/lockdep.c:1799/trace_hardirqs_on()
[  459.756000]  [<c0105aeb>] show_trace+0x1b/0x20
[  459.756000]  [<c0105b14>] dump_stack+0x24/0x30
[  459.756000]  [<c013c186>] trace_hardirqs_on+0x166/0x180
[  459.756000]  [<c010522d>] do_general_protection+0xcd/0x220
[  459.756000]  [<c0103e01>] error_code+0x39/0x40

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
