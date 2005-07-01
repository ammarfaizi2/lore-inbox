Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263195AbVGAEi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263195AbVGAEi5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 00:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263199AbVGAEi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 00:38:57 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:12225 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263195AbVGAEi4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 00:38:56 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: 2.6.13-rc1 CONFIG_DEBUG_SPINLOCK is useless on SMP
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 01 Jul 2005 14:38:30 +1000
Message-ID: <6140.1120192710@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.13-rc1 built with SMP=Y and DEBUG_SPINLOCK=y.  That uses
kernel/spinlock.c instead of the inline definitions of the spinlock
functions.  Alas only the inline definitions test for DEBUG_SPINLOCK=y,
none of the code in in spinlock.c has any debug facilities.

