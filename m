Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbVLYJnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbVLYJnX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 04:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbVLYJnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 04:43:23 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:37292 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750808AbVLYJnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 04:43:22 -0500
Date: Sun, 25 Dec 2005 10:43:19 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Ingo Molnar <mingo@elte.hu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.15-rc5-rt4 fails to compile
In-Reply-To: <20051222231153.GA4316@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0512251041070.27576@yvahk01.tjqt.qr>
References: <20051222231153.GA4316@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,


CONFIG_RWSEM_GENERIC_SPINLOCK is always y when PREEMPT_RT=y, but (see 
linux/rwsem.h) in this case, <linux/rwsem-semaphore.h> is included, which 
lacks macros like RWSEM_ACTIVE_BIAS used in lib/rwsem.c.


Jan Engelhardt
-- 
