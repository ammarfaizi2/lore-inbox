Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261676AbTCNKsI>; Fri, 14 Mar 2003 05:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261683AbTCNKsI>; Fri, 14 Mar 2003 05:48:08 -0500
Received: from mail1.ugr.es ([150.214.20.24]:51585 "EHLO mail1.ugr.es")
	by vger.kernel.org with ESMTP id <S261676AbTCNKsH>;
	Fri, 14 Mar 2003 05:48:07 -0500
Subject: make modules_install fail: depmod *** Unresolved symbols (official
	2.4.20)
From: Miguel =?ISO-8859-1?Q?Quir=F3s?= <mquiros@ugr.es>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Organization: Universidad de Granada
Message-Id: <1047639589.1458.43.camel@migelinho.ugr.es>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 14 Mar 2003 11:59:50 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

			Granada, 14-3-2002

Hello, I downloaded kernel 2.4.20 and compiled it sucessfully a month
ago without any aparent problem. Yesterday I tried to compile it again
in the same computer just changing a couple of small things in the
configuration (agpart and the network card changed from "module" to
"yes").

make dep, make bzImage and make modules went apparently well (expect for
a few apparently non-important warnings with bzImage of the type
Warning: indirect call without '*' when compiling pci-pc and apm).

But when I try make modules_install, I've got a lot of error messages.
For each module I've got one line like:

depmod:  *** Unresolved symbols in
/lib/modules/2.4.20/kernel/arch/i386/kernel/microcode.o

followed by a number of lines of the type

depmod:     misc_deregister
depmod:     __generic_copy_from_use
depmod:     .....
.....
.....

(this kind of error messages appear for every built module)

Modules have been however copied to /lib/modules/2.4.20. The kernel
built in this way boot without problems but I can see the following
message in /var/log/messages among the usual normal startup messages:

Incorrect build binary which accesses errno, h_errno or _res directly.
Need to be fixed.

Saving config, doing make mrproper, restoring .config, making dep and
recompiling does not change anything.

Between the sucess a month ago and the errors yesterday, the only
important thing I can remember having been done in the computer is to
upgrade XFree86 which in turn, to satisfy dependences, made me to update
other many things like glibc, glibc-devel and binutils. Perhaps I have
had to remove some other package, I do not remember. Actual versions
are:
glibc 2.3.1-51 and binutils 2.13.90.0.18-6, upgraded from RawHide RPM
packages.

Please, do "Cc" to my address if you reply to the list (I am not list
member). Thanks for any help.

Miguel Quirós

-- 
-------------------------
Miguel Quirós Olozábal
Departamento de Química Inorgánica. Facultad de Ciencias.
Universidad de Granada. 18071 Granada (SPAIN).
email:mquiros@ugr.es

