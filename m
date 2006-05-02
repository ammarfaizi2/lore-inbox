Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbWEBGCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWEBGCU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 02:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWEBGCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 02:02:20 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:63112 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S932384AbWEBGCT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 02:02:19 -0400
Subject: [BUG] ACPI bug in 2.6.17-rc3
From: Kasper Sandberg <lkml@metanurb.dk>
To: LKML Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 02 May 2006 08:02:11 +0200
Message-Id: <1146549731.16874.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello.. just tried out 2.6.17-rc3 on my amd64 system, and i got this
backtrace:
khelper pid 4
trace:
activate_task+319 try_to_wake_up+93
__wake_up_common+68 complete+38
run_workqueue+136 worker_thread+353
default_wake_function+0 worker_thread+0
kthread+219 worke_thead+0
child_rip+8 worker_thread+0
kthread+0 child_rip+0

this happened immediately after vesafb changed resolution, i tried
without vesafb, still the same..



