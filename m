Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbWDELbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWDELbN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 07:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWDELbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 07:31:13 -0400
Received: from wildsau.enemy.org ([193.170.194.34]:2443 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S1751219AbWDELbM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 07:31:12 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200604051127.k35BR3Qe009718@wildsau.enemy.org>
Subject: Q on audit, audit-syscall
To: linux-kernel@vger.kernel.org
Date: Wed, 5 Apr 2006 13:27:03 +0200 (MET DST)
CC: Herbert Rosmanith <kernel@wildsau.enemy.org>
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


good afternoon,

I'm searching for a way to trace/intercept syscalls, both before and
after execution. "ptrace" is not an option (you probably know why).
I've found CONFIG_AUDIT and CONFIG_AUDITSYSCALL, which offer
"audit_syscall_entry" and "audit_syscall_exit", but I dont know
how to use this. Also, the comment in kernel/auditsc.c reads:
 * The method for actual interception of syscall entry and exit (not in
 * this file -- see entry.S) is based on a GPL'd patch written by
 * okir@suse.de and Copyright 2003 SuSE Linux AG.

So, am I looking in the wrong file?

I just cant see how this software communicates with user-space,
there is no "register_xxx" (or whatever) in the source-files.
Is it neccessary to write an additional module (like se-linux does)
which makes use of audit and exports its own functionality to
userspace?

So far, in the audit-1.1.5 deamon, I've only found a PF_NETLINK/NETLINK_AUDIT
socket. *Is* this it?

What's additionally confusing me is that linux/Documentation/devices.txt
says that "block 130 minor 0 = Audit device", yet, allthugh I'm running
with 2.6.16 + CONFIG_AUDIT & CONFIG_AUDITSYSCALL, there just is no
block dev 130 in /proc/devices. Is the entry in devices.txt wrong?

regards,
h.rosmanith





