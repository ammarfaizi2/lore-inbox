Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268034AbTB1Rvh>; Fri, 28 Feb 2003 12:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268038AbTB1Rvh>; Fri, 28 Feb 2003 12:51:37 -0500
Received: from ausadmmsrr501.aus.amer.dell.com ([143.166.83.88]:7690 "HELO
	AUSADMMSRR501.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S268034AbTB1Rvg>; Fri, 28 Feb 2003 12:51:36 -0500
X-Server-Uuid: ff595059-9672-488a-bf38-b4dee96ef25b
Message-ID: <20BF5713E14D5B48AA289F72BD372D680326F888@AUSXMPC122.aus.amer.dell.com>
From: Gary_Lerhaupt@Dell.com
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] DKMS: Dynamic Kernel Module Support
Date: Fri, 28 Feb 2003 12:01:51 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 12417B9B210772-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DKMS is a framework where device driver source can reside outside the kernel
source tree so that it is very easy to rebuild modules as you upgrade
kernels. This allows Linux vendors to provide driver drops without having to
wait for new kernel releases (as a stopgap before the code can make it back
into the kernel), while also taking out the guesswork for customers
attempting to recompile modules for new kernels.

For veteran Linux users it also provides some advantages since a separate
framework for driver drops will remove kernel releases as a blocking
mechanism for distributing code. Instead, driver development should speed up
as this separate module source tree will allow quicker testing cycles
meaning better tested code can later be pushed back into the kernel at a
more rapid pace. Its also nice for developers and maintainers as DKMS only
requires a source tarball in conjunction with a small configuration file in
order to function correctly.

The latest DKMS version is available at http://www.lerhaupt.com/dkms/.  It
is licensed under the GPL. You can also find a sample DKMS enabled QLogic
RPM to show you how it all works (or, a mocked-up tarball if you don't like
RPMs). If you use the sample RPM, you'll have to install it with --nodeps as
it requires the DKMS RPM to be installed (which I haven't provided).

===Using DKMS===

DKMS is one bash executable that supports 7 sub-actions: add, build,
install, uninstall, remove, status and match.

add: Adds an entry into the DKMS tree for later builds.  It requires that
source be located in /usr/src/<module>-<module-version>/ as well as the
location of a properly formatted dkms.conf file (each dkms.conf is module
specific and is the configuration file that tells DKMS how to build and
where to install your module).

build: Builds your module but stops short of installing it.  The resultant
.o files are stored in the DMKS tree.

install: Installs the module in the LOCATION specified in dkms.conf.

uninstall: Uninstalls the module and replaces it with whatever original
module was found during install (returns your module to the "built" state).


remove: Uninstalls and expunges all references of your module from the DKMS
tree.

status: Displays the current state (added, built, installed) of modules
within the DMKS tree as well as whether any original modules have been saved
for uninstallation purposes.

match: Allows you to take the configuration of DKMS installed modules for
one kernel and apply this config to some other kernel.  This is helpful when
upgrading kernels where you would like to continue using your DKMS modules
instead of certain kernel modules.

Check out the man page for more details.

Gary Lerhaupt
Linux Development
Dell Computer Corporation

