Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263354AbTJQIWi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 04:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263357AbTJQIWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 04:22:38 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:60815 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S263354AbTJQIWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 04:22:35 -0400
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH]Futex doc.
From: <ffrederick@prov-liege.be>
Date: Thu, 16 Oct 2003 10:24:02 PDT
Reply-To: <ffrederick@prov-liege.be>
X-Priority: 3 (Normal)
X-Originating-Ip: [10.10.0.30]
X-Mailer: NOCC v0.9.5
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <S263354AbTJQIWf/20031017082235Z+15836@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
     Someone could help me having a complete futex doc ?
Here's a first version :

Regards,
Fabian

Documentation for futexes               kernel version 2.6.0-test6
        (c) 2003 Fabian Frederick <ffrederick@users.sourceforge.net>

Note : Based on user man page by Bert Hubert - Comments by Jamie Lokier.

===============================================================================

This file contains documentation for Fast Userspace Mutexes.
For complete authors list and sources you can read /kernel/futex.c

===============================================================================

What's a mutex ?

Mutex stands for mutual exclusion.In other words, it helps synchronizing processes
against shared memory access for instance.

Futex is basically a counter whose value is atomically updated in userland.
Any concurrent access will be managed in kernel space.

3 futex types exist :

	-shared
	-private
	-both

===============================================================================

Linux implementation

You can find POSIX mutex adaptation through futexes.User point of view and 
documentation can be found at http://ds9a.nl/futex-manpages/

Futex interface is sys_futex syscall.Here are recognized operations:

	-FUTEX_WAIT    : Wait a process to up futex.
	-FUTEX_WAKE    : Wake up all futex waiters.
	-FUTEX_FD      : Associate a file descriptor to futex
	-FUTEX_REQUEUE : Requeue all waiters hashed on one physical page to another
                         physical page.



___________________________________



