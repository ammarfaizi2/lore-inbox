Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313190AbSERPyB>; Sat, 18 May 2002 11:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313202AbSERPyA>; Sat, 18 May 2002 11:54:00 -0400
Received: from mnh-1-15.mv.com ([207.22.10.47]:42248 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S313190AbSERPx7>;
	Sat, 18 May 2002 11:53:59 -0400
Message-Id: <200205181656.LAA02860@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: linux-kernel@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net
Subject: user-mode port 0.57-2.4.18-26
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 18 May 2002 11:56:56 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the third release of the 2.4.18 UML.

There were a number of ptrace and debugging fixes including:
	userspace (i.e. gdb running inside UML) watchpoints now work.  Kernel
	watchpoints don't yet, but they will soon.

	Fixed a bug which caused gdb inside UML to sometimes miss breakpoints.

	Fixed a security hole which allowed a user to execute system calls
	on the host by putting a breakpoint on the system call instruction.

	ddd now works as the UML debugger.  This isn't documented on the
	UML site yet - see 

	Shelling out of the UML debugger now works. 

UML can now run nested.  See http://user-mode-linux.sf.net/nesting.html for
the details.  There are two new config options which allow you to control
where in memory UML loads and how much address space it consumes.  
CONFIG_NEST_LEVEL controls the top of UML's address space, and 
CONFIG_KERNEL_HALF_GIGS controls how much address space below that it
uses.  Setting CONFIG_KERNEL_HALF_GIGS greater than one allows UML to have
more than .5G of physical memory.  KSTK_EIP and KSTK_ESP are now implemented, 
so the IP and SP fields of /proc/pid/stat now have real values.

iomem works again.

The UML block driver now supports partitioned devices.

There were various SMP fixes.

I fixed a bunch of console bugs, including a hang when a device was detached
from the host, an input flow control bug which limited the size of pastes,
a hang when an 8-bit character was typed, and various other small bugs.

It is no longer possible to cd into a binary in a hostfs filesystem.

If CONFIG_PTPROXY is disabled, UML will exit when it panics. 

UML can now set up network interfaces at boot time, allowing DHCP, bootp, 
rarp, and nfsboot to work.

In userspace changes, there were a number of bug fixes in uml_net, uml_switch
now acts as a bridge, remembering associations of MACs with ports, and there
is an expect script, umlgdb, which automates the reloading of module symbols
when the module is reloaded into gdb.

The project's home page is http://user-mode-linux.sourceforge.net

Downloads are available at 
	http://user-mode-linux.sourceforge.net/dl-sf.html

				Jeff

