Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbUCDJ05 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 04:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbUCDJ05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 04:26:57 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:58083 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S261569AbUCDJ0y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 04:26:54 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Added KGDB documentation 
Date: Thu, 4 Mar 2004 14:56:43 +0530
User-Agent: KMail/1.5
Cc: Tom Rini <trini@kernel.crashing.org>, Pavel Machek <pavel@ucw.cz>,
       George Anzinger <george@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403041456.43267.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have added some documentation to core-lite.patch. It's as follows. 
Comments/feedback?
Thanks.
-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

Documentation/kgdb.txt
==================
KGDB Linux kernel source level debugger

Amit S. Kale <amitkale@emsyssoft.com>
Last updated March 2004.

Introduction:
kgdb is a source level debugger for linux kernel. It is used along with gdb to
debug a linux kernel. Kernel developers can debug a kernel similar to
application programs with use of kgdb. It makes it possible to place
breakpoints in kernel code, step through the code and observe variables.

Two machines are required for using kgdb. One of these machines is a
development machine and the other is a test machine. The machines are
connected through a serial line, a null-modem cable which connects their
serial ports. The kernel to be debugged runs on the test machine. gdb runs on
the development machine. The serial line is used by gdb to communicate to the
kernel being debugged.

This version of kgdb is a lite version. It is available on i386 platform uses
a serial line for communicating to gdb. Full kgdb containing more features and
support more architecture is available along with plenty of documentation at
http://kgdb.sourceforge.net/

Compiling a kernel:
Enable Kernel hacking -> Kernel Debugging -> KGDB: kernel debugging with
remote gdb

Only generic serial port (8250) is supported in the lite version. Configure
8250 options.

Booting the kernel:
Kernel command line option "kgdbwait" makes kgdb wait for gdb connection
during booting of a kernel. If you have configured simple serial port, the
port number and speed can be overriden on command line by using option
"kgdb8250=portnumber,speed", where port numbers are 0-3 for COM1 to COM4
respectively and supported speeds are 9600, 19200, 38400, 57600, 115200.
Example: kgdbwait kgdb8250=0,115200

Connecting gdb:
If you have used "kgdbwait", kgdb prints a message "Waiting for connection
from remote gdb..." on the console and waits for connection from gdb. At this
point you connect gdb to kgdb.
Example: 
   % gdb ./vmlinux
   (gdb) set remotebaud 115200
   (gdb) target remote /dev/ttyS0

Once connected, you can debug a kernel the way you would debug an application
program.

