Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317367AbSGISJR>; Tue, 9 Jul 2002 14:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317366AbSGISJQ>; Tue, 9 Jul 2002 14:09:16 -0400
Received: from www.transvirtual.com ([206.14.214.140]:52230 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S317367AbSGISJN>; Tue, 9 Jul 2002 14:09:13 -0400
Date: Tue, 9 Jul 2002 11:11:50 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: [PATCH] New VT console system patch
Message-ID: <Pine.LNX.4.44.0207081419140.7699-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is the patch I posted some time ago for the new console system. It
has been tested and has been in the Dave Jones tree for so time now.
The changes are:

The removal of struct kbd_struct from being passed around in sysrq.
Cleanup of keyboard.c in preperations for migrating to the input api.

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
 10 files changed, 487 insertions(+), 459 deletions(-)

BK tree:

   http://linuxconsole.bkbits.net:8080/dev

diff:

    http://www.transvirtual.com/~jsimmons/console.diff.gz


Thank you.

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'\_   _/`\
 \___)=(___/




