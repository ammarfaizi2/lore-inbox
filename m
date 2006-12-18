Return-Path: <linux-kernel-owner+w=401wt.eu-S1754192AbWLRP7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754192AbWLRP7W (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 10:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754193AbWLRP7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 10:59:22 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:36252 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754192AbWLRP7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 10:59:21 -0500
Date: Mon, 18 Dec 2006 16:57:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Jiri Slaby <jirislaby@gmail.com>
Subject: bug: isicom: kobject_add failed for ttyM0 with -EEXIST
Message-ID: <20061218155714.GA21823@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -0.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-0.4 required=5.9 tests=BAYES_05 autolearn=no SpamAssassin version=3.0.3
	-0.4 BAYES_05               BODY: Bayesian spam probability is 1 to 5%
	[score: 0.0203]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


allyesconfig bzImage bootup produced 33 warning messages, of which the 
first couple are attached below.

	Ingo

--------------->
Calling initcall 0xc0628d59: isicom_setup+0x0/0x315()
kobject_add failed for ttyM0 with -EEXIST, don't try to register things with the same name in the same directory.
 [<c0106273>] show_trace_log_lvl+0x34/0x4a
 [<c01063a9>] show_trace+0x2c/0x2e
 [<c01063d6>] dump_stack+0x2b/0x2d
 [<c04f06a3>] kobject_add+0x15f/0x187
 [<c06e3421>] class_device_add+0xb5/0x45c
 [<c06e37e5>] class_device_register+0x1d/0x21
 [<c06e3892>] class_device_create+0xa9/0xcc
 [<c05f8a5c>] tty_register_device+0xe3/0xea
 [<c05f97fa>] tty_register_driver+0x202/0x21e
 [<c0628fa3>] isicom_setup+0x24a/0x315
 [<c0100567>] init+0x178/0x451
 [<c0105feb>] kernel_thread_helper+0x7/0x10
 =======================
kobject_add failed for ttyM1 with -EEXIST, don't try to register things with the same name in the same directory.
 [<c0106273>] show_trace_log_lvl+0x34/0x4a
 [<c01063a9>] show_trace+0x2c/0x2e
 [<c01063d6>] dump_stack+0x2b/0x2d
 [<c04f06a3>] kobject_add+0x15f/0x187
 [<c06e3421>] class_device_add+0xb5/0x45c
 [<c06e37e5>] class_device_register+0x1d/0x21
 [<c06e3892>] class_device_create+0xa9/0xcc
 [<c05f8a5c>] tty_register_device+0xe3/0xea
 [<c05f97fa>] tty_register_driver+0x202/0x21e
 [<c0628fa3>] isicom_setup+0x24a/0x315
 [<c0100567>] init+0x178/0x451
 [<c0105feb>] kernel_thread_helper+0x7/0x10
 =======================
kobject_add failed for ttyM2 with -EEXIST, don't try to register things with the same name in the same directory.
 [<c0106273>] show_trace_log_lvl+0x34/0x4a
 [<c01063a9>] show_trace+0x2c/0x2e
 [<c01063d6>] dump_stack+0x2b/0x2d
 [<c04f06a3>] kobject_add+0x15f/0x187
 [<c06e3421>] class_device_add+0xb5/0x45c
 [<c06e37e5>] class_device_register+0x1d/0x21
 [<c06e3892>] class_device_create+0xa9/0xcc
 [<c05f8a5c>] tty_register_device+0xe3/0xea
 [<c05f97fa>] tty_register_driver+0x202/0x21e
 [<c0628fa3>] isicom_setup+0x24a/0x315
 [<c0100567>] init+0x178/0x451
 [<c0105feb>] kernel_thread_helper+0x7/0x10
 =======================
kobject_add failed for ttyM3 with -EEXIST, don't try to register things with the same name in the same directory.
