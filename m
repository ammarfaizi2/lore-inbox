Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbTFCUwz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 16:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbTFCUwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 16:52:55 -0400
Received: from aneto.able.es ([212.97.163.22]:59601 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S261244AbTFCUwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 16:52:54 -0400
Date: Tue, 3 Jun 2003 23:06:17 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: davidm@hpl.hp.com
Subject: no-omit-frame-pointer for sched.c in 2.4-i386
Message-ID: <20030603210617.GE3661@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

Any body knows if this still applies:

kernel/Makefile

ifneq ($(CONFIG_IA64),y)
# According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
# needed for x86 only.  Why this used to be enabled for all architectures is beyond
# me.  I suspect most platforms don't need this, but until we know that for sure
# I turn this off for IA-64 only.  Andreas Schwab says it's also needed on m68k
# to get a correct value for the wait-channel (WCHAN in ps). --davidm
CFLAGS_sched.o := $(PROFILING) -fno-omit-frame-pointer
endif


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-rc6-jam1 (gcc 3.2.3 (Mandrake Linux 9.2 3.2.3-1mdk))
