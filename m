Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbUDEGAV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 02:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263132AbUDEGAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 02:00:20 -0400
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:37602 "EHLO
	avocet.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S261479AbUDEGAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 02:00:15 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Richard Harke <rharke@earthlink.net>
To: linux-kernel@vger.kernel.org
Subject: Make menuconfig fails
Date: Mon, 5 Apr 2004 00:01:11 -0700
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200404050001.11301.rharke@earthlink.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Messages says lxdialog is bad, probably because of a problem
with ncurses
I have:
/lib/libncurses.so.5    -> libncurses.so.5.4
/lib/libncurses.so.5.4

/usr/lib/libncurses.a
/usr/lib/libncurses.so  -> /lib/libncurses.so.5
/usr/lib/libncurses.so.5   ->   libtermcap.so

/usr/include/ncurses.h   -> curses.h
/usr/include/ncurses_dll.h
/usr/include/curses.h

I don't see any other ncurses lib's or headers

System ia64 (zx2000) running Debian 2.4.19
trying to build 2.4.25 from debian kernel-source-2.4.25
    with kernel-patches-2.4.25-ia64
Also have
/lib/libc-2.3.2.so
/lib/libc.so.6.1  -> libc-2.3.2.so

I tried removing /usr/lib/libncurses.a as it is not part of the
ncurses5 package but did not make a difference
The message also suggests that you can rebuild lxdialog
by cd'ing to /usr/src/linux/scripts/lxdialog and
running make clean all
This will never work as HOSTGCC is not defined unless make
is run in /usr/src/linux

Iwould appreciate any help or suggestions.

Richard Harke

