Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129147AbQKPG0n>; Thu, 16 Nov 2000 01:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129245AbQKPG0e>; Thu, 16 Nov 2000 01:26:34 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:43832 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S129147AbQKPG0b>; Thu, 16 Nov 2000 01:26:31 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: modutils 2.3.20 is available 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 16 Nov 2000 16:56:06 +1100
Message-ID: <9812.974354166@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the recent modutils 2.3 local root exploits, anybody using
modutils 2.3 should upgrade to 2.3.20.  That means everybody using 2.4
kernels.

The security patch to modutils 2.3.19 only closed part of the exploit,
this version should close all known exploits.  modutils still supports
meta expansion, including back quoted commands, but only for data read
from the configuration file.  This assumes that when modutils is run as
root out of the kernel, normal users cannot specify their own
configuration files.

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/modutils/v2.3

patch-modutils-2.3.20.bz2       Patch from modutils 2.3.19 to 2.3.20
modutils-2.3.20.tar.bz2         Source tarball, includes RPM spec file
modutils-2.3.20-1.src.rpm       As above, in SRPM format
modutils-2.3.20-1.i386.rpm      Compiled with egcs-2.91.66, glibc 2.1.2
modutils-2.3.20-1.sparc.rpm     My first sparc rpm, handle with care.

Changelog extract

	* Rewrite table generation code to make it easier to add new tables.
	* usbmap uses zero vendor as wildcard, test more fields to find end of
	  table.  Adam J. Richter.
	* Off by one error in relocations.  Jean-Francois Moine.  
	* Use tgt_long to handle different sizes in combined 32/64 bit
	  systems.  Original patch by Dave Miller.
	* Include module type in headers of generated files.  Randy Dunlap.
	* Add insmod -S (force kallsyms), clean up insmod parameters, man page.
	* Clean up messages.
	* Verify MODULE_PARM strings.
	* Check for multiple well known symbols to get prefix.
	* Security cleanup.  Triggered by Bugtraq exploits by Michal Zalewski,
	  Sebastian Krahmer, Chris Evans.  It is still the kernel's fault for
	  passing user data unchanged to a program running as root.
	* Add missing s/390 arch_finalize_section_address.  Roger Luethi.
	* depmod -F supports strange sparc __export_priv_.  Dave Miller.
	* Sparc64 relocation patch.  Redhat (not that they bothered to tell me).
	* Sparc64 compile and link fixes.  Me, with thanks to Dave Miller for
	  making a machine available.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
