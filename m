Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130849AbQLIOoq>; Sat, 9 Dec 2000 09:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131123AbQLIOog>; Sat, 9 Dec 2000 09:44:36 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:47375 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130849AbQLIOoZ>;
	Sat, 9 Dec 2000 09:44:25 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: modutils 2.3.22 is available 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 10 Dec 2000 01:13:51 +1100
Message-ID: <13086.976371231@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/modutils/v2.3

patch-modutils-2.3.22.gz        Patch from modutils 2.3.21 to 2.3.22
modutils-2.3.22.tar.gz          Source tarball, includes RPM spec file
modutils-2.3.22-1.src.rpm       As above, in SRPM format
modutils-2.3.22-1.i386.rpm      Compiled with egcs-2.91.66, glibc 2.1.2
modutils-2.3.22-1.sparc.rpm     Compiled for combined sparc 32/64
patch-2.4.0-test12-pre7.gz	Adds persistent data and generic string
				support to kernel 2.4.0-test12-pre7.

Changelog extract

	* POSIXification/newlib changes.  Werner Almesberger.
	* modprobe -C did not print probe/probeall.  Wolfgang Oertl.
	* options statement was confused by /dev/snd and snd.  Wolfgang Oertl.
	* Report failing module in a dependency list.  Original patch by
	  Pavel Roskin, reworked by Keith Owens.
	* IA64 unwind fix.  Richard Henderson via Redhat.
	* modprobe -c used incorrect keywords for generated filenames.
	  Reported by Gabor Z. Papp.
	* char-major-10-184 microcode.  Tigran Aivazian.
	* Reinstate sys_oim.c in util/Makefile.in.
	* Add support for persistent module data.
	* Correct test for unexpected REL/RELA sections.  Maciej W. Rozycki.
	* Limit stack recursion in modprobe.  Kurt Garloff.
	* Support MODULE_GENERIC_STRING.  Jaroslav Kysela.

Support for persistent module data is the main change.  If persistdir
is set or defaulted in modules.conf _and_ insmod is run with option -e
then insmod will read persistent data from a file when the module is
loaded and rmmod will write persistent data to that file when the
module is unloaded.  man modules.conf, man insmod for details.

Notes:

(1) Persistent data is not on by default, you must run insmod with -e
    to support persistent data.  If you are loading modules via
    modprobe and you want persistent data for all modules then you need

      insmod_opt -e ""

    in /etc/modules.conf.

(2) Current kernels do not support persistent data nor generic strings.
    You must apply patch-2.4.0-test12-pre7 to get kernel support for
    these features.

(3) No modules currently have persistent data.  Module writers who
    want data to be persistent must make a one character change to
    their modules, read the above patch.  Even then, the user must
    activate the persistent data, see note (1).

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
