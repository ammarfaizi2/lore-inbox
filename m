Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263765AbTEYUzb (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 25 May 2003 16:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263771AbTEYUzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 16:55:31 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:55561 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263765AbTEYUza (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 16:55:30 -0400
Date: Sun, 25 May 2003 23:08:39 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: Get more focus on warnings
Message-ID: <20030525210839.GA1704@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch put focus on warnings when compiling.

Kbuild has for a long period supported a quit mode.
The quit mode prints a single line for each file compiled,
thus warnings becomes much more visible.
Example:

  CC      kernel/uid16.o
  CC      kernel/ksyms.o
kernel/ksyms.c:441: warning: `__check_region' is deprecated (declared at include/linux/ioport.h:113)
  CC      kernel/module.o

The old output format can obtained like this:
	$ make V=1

or more permanent with the following assignment in .bashrc:
	KBUILD_VERBOSE=1

If one is concerned about warnings the output from a kernel
build is redirected to a file, or make -s is used.
The advantage of this patch is that the default settings puts focus
on warnings while still providing the user with feedback about the
build process.

Kai Germaschewski has done most of the initial work enabling this
feature, originally inspired from Keith Owens kbuild-2.5 patchset.

	Sam
