Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261973AbSK0KPQ>; Wed, 27 Nov 2002 05:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261996AbSK0KPQ>; Wed, 27 Nov 2002 05:15:16 -0500
Received: from [63.210.179.4] ([63.210.179.4]:50943 "EHLO sentri.screwage.com")
	by vger.kernel.org with ESMTP id <S261973AbSK0KPP>;
	Wed, 27 Nov 2002 05:15:15 -0500
Date: Wed, 27 Nov 2002 02:22:12 -0800
From: Michael Kaufman <walker@screwage.com>
To: linux-kernel@vger.kernel.org
Subject: null TTY in tty_fasync
Message-ID: <20021127102211.GA10810@sentri.screwage.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Like a few other folks, I have been getting warning messages from
the paranoia checks in drivers/char/tty_io.c in kernel 2.5.49:

Warning: null TTY for (88:03) in tty_fasync
Warning: null TTY for (88:04) in tty_fasync
Warning: null TTY for (88:00) in tty_fasync
Warning: null TTY for (88:03) in tty_fasync
Warning: null TTY for (88:06) in tty_fasync
Warning: null TTY for (88:06) in tty_fasync

I am running Debian Sid, the kernel was built with the gcc 2.95.x that
came as standard. I am able to (re)produce the warnings using screen(1)
3.09.13 by creating (C-a C-c) a window/shell, and then logging out (C-d).
Destroying the screen window with C-a :kill doesn't cause the warning
messages. Maybe it has something to do with the shell still holding it.

I can provide more information if needed. Please Cc: me any requests
for information or replies, as I'm not subscribed to LKML.

thanks,
-- 
Michael Kaufman
walker@screwage.com
