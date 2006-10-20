Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992629AbWJTVIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992629AbWJTVIJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 17:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946515AbWJTVII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 17:08:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16359 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946514AbWJTVIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 17:08:05 -0400
Date: Fri, 20 Oct 2006 14:08:04 -0700
From: Bryce Harrington <bryce@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.19-rc2-mm2 not building on ppc64 - "c_ispeed"
Message-ID: <20061020210804.GV10386@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On PPC64 there is a build error with 2.6.19-rc2-mm2:

  CC      drivers/char/pty.o
drivers/char/tty_ioctl.c: In function `set_termios':
drivers/char/tty_ioctl.c:405: warning: passing arg 1 of `user_termio_to_kernel_termios' from incompatible pointer type
drivers/char/tty_ioctl.c: In function `get_termio':
drivers/char/tty_ioctl.c:445: warning: passing arg 2 of `kernel_termios_to_user_termio' from incompatible pointer type
drivers/char/tty_ioctl.c: In function `get_sgttyb':
drivers/char/tty_ioctl.c:498: error: structure has no member named `c_ispeed'
drivers/char/tty_ioctl.c:499: error: structure has no member named `c_ospeed'
make[2]: *** [drivers/char/tty_ioctl.o] Error 1
make[2]: *** Waiting for unfinished jobs....

Build log:
   http://crucible.osdl.org/runs/2691/logs/ppc01/kernel.make.log
Config file:
   http://crucible.osdl.org/runs/2691/sysinfo/ppc01.config

Bryce
