Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266549AbUBFVR3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 16:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265665AbUBFVRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 16:17:24 -0500
Received: from chaos.analogic.com ([204.178.40.224]:4736 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266635AbUBFVQY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 16:16:24 -0500
Date: Fri, 6 Feb 2004 16:16:32 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: FATAL: Kernel too old
Message-ID: <Pine.LNX.4.53.0402061550440.681@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Who decides that the kernel is too old? Can't log-in over the
network on a machine that has a lot of uptime. Telnet to the
mail-server does work, though. It's just that shells don't
seem to work anymore!!!

Script started on Fri Feb  6 15:44:32 2004
# rlogin -l johnson quark
ATAL: kernel too old
# rlogin -l johnson quark
ATAL: kernel too old
# telnet quark
Trying 10.106.100.200...
Connected to quark.analogic.com.
Escape character is '^]'.
FATAL: kernel too old
Connection closed by foreign host.
# ping quark
64 bytes from 10.106.100.200   icmp-seq:0  ttl:64  time(ms):3.53    lost:0
64 bytes from 10.106.100.200   icmp-seq:1  ttl:64  time(ms):0.25    lost:0
Aborted!
# rsh quark
ATAL: kernel too old
#
# telnet quark 25
Trying 10.106.100.200...
Connected to quark.analogic.com.
Escape character is '^]'.
220 quark.analogic.com ESMTP Sendmail 8.11.0.Beta3/8.12.0.A; Fri, 6 Feb 2004 15:51:27 -0500
^]
telnet> quit
Connection closed.

It wouldn't let me log in at the console either, got the "init spawing
too fast..." message. Nothing in the logs. It's a generic RH with
the Linux-2.4.18-14 that it came with, never been hacked and used
as an internal mail-forwarding machine. It's been up since, probably
last April.

I couldn't find that "FATAL:" string in /bin/bash, in any
/lib/libc* files, nor in vmlinux. It's in /bin/rpm and in
/bin/ash.static. These are not used to log-in (I hope).
It's also in a bunch of /sbin files, never used to log in
(like e2fsck).

I crashed it and it rebooted fine, little fsck activity, with
nothing in any logs that shows there was any problem whatsoever.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


