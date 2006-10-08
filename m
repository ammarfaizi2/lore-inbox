Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWJHVxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWJHVxS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 17:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWJHVxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 17:53:18 -0400
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:37905 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751491AbWJHVxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 17:53:17 -0400
Message-ID: <4529734B.7070707@superbug.co.uk>
Date: Sun, 08 Oct 2006 22:53:15 +0100
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Thunderbird 1.5.0.7 (X11/20060917)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.18-rt5 crashes with netconsole enabled. (bug#7288)
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Does anyone have any clues where I can find help regarding the rt kernels?

Please see kernel bug entry:
http://bugzilla.kernel.org/show_bug.cgi?id=7288
Description: 2.6.18-rt5 crashes with netconsole enabled. (bug#7288)

Full console trace attached to bug report.
Extract of console trace of crash/hang:

modprobe/8459[CPU#1]: BUG in write_msg at drivers/net/netconsole.c:85
5/0x67
 [<c012274d>] _call_console_drivers+0x4e/0x52
 [<c0122d92>] release_console_sem+0x12a/0x1dc
 [<c0122ac7>] vprintk+0x299/0x2e1
 [<c0122b24>] printk+0x15/0x17
 [<f8991090>] init_netconsole+0x75/0x80 [netconsole]
 [<c013dbec>] sys_init_module+0x1597/0x175d
 [<c0102f99>] sysenter_past_esp+0x56/0x79
modprobe/8459[CPU#1]: BUG in write_msg at drivers/net/netconsole.c:87
 [<c0103f92>] show_trace+0x16/0x19
 [<c0104583>] dump_stack+0x1a/0x1f
 [<c01234aa>] __WARN_ON+0x41/0x57
 [<f899112c>] write_msg+0x91/0xc9 [netconsole]
 [<c01226ed>] __call_console_drivers+0x55/0x67
 [<c012274d>] _call_console_drivers+0x4e/0x52
 [<c0122d92>] release_console_sem+0x12a/0x1dc
 [<c0122ac7>] vprintk+0x299/0x2e1
 [<c0122b24>] printk+0x15/0x17
 [<f8991090>] init_netconsole+0x75/0x80 [netconsole]
 [<c013dbec>] sys_init_module+0x1597/0x175d
 [<c0102f99>] sysenter_past_esp+0x56/0x79
modprobe/8459[CPU#1]: BUG in write_msg at drivers/net/netconsole.c:85
 [<c0103f92>] show_trace+0x16/0x19
 [<c0104583>] dump_stack+0x1a/0x1f
 [<c01234aa>] __WARN_ON+0x41/0x57
 [<f8991102>] write_msg+0x67/0xc9 [netconsole]
 [<c01226ed>] __call_console_drivers+0x55/0x67
 [<c012274d>] _call_console_drivers+0x4e/0x52
le+0x1597/0x175d
 [<c0102f99>] sysenter_past_esp+0x56/0x79
modprobe/8459[CPU#1]: BUG in write_msg at drivers/net/netconsole.c:87
