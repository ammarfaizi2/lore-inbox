Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317542AbSGETHK>; Fri, 5 Jul 2002 15:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317543AbSGETHJ>; Fri, 5 Jul 2002 15:07:09 -0400
Received: from www.transvirtual.com ([206.14.214.140]:34577 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S317542AbSGETHI>; Fri, 5 Jul 2002 15:07:08 -0400
Date: Fri, 5 Jul 2002 12:09:28 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: [PATCH] New Console part One.
Message-ID: <Pine.LNX.4.44.0207051053500.25589-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After some testings here is the start of the new console system.
The changes here are removal of struct kbd_struct from handler_sysrq. Only
two sysrq functions actually use it. Sysrq should work with any kind of
console system and the major of them will lack a physical keyboard. The
second change is a cleanup and preparation of moving the VT console system
input devices over to the input api.

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'\_   _/`\
 \___)=(___/


 arch/i386/kernel/apm.c         |    2
 arch/ppc/xmon/start.c          |    2
 arch/ppc64/xmon/start.c        |    2
 drivers/acpi/system.c          |    2
 drivers/char/console.c         |   82 ++--
 drivers/char/keyboard.c        |  781 +++++++++++++++++++++--------------------
 drivers/char/sysrq.c           |   46 +-
 drivers/char/tty_io.c          |   15
 include/linux/console_struct.h |    1
 include/linux/sysrq.h          |   13
 11 files changed, 487 insertions(+), 459 deletions(-)

The BK link is

http://linuxconsole.bkbits.net/dev

diff:

http://www.transvirtual.com/~jsimmons/console.diff.gz

