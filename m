Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270838AbTGPOCo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 10:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270845AbTGPOCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 10:02:44 -0400
Received: from chaos.analogic.com ([204.178.40.224]:134 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S270838AbTGPOC0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 10:02:26 -0400
Date: Wed, 16 Jul 2003 10:19:14 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: SUID root
Message-ID: <Pine.LNX.4.53.0307161017060.26254@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It appears as though SUID root programs don't work on
linux 2.4.20, 2.4.21, or 2.4.22-pre6, or at least what
used to work no longer does.

One program tries to execute iopl(3). In the event that
it fails, it tries to set UID/GID to root after saving
the previous, then tries again.

The program exists in /usr/bin, properly owned by root. It
is set SUID, 4755, and otherwise works. Anybody have any
clues? Do SUID programs have to be re-written to use some
other mechanism? I need to have a user-mode program get
access to an otherwise unused printer port. It's a shame
to write a module just for this.


brk(0x804f000)                          = 0x804f000
brk(0x8051000)                          = 0x8051000
brk(0x8053000)                          = 0x8053000
time(NULL)                              = 1058364273
iopl(0x3)                               = -1 EPERM (Operation not permitted)
getuid()                                = 100
getgid()                                = 100
setuid(0)                               = -1 EPERM (Operation not permitted)
setgid(0)                               = -1 EPERM (Operation not permitted)
iopl(0x3)                               = -1 EPERM (Operation not permitted)
_exit(0)                                = ?
$ ls -la /usr/bin/debug
-rwsr-xr-x   1 root     root         6126 Jul 16 09:59 /usr/bin/debug
$ exit
exit

Script done on Wed Jul 16 10:05:02 2003


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.3% of all statistics are fiction.

