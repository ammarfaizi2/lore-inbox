Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267871AbTBKOeX>; Tue, 11 Feb 2003 09:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267875AbTBKOeX>; Tue, 11 Feb 2003 09:34:23 -0500
Received: from hera.cwi.nl ([192.16.191.8]:48346 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S267871AbTBKOeV>;
	Tue, 11 Feb 2003 09:34:21 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 11 Feb 2003 15:44:07 +0100 (MET)
Message-Id: <UTC200302111444.h1BEi7106413.aeb@smtp.cwi.nl>
To: tytso@MIT.EDU
Subject: struct tty_driver
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ted, I wondered:

Looking at 2.5.60 I see

struct tty_struct {
	int     magic;
	struct tty_driver driver;
...

and it looks like this struct tty_driver is never modified.
Since it is rather large, why not replace it by
	struct tty_driver *driver;
?

As it is now, the initialization in init_dev() does
	tty->driver = *driver;
just duplicating constant data.

Is this a historical relict, or does this duplication have a function?

Andries
