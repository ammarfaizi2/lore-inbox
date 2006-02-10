Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWBJV1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWBJV1b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 16:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWBJV1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 16:27:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:904 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932186AbWBJV1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 16:27:30 -0500
Date: Fri, 10 Feb 2006 16:27:11 -0500
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fix s390 build failure.
Message-ID: <20060210212711.GD31949@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060210200425.GA11913@redhat.com> <Pine.LNX.4.64.0602101314082.19172@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602101314082.19172@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


arch/s390/kernel/compat_signal.c:199: error: conflicting types for 'do_sigaction'
include/linux/sched.h:1115: error: previous declaration of 'do_sigaction' was here

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.15.noarch/arch/s390/kernel/compat_signal.c~	2006-02-10 12:47:57.000000000 -0500
+++ linux-2.6.15.noarch/arch/s390/kernel/compat_signal.c	2006-02-10 12:48:05.000000000 -0500
@@ -196,7 +196,4 @@ sys32_sigaction(int sig, const struct ol
 }
 
-int
-do_sigaction(int sig, const struct k_sigaction *act, struct k_sigaction *oact);
-
 asmlinkage long
 sys32_rt_sigaction(int sig, const struct sigaction32 __user *act,
