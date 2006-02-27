Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbWB0Whn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWB0Whn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWB0WgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:36:23 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:24449 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932380AbWB0Wby
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:31:54 -0500
Message-Id: <20060227223347.377860000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:14 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 14/39] [PATCH] Fix s390 build failure.
Content-Disposition: inline; filename=fix-s390-build-failure.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

arch/s390/kernel/compat_signal.c:199: error: conflicting types for 'do_sigaction'
include/linux/sched.h:1115: error: previous declaration of 'do_sigaction' was here

Signed-off-by: Dave Jones <davej@redhat.com>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 arch/s390/kernel/compat_signal.c |    3 ---
 1 files changed, 3 deletions(-)

--- linux-2.6.15.4.orig/arch/s390/kernel/compat_signal.c
+++ linux-2.6.15.4/arch/s390/kernel/compat_signal.c
@@ -258,9 +258,6 @@ sys32_sigaction(int sig, const struct ol
 	return ret;
 }
 
-int
-do_sigaction(int sig, const struct k_sigaction *act, struct k_sigaction *oact);
-
 asmlinkage long
 sys32_rt_sigaction(int sig, const struct sigaction32 __user *act,
 	   struct sigaction32 __user *oact,  size_t sigsetsize)

--
