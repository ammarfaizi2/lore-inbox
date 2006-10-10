Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965083AbWJJIEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965083AbWJJIEf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 04:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965090AbWJJIEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 04:04:35 -0400
Received: from bay0-omc2-s14.bay0.hotmail.com ([65.54.246.150]:20404 "EHLO
	bay0-omc2-s14.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S965083AbWJJIEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 04:04:34 -0400
Message-ID: <BAY103-F11FF69B652F14B9D679376B2170@phx.gbl>
X-Originating-IP: [85.36.106.198]
X-Originating-Email: [pupilla@hotmail.com]
From: "Marco Berizzi" <pupilla@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.19-rc1 warning: process  used the removed sysctl system call
Date: Tue, 10 Oct 2006 10:04:32 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 10 Oct 2006 08:04:34.0158 (UTC) FILETIME=[B8F330E0:01C6EC42]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody,

I have compiled 2.6.19-rc1 on my new shiny slackware 11.0 and I see
these messages:

root@Calimero:~# dmesg  | grep warning
warning: process `touch' used the removed sysctl system call
warning: process `touch' used the removed sysctl system call
warning: process `dd' used the removed sysctl system call
warning: process `alsactl' used the removed sysctl system call
warning: process `kde-config' used the removed sysctl system call

I think this is because of 'CONFIG_SYSCTL_SYSCALL is not set'
(I have just copied .config from 2.6.18 to 2.6.19-rc1 and run
make bzImage && make modules)

This is my .config:

# General setup
#
CONFIG_LOCALVERSION=""
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_IPC_NS is not set
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
# CONFIG_TASKSTATS is not set
# CONFIG_UTS_NS is not set
# CONFIG_AUDIT is not set
# CONFIG_IKCONFIG is not set
# CONFIG_RELAY is not set
CONFIG_INITRAMFS_SOURCE=""
CONFIG_SYSCTL=y
# CONFIG_EMBEDDED is not set
CONFIG_UID16=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_SLAB=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_RT_MUTEXES=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
# CONFIG_SLOB is not set

My env: Slackware 11.0 + linux 2.6.19-rc1

Linux Calimero 2.6.19-rc1 #1 PREEMPT Thu Oct 5 15:26:06 CEST 2006 i686 
pentium3 i386 GNU/Linux

Gnu C                  3.4.6
Gnu make               3.81
binutils               2.15.92.0.2
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.38
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Linux C++ Library      6.0.3
Procps                 3.2.7
Net-tools              1.60
Kbd                    1.12

dd & touch from GNU coreutils 5.97


