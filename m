Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131129AbQLQAQg>; Sat, 16 Dec 2000 19:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131231AbQLQAQ0>; Sat, 16 Dec 2000 19:16:26 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:34574 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131129AbQLQAQP>;
	Sat, 16 Dec 2000 19:16:15 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: modutils 2.3.23 is available 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 17 Dec 2000 10:45:41 +1100
Message-ID: <31418.977010341@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/modutils/v2.3

patch-modutils-2.3.23.gz        Patch from modutils 2.3.22 to 2.3.23
modutils-2.3.23.tar.gz          Source tarball, includes RPM spec file
modutils-2.3.23-1.src.rpm       As above, in SRPM format
modutils-2.3.23-1.i386.rpm      Compiled with egcs-2.91.66, glibc 2.1.2
modutils-2.3.23-1.sparc.rpm     Compiled for combined sparc 32/64
patch-2.4.0-test13-pre2.gz	Adds persistent data and generic string
				support to kernel 2.4.0-test13-pre2.

Changelog extract

	* Correct error path in rmmod.c.  Andrew Morton.
	* Include latest Redhat alias list.  Bill Nottingham.
	* hppa and hppa64 support.  Richard Hirst.
	* Rework Makefiles for common 32/64 code.  Keith Owens.
	* Add parportmap.  Adam J Richter, Keith Owens.
	* Use GNU standards for cross compile.  Maciej W. Rozycki.
	* Fix bound check on generic_string.  Bug reported by Jaroslav Kysela,
	  different patch by Keith Owens.
	* Warn instead of error for invalid MODULE_PARM.  Keith Owens.

Notes:

(1) Persistent data is not on by default, you must run insmod with -e
    to support persistent data.  If you are loading modules via
    modprobe and you want persistent data for all modules then you need

      insmod_opt -e ""

    in /etc/modules.conf.

(2) Current kernels do not support persistent data nor generic strings.
    You must apply patch-2.4.0-test13-pre2 to get kernel support for
    these features.

(3) No modules currently have persistent data.  Module writers who
    want data to be persistent must make a one character change to
    their modules, read the above patch.  Even then, the user must
    activate the persistent data, see note (1).

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
