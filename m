Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261365AbSIWSZY>; Mon, 23 Sep 2002 14:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261366AbSIWSZX>; Mon, 23 Sep 2002 14:25:23 -0400
Received: from mail106.mail.bellsouth.net ([205.152.58.46]:41766 "EHLO
	imf06bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S261365AbSIWSZX>; Mon, 23 Sep 2002 14:25:23 -0400
Date: Mon, 23 Sep 2002 14:30:29 -0400 (EDT)
From: Burton Windle <bwindle@fint.org>
X-X-Sender: bwindle@morpheus
To: linux-kernel@vger.kernel.org
cc: tytso@rsts-11.mit.edu
Subject: [2.5.38] Warning: null TTY for (88:##) in tty_fasync
Message-ID: <Pine.LNX.4.43.0209231419070.5735-100000@morpheus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are these cause for concern?

Sep 23 14:16:56 razor kernel: Warning: null TTY for (88:01) in tty_fasync
Sep 23 14:16:56 razor kernel: Warning: null TTY for (88:00) in tty_fasync
Sep 23 14:24:30 razor kernel: Warning: null TTY for (88:02) in tty_fasync

I see that they can come from drivers/char/tty_io.c:
     "Warning: null TTY for (%s) in %s\n";

I'm able to reproduce these at will.

Linux version 2.5.38 (bwindle@razor) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Mon Sep 23 10:07:19 EST 2002

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.19
e2fsprogs              1.27
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.12


--
Burton Windle                           burton@fint.org
Linux: the "grim reaper of innocent orphaned children."
          from /usr/src/linux-2.4.18/init/main.c:461


