Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S130638AbQIJCQl>; Sat, 9 Sep 2000 22:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S130632AbQIJCQb>; Sat, 9 Sep 2000 22:16:31 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:39428 "HELO mail.ocs.com.au") by vger.kernel.org with SMTP id <S130631AbQIJCQS>; Sat, 9 Sep 2000 22:16:18 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: modutils 2.3.16 is available 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 10 Sep 2000 13:17:25 +1100
Message-ID: <20520.968552245@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fastest download from kernel.org.
Mirror at ftp://ftp.**.kernel.org/pub/linux/utils/kernel/modutils/v2.3
           replace '**' with your favourite kernel.org mirror.
Master at ftp://ftp.ocs.com.au/pub/modutils/v2.3.  (slow)

patch-modutils-2.3.16.gz        Patch from modutils 2.3.15 to 2.3.16
modutils-2.3.16.tar.gz          Source tarball, includes RPM spec file
modutils-2.3.16-1.src.rpm       As above, in SRPM format
modutils-2.3.16-1.i386.rpm      Compiled with egcs-2.91.66, glibc 2.1.2

Changelog extract

        * Increase maximum symbols in map from 10,000 to 100,000.
        * Add __archdata section on architectures that need arch
          specific data in loaded modules (IA64 is first).
        * Ignore unresolved references if there are no relocation
          entries for them.  Some versions of gcc generate spurious
          unresolved externals which are not actually used.
        * Update modules.conf man page by John Levon.
        * Simplify path list, defaults are almost all [toplevel] only.
        * Add prune command to modules.conf man page.

The change to simplify the path list should give the same behaviour as
the previous messy list of directories, for kernel and pcmcia files
This change means that modutils now scans *all* directories under
/lib/modules/<version> by default.  If you have other directories under
LMV (e.g. LMV/vmware) those directories are now scanned automatically.
Let me know ASAP if this change causes any problems.

Third party modules whose source is compiled separately from the kernel
source tree should install into their own directory under LMV, they
should not pollute the LMV/kernel directory.  Kernel builds from
2.4.0-test6 onwards remove all of LMV/kernel during modules install, to
ensure that the kernel directory contains no old modules.  So anything
that pollutes LMV/kernel will be lost during kernel install.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
