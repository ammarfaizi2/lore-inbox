Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWIXVRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWIXVRd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 17:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWIXVRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 17:17:32 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:8850 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S932145AbWIXVNM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:13:12 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: Bryce Harrington <bryce@osdl.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 22/28] kbuild: fix for some typos in Documentation/makefiles.txt
Reply-To: sam@ravnborg.org
Date: Sun, 24 Sep 2006 23:18:18 +0200
Message-Id: <1159132706126-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <115913270694-git-send-email-sam@ravnborg.org>
References: 20060924210827.GA26969@uranus.ravnborg.org <1159132704708-git-send-email-sam@ravnborg.org> <11591327042606-git-send-email-sam@ravnborg.org> <11591327042944-git-send-email-sam@ravnborg.org> <11591327041272-git-send-email-sam@ravnborg.org> <11591327041374-git-send-email-sam@ravnborg.org> <11591327041093-git-send-email-sam@ravnborg.org> <11591327053484-git-send-email-sam@ravnborg.org> <11591327051061-git-send-email-sam@ravnborg.org> <11591327053770-git-send-email-sam@ravnborg.org> <11591327051381-git-send-email-sam@ravnborg.org> <11591327054119-git-send-email-sam@ravnborg.org> <11591327051998-git-send-email-sam@ravnborg.org> <11591327051652-git-send-email-sam@ravnborg.org> <11591327053365-git-send-email-sam@ravnborg.org> <1159132705363-git-send-email-sam@ravnborg.org> <11591327063034-git-send-email-sam@ravnborg.org> <11591327061320-git-send-email-sam@ravnborg.org> <1159132706174-git-send-email-sam@ravnborg.org> <11591327061478-git-send-email-sam@ravnborg.org> <115913
 2706423-git-send-email-sam@ravnborg.org> <115913270694-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bryce Harrington <bryce@osdl.org>

I noticed a few typos while reading makefiles.txt to learn about the
kbuild system.  Attached is a patch against 2.6.18 to fix them.
Remove trailing whitespace while we are there..

Signed-off-by:  Bryce Harrington <bryce@osdl.org>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 Documentation/kbuild/makefiles.txt |   83 +++++++++++++++++++-----------------
 1 files changed, 43 insertions(+), 40 deletions(-)

diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
index 3d2f88e..b7d6abb 100644
--- a/Documentation/kbuild/makefiles.txt
+++ b/Documentation/kbuild/makefiles.txt
@@ -22,7 +22,7 @@ This document describes the Linux kernel
 	=== 4 Host Program support
 	   --- 4.1 Simple Host Program
 	   --- 4.2 Composite Host Programs
-	   --- 4.3 Defining shared libraries  
+	   --- 4.3 Defining shared libraries
 	   --- 4.4 Using C++ for host programs
 	   --- 4.5 Controlling compiler options for host programs
 	   --- 4.6 When host programs are actually built
@@ -69,7 +69,7 @@ architecture-specific information to the
 
 Each subdirectory has a kbuild Makefile which carries out the commands
 passed down from above. The kbuild Makefile uses information from the
-.config file to construct various file lists used by kbuild to build 
+.config file to construct various file lists used by kbuild to build
 any built-in or modular targets.
 
 scripts/Makefile.* contains all the definitions/rules etc. that
@@ -203,9 +203,9 @@ more details, with real examples.
 	Example:
 		#fs/ext2/Makefile
 	        obj-$(CONFIG_EXT2_FS)        += ext2.o
-	 	ext2-y                       := balloc.o bitmap.o
+		ext2-y                       := balloc.o bitmap.o
 	        ext2-$(CONFIG_EXT2_FS_XATTR) += xattr.o
-	
+
 	In this example, xattr.o is only part of the composite object
 	ext2.o if $(CONFIG_EXT2_FS_XATTR) evaluates to 'y'.
 
@@ -244,7 +244,7 @@ more details, with real examples.
 	For kbuild to actually recognize that there is a lib.a being built,
 	the directory shall be listed in libs-y.
 	See also "6.3 List directories to visit when descending".
