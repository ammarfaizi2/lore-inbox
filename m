Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWIXVSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWIXVSO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 17:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWIXVR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 17:17:59 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:16092 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S932121AbWIXVNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:13:10 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Jan Engelhardt <jengelh@gmx.de>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 9/28] kbuild: linguistic fixes for Documentation/kbuild/makefiles.txt
Reply-To: sam@ravnborg.org
Date: Sun, 24 Sep 2006 23:18:05 +0200
Message-Id: <11591327053770-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11591327051061-git-send-email-sam@ravnborg.org>
References: 20060924210827.GA26969@uranus.ravnborg.org <1159132704708-git-send-email-sam@ravnborg.org> <11591327042606-git-send-email-sam@ravnborg.org> <11591327042944-git-send-email-sam@ravnborg.org> <11591327041272-git-send-email-sam@ravnborg.org> <11591327041374-git-send-email-sam@ravnborg.org> <11591327041093-git-send-email-sam@ravnborg.org> <11591327053484-git-send-email-sam@ravnborg.org> <11591327051061-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Engelhardt <jengelh@linux01.gwdg.de>

I have done a look-through through Documentation/kbuild/ and my corrections
(proposed) are attached.

Cc'ed are original author Michael (responsible for comitting changes to
these files?), Sam (kbuild maintainer), Adrian (-trivial maintainer).

Signed-off-by: Jan Engelhardt <jengelh@gmx.de>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 Documentation/kbuild/makefiles.txt |  184 ++++++++++++++++++------------------
 1 files changed, 94 insertions(+), 90 deletions(-)

diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
index 0706699..3d2f88e 100644
--- a/Documentation/kbuild/makefiles.txt
+++ b/Documentation/kbuild/makefiles.txt
@@ -86,7 +86,7 @@ any kernel Makefiles (or any other sourc
 
 *Normal developers* are people who work on features such as device
 drivers, file systems, and network protocols.  These people need to
-maintain the kbuild Makefiles for the subsystem that they are
+maintain the kbuild Makefiles for the subsystem they are
 working on.  In order to do this effectively, they need some overall
 knowledge about the kernel Makefiles, plus detailed knowledge about the
 public interface for kbuild.
@@ -104,10 +104,10 @@ This document is aimed towards normal de
 === 3 The kbuild files
 
 Most Makefiles within the kernel are kbuild Makefiles that use the
-kbuild infrastructure. This chapter introduce the syntax used in the
+kbuild infrastructure. This chapter introduces the syntax used in the
 kbuild makefiles.
 The preferred name for the kbuild files are 'Makefile' but 'Kbuild' can
-be used and if both a 'Makefile' and a 'Kbuild' file exists then the 'Kbuild'
+be used and if both a 'Makefile' and a 'Kbuild' file exists, then the 'Kbuild'
 file will be used.
 
 Section 3.1 "Goal definitions" is a quick intro, further chapters provide
@@ -124,7 +124,7 @@ more details, with real examples.
 	Example:
 		obj-y += foo.o
 
-	This tell kbuild that there is one object in that directory named
+	This tell kbuild that there is one object in that directory, named
 	foo.o. foo.o will be built from foo.c or foo.S.
 
 	If foo.o shall be built as a module, the variable obj-m is used.
@@ -140,7 +140,7 @@ more details, with real examples.
 --- 3.2 Built-in object goals - obj-y
 
 	The kbuild Makefile specifies object files for vmlinux
-	in the lists $(obj-y).  These lists depend on the kernel
+	in the $(obj-y) lists.  These lists depend on the kernel
 	configuration.
 
 	Kbuild compiles all the $(obj-y) files.  It then calls
@@ -154,8 +154,8 @@ more details, with real examples.
 	Link order is significant, because certain functions
 	(module_init() / __initcall) will be called during boot in the
 	order they appear. So keep in mind that changing the link
-	order may e.g.  change the order in which your SCSI
-	controllers are detected, and thus you disks are renumbered.
+	order may e.g. change the order in which your SCSI
+	controllers are detected, and thus your disks are renumbered.
 
 	Example:
 		#drivers/isdn/i4l/Makefile
@@ -206,8 +206,8 @@ more details, with real examples.
 	 	ext2-y                       := balloc.o bitmap.o
 	        ext2-$(CONFIG_EXT2_FS_XATTR) += xattr.o
 	
-	In this example xattr.o is only part of the composite object
-	ext2.o, if $(CONFIG_EXT2_FS_XATTR) evaluates to 'y'.
+	In this example, xattr.o is only part of the composite object
+	ext2.o if $(CONFIG_EXT2_FS_XATTR) evaluates to 'y'.
 
 	Note: Of course, when you are building objects into the kernel,
 	the syntax above will also work. So, if you have CONFIG_EXT2_FS=y,
@@ -221,16 +221,16 @@ more details, with real examples.
 
 --- 3.5 Library file goals - lib-y
 
-	Objects listed with obj-* are used for modules or
+	Objects listed with obj-* are used for modules, or
 	combined in a built-in.o for that specific directory.
 	There is also the possibility to list objects that will
 	be included in a library, lib.a.
 	All objects listed with lib-y are combined in a single
 	library for that directory.
-	Objects that are listed in obj-y and additional listed in
+	Objects that are listed in obj-y and additionaly listed in
 	lib-y will not be included in the library, since they will anyway
 	be accessible.
-	For consistency objects listed in lib-m will be included in lib.a. 
+	For consistency, objects listed in lib-m will be included in lib.a.
 
 	Note that the same kbuild makefile may list files to be built-in
 	and to be part of a library. Therefore the same directory
@@ -241,11 +241,11 @@ more details, with real examples.
 		lib-y    := checksum.o delay.o
 
 	This will create a library lib.a based on checksum.o and delay.o.
-	For kbuild to actually recognize that there is a lib.a being build
+	For kbuild to actually recognize that there is a lib.a being built,
 	the directory shall be listed in libs-y.
 	See also "6.3 List directories to visit when descending".
  
-	Usage of lib-y is normally restricted to lib/ and arch/*/lib.
+	Use of lib-y is normally restricted to lib/ and arch/*/lib.
 
 --- 3.6 Descending down in directories
 
@@ -255,7 +255,7 @@ more details, with real examples.
 	invoke make recursively in subdirectories, provided you let it know of
 	them.
 
-	To do so obj-y and obj-m are used.
+	To do so, obj-y and obj-m are used.
 	ext2 lives in a separate directory, and the Makefile present in fs/
 	tells kbuild to descend down using the following assignment.
 
@@ -353,8 +353,8 @@ more details, with real examples.
 	Special rules are used when the kbuild infrastructure does
 	not provide the required support. A typical example is
 	header files generated during the build process.
-	Another example is the architecture specific Makefiles which
-	needs special rules to prepare boot images etc.
+	Another example are the architecture specific Makefiles which
+	need special rules to prepare boot images etc.
 
 	Special rules are written as normal Make rules.
 	Kbuild is not executing in the directory where the Makefile is
@@ -387,22 +387,22 @@ more details, with real examples.
 
 --- 3.11 $(CC) support functions
 
-	The kernel may be build with several different versions of
+	The kernel may be built with several different versions of
 	$(CC), each supporting a unique set of features and options.
 	kbuild provide basic support to check for valid options for $(CC).
 	$(CC) is useally the gcc compiler, but other alternatives are
 	available.
 
     as-option
-    	as-option is used to check if $(CC) when used to compile
-	assembler (*.S) files supports the given option. An optional
-	second option may be specified if first option are not supported.
+	as-option is used to check if $(CC) -- when used to compile
+	assembler (*.S) files -- supports the given option. An optional
+	second option may be specified if the first option is not supported.
 
 	Example:
 		#arch/sh/Makefile
 		cflags-y += $(call as-option,-Wa$(comma)-isa=$(isa-y),)
 
-	In the above example cflags-y will be assinged the the option
+	In the above example, cflags-y will be assigned the option
 	-Wa$(comma)-isa=$(isa-y) if it is supported by $(CC).
 	The second argument is optional, and if supplied will be used
 	if first argument is not supported.
@@ -422,7 +422,7 @@ more details, with real examples.
 	if first argument is not supported.
 
     cc-option
-	cc-option is used to check if $(CC) support a given option, and not
+	cc-option is used to check if $(CC) supports a given option, and not
 	supported to use an optional second option.
 
 	Example:
@@ -430,8 +430,8 @@ more details, with real examples.
 		cflags-y += $(call cc-option,-march=pentium-mmx,-march=i586)
 
 	In the above example cflags-y will be assigned the option
-	-march=pentium-mmx if supported by $(CC), otherwise -march-i586.
-	The second argument to cc-option is optional, and if omitted
+	-march=pentium-mmx if supported by $(CC), otherwise -march=i586.
+	The second argument to cc-option is optional, and if omitted,
 	cflags-y will be assigned no value if first option is not supported.
 
    cc-option-yn
@@ -444,14 +444,15 @@ more details, with real examples.
 		aflags-$(biarch) += -a32
 		cflags-$(biarch) += -m32
 	
-	In the above example $(biarch) is set to y if $(CC) supports the -m32
-	option. When $(biarch) equals to y the expanded variables $(aflags-y)
-	and $(cflags-y) will be assigned the values -a32 and -m32.
+	In the above example, $(biarch) is set to y if $(CC) supports the -m32
+	option. When $(biarch) equals 'y', the expanded variables $(aflags-y)
+	and $(cflags-y) will be assigned the values -a32 and -m32,
+	respectively.
 
     cc-option-align
-	gcc version >= 3.0 shifted type of options used to speify
-	alignment of functions, loops etc. $(cc-option-align) whrn used
-	as prefix to the align options will select the right prefix:
+	gcc versions >= 3.0 changed the type of options used to specify
+	alignment of functions, loops etc. $(cc-option-align), when used
+	as prefix to the align options, will select the right prefix:
 	gcc < 3.00
 		cc-option-align = -malign
 	gcc >= 3.00
@@ -460,15 +461,15 @@ more details, with real examples.
 	Example:
 		CFLAGS += $(cc-option-align)-functions=4
 
-	In the above example the option -falign-functions=4 is used for
-	gcc >= 3.00. For gcc < 3.00 -malign-functions=4 is used.
+	In the above example, the option -falign-functions=4 is used for
+	gcc >= 3.00. For gcc < 3.00, -malign-functions=4 is used.
 	
     cc-version
-	cc-version return a numerical version of the $(CC) compiler version.
+	cc-version returns a numerical version of the $(CC) compiler version.
 	The format is <major><minor> where both are two digits. So for example
 	gcc 3.41 would return 0341.
 	cc-version is useful when a specific $(CC) version is faulty in one
-	area, for example the -mregparm=3 were broken in some gcc version
+	area, for example -mregparm=3 was broken in some gcc versions
 	even though the option was accepted by gcc.
 
 	Example:
@@ -477,18 +478,18 @@ more details, with real examples.
 		if [ $(call cc-version) -ge 0300 ] ; then \
 			echo "-mregparm=3"; fi ;)
 
