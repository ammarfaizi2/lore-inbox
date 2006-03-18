Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbWCRPSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWCRPSO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 10:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932774AbWCRPSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 10:18:13 -0500
Received: from 213-239-205-134.clients.your-server.de ([213.239.205.134]:44507
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932387AbWCRPSN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 10:18:13 -0500
Message-Id: <20060318142827.419018000@localhost.localdomain>
Date: Sat, 18 Mar 2006 15:18:24 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Tom Rini <trini@kernel.crashing.org>
Subject: [patch 0/2] sys_setitimer and sys_alarm hotfixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Tom Rini pointed out a LTP test failure in the preempt-rt tree.
I verified against mainline and following fixups are needed.

The setitimer values from userspace are not validated. Non canonical
values were silently converted by the pre hrtimer code. 
This silent conversion also happened for the unsigned to signed 
conversion for sys_alarm.

This should go into 2.6.16

	tglx
--