- 
+
 	Use of lib-y is normally restricted to lib/ and arch/*/lib.
 
 --- 3.6 Descending down in directories
@@ -408,7 +408,7 @@ more details, with real examples.
 	if first argument is not supported.
 
     ld-option
-    	ld-option is used to check if $(CC) when used to link object files
+	ld-option is used to check if $(CC) when used to link object files
 	supports the given option.  An optional second option may be
 	specified if first option are not supported.
 
@@ -435,7 +435,7 @@ more details, with real examples.
 	cflags-y will be assigned no value if first option is not supported.
 
    cc-option-yn
-   	cc-option-yn is used to check if gcc supports a given option
+	cc-option-yn is used to check if gcc supports a given option
 	and return 'y' if supported, otherwise 'n'.
 
 	Example:
@@ -443,7 +443,7 @@ more details, with real examples.
 		biarch := $(call cc-option-yn, -m32)
 		aflags-$(biarch) += -a32
 		cflags-$(biarch) += -m32
-	
+
 	In the above example, $(biarch) is set to y if $(CC) supports the -m32
 	option. When $(biarch) equals 'y', the expanded variables $(aflags-y)
 	and $(cflags-y) will be assigned the values -a32 and -m32,
@@ -457,13 +457,13 @@ more details, with real examples.
 		cc-option-align = -malign
 	gcc >= 3.00
 		cc-option-align = -falign
-	
+
 	Example:
 		CFLAGS += $(cc-option-align)-functions=4
 
 	In the above example, the option -falign-functions=4 is used for
 	gcc >= 3.00. For gcc < 3.00, -malign-functions=4 is used.
-	
+
     cc-version
 	cc-version returns a numerical version of the $(CC) compiler version.
 	The format is <major><minor> where both are two digits. So for example
@@ -491,7 +491,7 @@ more details, with real examples.
 
 	In this example, EXTRA_CFLAGS will be assigned the value -O1 if the
 	$(CC) version is less than 4.2.
-	cc-ifversion takes all the shell operators: 
+	cc-ifversion takes all the shell operators:
 	-eq, -ne, -lt, -le, -gt, and -ge
 	The third parameter may be a text as in this example, but it may also
 	be an expanded variable or a macro.
@@ -507,7 +507,7 @@ The first step is to tell kbuild that a 
 done utilising the variable hostprogs-y.
 
 The second step is to add an explicit dependency to the executable.
-This can be done in two ways. Either add the dependency in a rule, 
+This can be done in two ways. Either add the dependency in a rule,
 or utilise the variable $(always).
 Both possibilities are described in the following.
 
@@ -524,7 +524,7 @@ Both possibilities are described in the 
 	Kbuild assumes in the above example that bin2hex is made from a single
 	c-source file named bin2hex.c located in the same directory as
 	the Makefile.
-  
+
 --- 4.2 Composite Host Programs
 
 	Host programs can be made up based on composite objects.
@@ -535,7 +535,7 @@ Both possibilities are described in the 
 
 	Example:
 		#scripts/lxdialog/Makefile
-		hostprogs-y   := lxdialog  
+		hostprogs-y   := lxdialog
 		lxdialog-objs := checklist.o lxdialog.o
 
 	Objects with extension .o are compiled from the corresponding .c
@@ -544,8 +544,8 @@ Both possibilities are described in the 
 	Finally, the two .o files are linked to the executable, lxdialog.
 	Note: The syntax <executable>-y is not permitted for host-programs.
 
---- 4.3 Defining shared libraries  
-  
+--- 4.3 Defining shared libraries
+
 	Objects with extension .so are considered shared libraries, and
 	will be compiled as position independent objects.
 	Kbuild provides support for shared libraries, but the usage
@@ -558,7 +558,7 @@ Both possibilities are described in the 
 		hostprogs-y     := conf
 		conf-objs       := conf.o libkconfig.so
 		libkconfig-objs := expr.o type.o
-  
+
 	Shared libraries always require a corresponding -objs line, and
 	in the example above the shared library libkconfig is composed by
 	the two objects expr.o and type.o.
@@ -579,7 +579,7 @@ Both possibilities are described in the 
 
 	In the example above the executable is composed of the C++ file
 	qconf.cc - identified by $(qconf-cxxobjs).
-	
+
 	If qconf is composed by a mixture of .c and .cc files, then an
 	additional line can be used to identify this.
 
@@ -588,7 +588,7 @@ Both possibilities are described in the 
 		hostprogs-y   := qconf
 		qconf-cxxobjs := qconf.o
 		qconf-objs    := check.o
-	
+
 --- 4.5 Controlling compiler options for host programs
 
 	When compiling host programs, it is possible to set specific flags.
@@ -600,23 +600,23 @@ Both possibilities are described in the 
 	Example:
 		#scripts/lxdialog/Makefile
 		HOST_EXTRACFLAGS += -I/usr/include/ncurses
-  
+
 	To set specific flags for a single file the following construction
 	is used:
 
 	Example:
 		#arch/ppc64/boot/Makefile
 		HOSTCFLAGS_piggyback.o := -DKERNELBASE=$(KERNELBASE)
-  
+
 	It is also possible to specify additional options to the linker.
-  
+
 	Example:
 		#scripts/kconfig/Makefile
 		HOSTLOADLIBES_qconf := -L$(QTDIR)/lib
 
 	When linking qconf, it will be passed the extra option
 	"-L$(QTDIR)/lib".
- 
+
 --- 4.6 When host programs are actually built
 
 	Kbuild will only build host-programs when they are referenced
@@ -631,7 +631,7 @@ Both possibilities are described in the 
 		$(obj)/devlist.h: $(src)/pci.ids $(obj)/gen-devlist
 			( cd $(obj); ./gen-devlist ) < $<
 
-	The target $(obj)/devlist.h will not be built before 
+	The target $(obj)/devlist.h will not be built before
 	$(obj)/gen-devlist is updated. Note that references to
 	the host programs in special rules must be prefixed with $(obj).
 
@@ -650,7 +650,7 @@ Both possibilities are described in the 
 
 --- 4.7 Using hostprogs-$(CONFIG_FOO)
 
-	A typcal pattern in a Kbuild file looks like this:
+	A typical pattern in a Kbuild file looks like this:
 
 	Example:
 		#scripts/Makefile
@@ -682,7 +682,8 @@ When executing "make clean", the two fil
 be deleted. Kbuild will assume files to be in same relative directory as the
 Makefile except if an absolute path is specified (path starting with '/').
 
-To delete a directory hirachy use:
+To delete a directory hierarchy use:
+
 	Example:
 		#scripts/package/Makefile
 		clean-dirs := $(objtree)/debian/
@@ -740,7 +741,7 @@ When kbuild executes, the following step
 5) Recursively descend down in all directories listed in
    init-* core* drivers-* net-* libs-* and build all targets.
    - The values of the above variables are expanded in arch/$(ARCH)/Makefile.
-6) All object files are then linked and the resulting file vmlinux is 
+6) All object files are then linked and the resulting file vmlinux is
    located at the root of the obj tree.
    The very first objects linked are listed in head-y, assigned by
    arch/$(ARCH)/Makefile.
@@ -762,7 +763,7 @@ When kbuild executes, the following step
 		LDFLAGS         := -m elf_s390
 	Note: EXTRA_LDFLAGS and LDFLAGS_$@ can be used to further customise
 	the flags used. See chapter 7.
-	
+
     LDFLAGS_MODULE	Options for $(LD) when linking modules
 
 	LDFLAGS_MODULE is used to set specific flags for $(LD) when
@@ -845,7 +846,7 @@ When kbuild executes, the following step
 	$(CFLAGS_MODULE) contains extra C compiler flags used to compile code
 	for loadable kernel modules.
 
- 
+
 --- 6.2 Add prerequisites to archprepare:
 
 	The archprepare: rule is used to list prerequisites that need to be
@@ -869,7 +870,7 @@ When kbuild executes, the following step
 	corresponding arch-specific section for modules; the module-building
 	machinery is all architecture-independent.
 
-	
+
     head-y, init-y, core-y, libs-y, drivers-y, net-y
 
 	$(head-y) lists objects to be linked first in vmlinux.
@@ -926,7 +927,7 @@ When kbuild executes, the following step
 		#arch/i386/Makefile
 		define archhelp
 		  echo  '* bzImage      - Image (arch/$(ARCH)/boot/bzImage)'
-		endef
+		endif
 
 	When make is executed without arguments, the first goal encountered
 	will be built. In the top level Makefile the first goal present
@@ -938,7 +939,7 @@ When kbuild executes, the following step
 
 	Example:
 		#arch/i386/Makefile
-		all: bzImage 
+		all: bzImage
 
 	When "make" is executed without arguments, bzImage will be built.
 
@@ -961,7 +962,7 @@ When kbuild executes, the following step
 	In this example, extra-y is used to list object files that
 	shall be built, but shall not be linked as part of built-in.o.
 
-	
+
 --- 6.6 Commands useful for building a boot image
 
 	Kbuild provides a few macros that are useful when building a
@@ -995,7 +996,7 @@ When kbuild executes, the following step
 
     ld
 	Link target. Often, LDFLAGS_$@ is used to set specific options to ld.
-	
+
     objcopy
 	Copy binary. Uses OBJCOPYFLAGS usually specified in
 	arch/$(ARCH)/Makefile.
@@ -1053,7 +1054,7 @@ When kbuild executes, the following step
 	BUILD    arch/i386/boot/bzImage
 
 	will be displayed with "make KBUILD_VERBOSE=0".
-	
+
 
 --- 6.8 Preprocessing linker scripts
 
@@ -1062,19 +1063,19 @@ When kbuild executes, the following step
 	The script is a preprocessed variant of the file vmlinux.lds.S
 	located in the same directory.
 	kbuild knows .lds files and includes a rule *lds.S -> *lds.
-	
+
 	Example:
 		#arch/i386/kernel/Makefile
 		always := vmlinux.lds
-	
+
 		#Makefile
 		export CPPFLAGS_vmlinux.lds += -P -C -U$(ARCH)
-		
-	The assigment to $(always) is used to tell kbuild to build the
+
+	The assignment to $(always) is used to tell kbuild to build the
 	target vmlinux.lds.
 	The assignment to $(CPPFLAGS_vmlinux.lds) tells kbuild to use the
 	specified options when building the target vmlinux.lds.
-	
+
 	When building the *.lds target, kbuild uses the variables:
 	CPPFLAGS	: Set in top-level Makefile
 	EXTRA_CPPFLAGS	: May be set in the kbuild makefile
@@ -1180,3 +1181,5 @@ Language QA by Jan Engelhardt <jengelh@g
 - Generating offset header files.
 - Add more variables to section 7?
 
+
+
-- 
1.4.1