-	In the above example -mregparm=3 is only used for gcc version greater
+	In the above example, -mregparm=3 is only used for gcc version greater
 	than or equal to gcc 3.0.
 
     cc-ifversion
-	cc-ifversion test the version of $(CC) and equals last argument if
+	cc-ifversion tests the version of $(CC) and equals last argument if
 	version expression is true.
 
 	Example:
 		#fs/reiserfs/Makefile
 		EXTRA_CFLAGS := $(call cc-ifversion, -lt, 0402, -O1)
 
-	In this example EXTRA_CFLAGS will be assigned the value -O1 if the
+	In this example, EXTRA_CFLAGS will be assigned the value -O1 if the
 	$(CC) version is less than 4.2.
 	cc-ifversion takes all the shell operators: 
 	-eq, -ne, -lt, -le, -gt, and -ge
@@ -529,7 +530,7 @@ Both possibilities are described in the 
 	Host programs can be made up based on composite objects.
 	The syntax used to define composite objects for host programs is
 	similar to the syntax used for kernel objects.
-	$(<executeable>-objs) list all objects used to link the final
+	$(<executeable>-objs) lists all objects used to link the final
 	executable.
 
 	Example:
@@ -538,9 +539,9 @@ Both possibilities are described in the 
 		lxdialog-objs := checklist.o lxdialog.o
 
 	Objects with extension .o are compiled from the corresponding .c
-	files. In the above example checklist.c is compiled to checklist.o
+	files. In the above example, checklist.c is compiled to checklist.o
 	and lxdialog.c is compiled to lxdialog.o.
-	Finally the two .o files are linked to the executable, lxdialog.
+	Finally, the two .o files are linked to the executable, lxdialog.
 	Note: The syntax <executable>-y is not permitted for host-programs.
 
 --- 4.3 Defining shared libraries  
@@ -594,7 +595,7 @@ Both possibilities are described in the 
 	The programs will always be compiled utilising $(HOSTCC) passed
 	the options specified in $(HOSTCFLAGS).
 	To set flags that will take effect for all host programs created
