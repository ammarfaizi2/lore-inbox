Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030225AbWJ2UzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbWJ2UzJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 15:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030229AbWJ2UzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 15:55:09 -0500
Received: from holoclan.de ([62.75.158.126]:42411 "EHLO mail.holoclan.de")
	by vger.kernel.org with ESMTP id S1030225AbWJ2UzG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 15:55:06 -0500
Date: Sat, 28 Oct 2006 22:01:51 +0200
From: Martin Lorenz <martin@lorenz.eu.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.19-rc3: more DWARFs and strange messages
Message-ID: <20061028200151.GC5619@gimli>
Mail-Followup-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "www.holoclan.de", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  With my recent kernel pulled from git on friday I see
	quite some DWARFs and other strange messages. lots of those:
	[18038.721000] thinkpad_ec: thinkpad_ec_request_row: bad end STR3:
	(0x11:0x00)->0x80 [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With my recent kernel pulled from git on friday I see quite some DWARFs and
other strange messages.

lots of those:
[18038.721000] thinkpad_ec: thinkpad_ec_request_row: bad end STR3:
(0x11:0x00)->0x80

this was said to be triggered by the combination of hdaps and tp_smapi but I
do not load the tp_smapi module ...
hdaps is configured

and quite a few of those:

[18504.980000] BUG: warning at kernel/cpu.c:56/unlock_cpu_hotplug()
[18504.980000]  [<c0103bdd>] dump_trace+0x69/0x1af
[18504.980000]  [<c0103d3b>] show_trace_log_lvl+0x18/0x2c
[18504.980000]  [<c01043da>] show_trace+0xf/0x11
[18504.980000]  [<c01044dd>] dump_stack+0x15/0x17
[18504.980000]  [<c0135e94>] unlock_cpu_hotplug+0x3d/0x66
[18504.980000]  [<f92e67f3>] do_dbs_timer+0x1c2/0x229 [cpufreq_ondemand]
[18504.980000]  [<c012ccb1>] run_workqueue+0x83/0xc5
[18504.980000]  [<c012d5d5>] worker_thread+0xd9/0x10c
[18504.980000]  [<c012fb36>] kthread+0xc2/0xf0
[18504.980000]  [<c010398b>] kernel_thread_helper+0x7/0x10
[18504.980000] DWARF2 unwinder stuck at kernel_thread_helper+0x7/0x10
[18504.980000]
[18504.980000] Leftover inexact backtrace:
[18504.980000]
[18504.980000]  =======================


full config and dmesg is in
http://www.lorenz.eu.org/~mlo/kernel/config.2.6.19-rc3-e1-ie-tp-43.3+1757-g18462d6b-dirty.gz
http://www.lorenz.eu.org/~mlo/kernel/dmesg.2.6.19-rc3-e1-ie-tp-43.3+1757-g18462d6b-dirty.boot
http://www.lorenz.eu.org/~mlo/kernel/dmesg.2.6.19-rc3-e1-ie-tp-43.3+1757-g18462d6b-dirty.run

and more
http://www.lorenz.eu.org/~mlo/kernel/?C=M;O=D

greets
  mlo
--
Dipl.-Ing. Martin Lorenz

            They that can give up essential liberty 
	    to obtain a little temporary safety 
	    deserve neither liberty nor safety.
                                   Benjamin Franklin

please encrypt your mail to me
GnuPG key-ID: F1AAD37D
get it here:
http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0xF1AAD37D

ICQ UIN: 33588107
