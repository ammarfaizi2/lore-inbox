Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267236AbTA0Quu>; Mon, 27 Jan 2003 11:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267238AbTA0Quu>; Mon, 27 Jan 2003 11:50:50 -0500
Received: from oumail.zero.ou.edu ([129.15.0.75]:58211 "EHLO c3p0.ou.edu")
	by vger.kernel.org with ESMTP id <S267236AbTA0Qut>;
	Mon, 27 Jan 2003 11:50:49 -0500
Date: Mon, 27 Jan 2003 11:00:08 -0600
From: Steve Kenton <skenton@ou.edu>
Subject: [FYI} The cygwin tool chain can *almost* build a 2.5.59 kernel
To: lkml <linux-kernel@vger.kernel.org>
Message-id: <3E356598.EF799135@ou.edu>
Organization: The University Of Oklahoma
MIME-version: 1.0
X-Mailer: Mozilla 4.7 [en] (X11; U; SunOS 5.8 sun4u)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why anyone would want to is arguable.  I was looking at uml and line
as I was downloading the 2.5.59 tar ball to peruse the source and the
question of "Hmmm, I wonder if ..." drifted up, so I gave it a try.

After fixing a few things like output format and one link error,

make defconfig ARCH=i386

did the expected things, as did oldconfig, config, and menuconfig

The big problem is that the cygwin binutils, 'as' in particular do not
support .subsection and .previous for some reason.  They are 2.13.?
something special for cygwin which might explain it.  Anyway, once
I hacked out the use of those (mainly in spinlocks, but a handful
scattered around) and configed out a couple of problems like OSS it
built a vmlinux (In windows PE format and probably not really useful)

It was an interesting "compile check" and might be helpful to some
doing janitor work at schools etc. where you can't change to Linux
or even dual boot because of "policies from above."

FYI

Steve