-	in that Makefile use the variable HOST_EXTRACFLAGS.
+	in that Makefile, use the variable HOST_EXTRACFLAGS.
 
 	Example:
 		#scripts/lxdialog/Makefile
@@ -613,7 +614,8 @@ Both possibilities are described in the 
 		#scripts/kconfig/Makefile
 		HOSTLOADLIBES_qconf := -L$(QTDIR)/lib
 
-	When linking qconf it will be passed the extra option "-L$(QTDIR)/lib".
+	When linking qconf, it will be passed the extra option
+	"-L$(QTDIR)/lib".
  
 --- 4.6 When host programs are actually built
 
@@ -648,7 +650,7 @@ Both possibilities are described in the 
 
 --- 4.7 Using hostprogs-$(CONFIG_FOO)
 
-	A typcal pattern in a Kbuild file lok like this:
+	A typcal pattern in a Kbuild file looks like this:
 
 	Example:
 		#scripts/Makefile
@@ -656,13 +658,13 @@ Both possibilities are described in the 
 
 	Kbuild knows about both 'y' for built-in and 'm' for module.
 	So if a config symbol evaluate to 'm', kbuild will still build
-	the binary. In other words Kbuild handle hostprogs-m exactly
-	like hostprogs-y. But only hostprogs-y is recommend used
-	when no CONFIG symbol are involved.
+	the binary. In other words, Kbuild handles hostprogs-m exactly
+	like hostprogs-y. But only hostprogs-y is recommended to be used
+	when no CONFIG symbols are involved.
 
 === 5 Kbuild clean infrastructure
 
-"make clean" deletes most generated files in the src tree where the kernel
+"make clean" deletes most generated files in the obj tree where the kernel
 is compiled. This includes generated files such as host programs.
 Kbuild knows targets listed in $(hostprogs-y), $(hostprogs-m), $(always),
 $(extra-y) and $(targets). They are all deleted during "make clean".
@@ -723,29 +725,29 @@ be visited during "make clean".
 
 The top level Makefile sets up the environment and does the preparation,
 before starting to descend down in the individual directories.
-The top level makefile contains the generic part, whereas the
-arch/$(ARCH)/Makefile contains what is required to set-up kbuild
-to the said architecture.
-To do so arch/$(ARCH)/Makefile sets a number of variables, and defines
+The top level makefile contains the generic part, whereas
+arch/$(ARCH)/Makefile contains what is required to set up kbuild
+for said architecture.
+To do so, arch/$(ARCH)/Makefile sets up a number of variables and defines
 a few targets.
 
-When kbuild executes the following steps are followed (roughly):
-1) Configuration of the kernel => produced .config
+When kbuild executes, the following steps are followed (roughly):
+1) Configuration of the kernel => produce .config
 2) Store kernel version in include/linux/version.h
 3) Symlink include/asm to include/asm-$(ARCH)
 4) Updating all other prerequisites to the target prepare:
    - Additional prerequisites are specified in arch/$(ARCH)/Makefile
 5) Recursively descend down in all directories listed in
    init-* core* drivers-* net-* libs-* and build all targets.
-   - The value of the above variables are extended in arch/$(ARCH)/Makefile.
+   - The values of the above variables are expanded in arch/$(ARCH)/Makefile.
 6) All object files are then linked and the resulting file vmlinux is 
-   located at the root of the src tree.
+   located at the root of the obj tree.
    The very first objects linked are listed in head-y, assigned by
    arch/$(ARCH)/Makefile.
-7) Finally the architecture specific part does any required post processing
+7) Finally, the architecture specific part does any required post processing
    and builds the final bootimage.
    - This includes building boot records
-   - Preparing initrd images and the like
+   - Preparing initrd images and thelike
 
 
 --- 6.1 Set variables to tweak the build to the architecture
@@ -770,7 +772,7 @@ When kbuild executes the following steps
     LDFLAGS_vmlinux	Options for $(LD) when linking vmlinux
 
 	LDFLAGS_vmlinux is used to specify additional flags to pass to
-	the linker when linking the final vmlinux.
+	the linker when linking the final vmlinux image.
 	LDFLAGS_vmlinux uses the LDFLAGS_$@ support.
 
 	Example:
@@ -780,7 +782,7 @@ When kbuild executes the following steps
     OBJCOPYFLAGS	objcopy flags
 
 	When $(call if_changed,objcopy) is used to translate a .o file,
