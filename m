Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263018AbTC1PnK>; Fri, 28 Mar 2003 10:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263019AbTC1PnK>; Fri, 28 Mar 2003 10:43:10 -0500
Received: from hera.cwi.nl ([192.16.191.8]:1518 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S263018AbTC1PnJ>;
	Fri, 28 Mar 2003 10:43:09 -0500
From: Andries.Brouwer@cwi.nl
Date: Fri, 28 Mar 2003 16:49:46 +0100 (MET)
Message-Id: <UTC200303281549.h2SFnkw05009.aeb@smtp.cwi.nl>
To: tytso@mit.edu
Subject: TIOCTTYGSTRUCT
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ted,

Would you mind if I removed TIOCTTYGSTRUCT?

I suppose you don't need it any longer, and otherwise
could easily add some debugging stuff again when needed.
This ioctl exports lots of kernel-internal stuff that
userspace has no business looking at.
The direct reason I ask is that it also exports a kdev_t,
and the meaning of that will change.

Andries

>From Changelog:
Sat Nov 26 11:59:24 1994  Theodore Y. Ts'o  (tytso@rt-11)

        * tty_io.c (tty_ioctl): Add support for the new ioctl
                TIOCTTYGSTRUCT, which allow a kernel debugging program
                direct read access to the tty and tty_driver structures.
