Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293755AbSCAU5a>; Fri, 1 Mar 2002 15:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293757AbSCAU5W>; Fri, 1 Mar 2002 15:57:22 -0500
Received: from mnh-1-24.mv.com ([207.22.10.56]:35337 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S293755AbSCAU5C>;
	Fri, 1 Mar 2002 15:57:02 -0500
Message-Id: <200203012059.PAA03945@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: linux-kernel@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net
Subject: user-mode port 0.55-2.4.18
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 01 Mar 2002 15:59:36 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The user-mode port of 2.4.18 is available.

2.4.18 was a long release, so there were quite a few changes in UML, which
I'll try to summarize sanely here:

Device support:

Persistent TUN/TAP is now supported.  This means that with a little work
by root ahead of time to assign a tap device to the user, UML may set up
networking with the host without root assistance.  There is a new tool, 
tunctl, which allows management persistent TUN/TAP devices.

The MTD, LVM, and md configs are now pulled into the UML config.

Sound is now supported by a driver which relays to the host's /dev/dsp and
/dev/mixer.

New stuff:

The 'jail' and 'honeypot' switches now make (I believe) UML secure against
a hostile root user.  UML also no longer reads its /proc/<pid>/maps file,
making it easier to run inside chroot.

The default initialization strings for the main console, the consoles as a
group, and the serial lines as a group are now configurable.  Support for
the various channels are also configurable.

The console and serial lines now use the official devfs names when devfs is
enabled.  There are symlinks from the old names for compatibility.

Sending SIGINT or SIGTERM to the tracing will cause a clean shutdown of the
kernel (but not userspace).

jailtest is a new utility for poking at a UML from the inside to make sure
that it is secure.

uml_moo supports V2 COW files.

Bug fixes:

Signal delivery was redone again, so that the new pthreads library works now.

The BogoMips calculation is fixed.

Modules can be loaded in a kernel that has only one of gprof and gcov support
configured.

The mconsole socket and pid file have been moved from /tmp to the user's 
$HOME.

Fixed a data corruption bug in hostfs.

Reboots work properly when the UML binary is not in the current directory.

Numerous bugs fixed and cleanups done in the debugging support.

Fixed several bugs with IRQ handling.

A data-corrupting swap bug was fixed.

Several unsafe string manipulations in uml_mconsole and uml_switch were
fixed.

There were also many other miscellaneous bugs fixed and cleanups made.

The project's home page is http://user-mode-linux.sourceforge.net

Downloads are available at 
	http://user-mode-linux.sourceforge.net/dl-sf.html

				Jeff