-	then the flags specified in OBJCOPYFLAGS will be used.
+	the flags specified in OBJCOPYFLAGS will be used.
 	$(call if_changed,objcopy) is often used to generate raw binaries on
 	vmlinux.
 
@@ -792,7 +794,7 @@ When kbuild executes the following steps
 		$(obj)/image: vmlinux FORCE
 			$(call if_changed,objcopy)
 
-	In this example the binary $(obj)/image is a binary version of
+	In this example, the binary $(obj)/image is a binary version of
 	vmlinux. The usage of $(call if_changed,xxx) will be described later.
 
     AFLAGS		$(AS) assembler flags
@@ -809,7 +811,7 @@ When kbuild executes the following steps
 	Default value - see top level Makefile
 	Append or modify as required per architecture.
 
-	Often the CFLAGS variable depends on the configuration.
+	Often, the CFLAGS variable depends on the configuration.
 
 	Example:
 		#arch/i386/Makefile
@@ -830,7 +832,7 @@ When kbuild executes the following steps
 		...
 
 
-	The first examples utilises the trick that a config option expands
+	The first example utilises the trick that a config option expands
 	to 'y' when selected.
 
     CFLAGS_KERNEL	$(CC) options specific for built-in
@@ -846,15 +848,15 @@ When kbuild executes the following steps
  
 --- 6.2 Add prerequisites to archprepare:
 
-	The archprepare: rule is used to list prerequisites that needs to be
+	The archprepare: rule is used to list prerequisites that need to be
 	built before starting to descend down in the subdirectories.
-	This is usual header files containing assembler constants.
+	This is usually used for header files containing assembler constants.
 
 		Example:
 		#arch/arm/Makefile
 		archprepare: maketools
 
-	In this example the file target maketools will be processed
+	In this example, the file target maketools will be processed
 	before descending down in the subdirectories.
 	See also chapter XXX-TODO that describe how kbuild supports
 	generating offset header files.
@@ -870,15 +872,16 @@ When kbuild executes the following steps
 	
     head-y, init-y, core-y, libs-y, drivers-y, net-y
 
-	$(head-y) list objects to be linked first in vmlinux.
-	$(libs-y) list directories where a lib.a archive can be located.
-	The rest list directories where a built-in.o object file can be located.
+	$(head-y) lists objects to be linked first in vmlinux.
+	$(libs-y) lists directories where a lib.a archive can be located.
+	The rest lists directories where a built-in.o object file can be
+	located.
 
 	$(init-y) objects will be located after $(head-y).
 	Then the rest follows in this order:
 	$(core-y), $(libs-y), $(drivers-y) and $(net-y).
 
-	The top level Makefile define values for all generic directories,
+	The top level Makefile defines values for all generic directories,
 	and arch/$(ARCH)/Makefile only adds architecture specific directories.
 
 	Example:
@@ -915,9 +918,9 @@ When kbuild executes the following steps
 	"$(Q)$(MAKE) $(build)=<dir>" is the recommended way to invoke
 	make in a subdirectory.
 
-	There are no rules for naming of the architecture specific targets,
+	There are no rules for naming architecture specific targets,
 	but executing "make help" will list all relevant targets.
-	To support this $(archhelp) must be defined.
+	To support this, $(archhelp) must be defined.
 
 	Example:
 		#arch/i386/Makefile
@@ -928,8 +931,8 @@ When kbuild executes the following steps
 	When make is executed without arguments, the first goal encountered
 	will be built. In the top level Makefile the first goal present
 	is all:.
-	An architecture shall always per default build a bootable image.
-	In "make help" the default goal is highlighted with a '*'.
+	An architecture shall always, per default, build a bootable image.
+	In "make help", the default goal is highlighted with a '*'.
 	Add a new prerequisite to all: to select a default goal different
 	from vmlinux.
 
@@ -955,7 +958,7 @@ When kbuild executes the following steps
 		#arch/i386/kernel/Makefile
 		extra-y := head.o init_task.o
 
-	In this example extra-y is used to list object files that
+	In this example, extra-y is used to list object files that
 	shall be built, but shall not be linked as part of built-in.o.
 
 	
@@ -972,8 +975,8 @@ When kbuild executes the following steps
 		target: source(s) FORCE
 			$(call if_changed,ld/objcopy/gzip)
 
-	When the rule is evaluated it is checked to see if any files
-	needs an update, or the commandline has changed since last
+	When the rule is evaluated, it is checked to see if any files
+	needs an update, or the command line has changed since the last
 	invocation. The latter will force a rebuild if any options
 	to the executable have changed.
 	Any target that utilises if_changed must be listed in $(targets),
@@ -991,7 +994,7 @@ When kbuild executes the following steps
 	#WRONG!#	$(call if_changed, ld/objcopy/gzip)
 
     ld
-	Link target. Often LDFLAGS_$@ is used to set specific options to ld.
+	Link target. Often, LDFLAGS_$@ is used to set specific options to ld.
 	
     objcopy
 	Copy binary. Uses OBJCOPYFLAGS usually specified in
@@ -1010,10 +1013,10 @@ When kbuild executes the following steps
 		$(obj)/setup $(obj)/bootsect: %: %.o FORCE
 			$(call if_changed,ld)
 
-	In this example there are two possible targets, requiring different
-	options to the linker. the linker options are specified using the
+	In this example, there are two possible targets, requiring different
+	options to the linker. The linker options are specified using the
 	LDFLAGS_$@ syntax - one for each potential target.
-	$(targets) are assinged all potential targets, herby kbuild knows
+	$(targets) are assinged all potential targets, by which kbuild knows
 	the targets and will:
 		1) check for commandline changes
 		2) delete target during make clean
@@ -1027,7 +1030,7 @@ When kbuild executes the following steps
 
 --- 6.7 Custom kbuild commands
 
-	When kbuild is executing with KBUILD_VERBOSE=0 then only a shorthand
+	When kbuild is executing with KBUILD_VERBOSE=0, then only a shorthand
 	of a command is normally displayed.
 	To enable this behaviour for custom commands kbuild requires
 	two variables to be set:
@@ -1045,7 +1048,7 @@ When kbuild executes the following steps
 			$(call if_changed,image)
 			@echo 'Kernel: $@ is ready'
 
-	When updating the $(obj)/bzImage target the line:
+	When updating the $(obj)/bzImage target, the line
 
 	BUILD    arch/i386/boot/bzImage
 
@@ -1054,11 +1057,11 @@ When kbuild executes the following steps
 
 --- 6.8 Preprocessing linker scripts
 
-	When the vmlinux image is build the linker script:
+	When the vmlinux image is built, the linker script
 	arch/$(ARCH)/kernel/vmlinux.lds is used.
 	The script is a preprocessed variant of the file vmlinux.lds.S
 	located in the same directory.
-	kbuild knows .lds file and includes a rule *lds.S -> *lds.
+	kbuild knows .lds files and includes a rule *lds.S -> *lds.
 	
 	Example:
 		#arch/i386/kernel/Makefile
@@ -1068,11 +1071,11 @@ When kbuild executes the following steps
 		export CPPFLAGS_vmlinux.lds += -P -C -U$(ARCH)
 		
 	The assigment to $(always) is used to tell kbuild to build the
-	target: vmlinux.lds.
-	The assignment to $(CPPFLAGS_vmlinux.lds) tell kbuild to use the
+	target vmlinux.lds.
+	The assignment to $(CPPFLAGS_vmlinux.lds) tells kbuild to use the
 	specified options when building the target vmlinux.lds.
 	
-	When building the *.lds target kbuild used the variakles:
+	When building the *.lds target, kbuild uses the variables:
 	CPPFLAGS	: Set in top-level Makefile
 	EXTRA_CPPFLAGS	: May be set in the kbuild makefile
 	CPPFLAGS_$(@F)  : Target specific flags.
@@ -1147,7 +1150,7 @@ The top Makefile exports the following v
 
 === 8 Makefile language
 
-The kernel Makefiles are designed to run with GNU Make.  The Makefiles
+The kernel Makefiles are designed to be run with GNU Make.  The Makefiles
 use only the documented features of GNU Make, but they do use many
 GNU extensions.
 
@@ -1169,10 +1172,11 @@ is the right choice.
 Original version made by Michael Elizabeth Chastain, <mailto:mec@shout.net>
 Updates by Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
 Updates by Sam Ravnborg <sam@ravnborg.org>
+Language QA by Jan Engelhardt <jengelh@gmx.de>
 
 === 10 TODO
 
-- Describe how kbuild support shipped files with _shipped.
+- Describe how kbuild supports shipped files with _shipped.
 - Generating offset header files.
 - Add more variables to section 7?
 
-- 
1.4.1

