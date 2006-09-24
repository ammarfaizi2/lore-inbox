Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWIXVOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWIXVOH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 17:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbWIXVNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 17:13:19 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:2450 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S932112AbWIXVNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:13:10 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Jan Engelhardt <jengelh@gmx.de>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 8/28] kbuild: linguistic fixes for Documentation/kbuild/modules.txt
Reply-To: sam@ravnborg.org
Date: Sun, 24 Sep 2006 23:18:04 +0200
Message-Id: <11591327051061-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11591327053484-git-send-email-sam@ravnborg.org>
References: 20060924210827.GA26969@uranus.ravnborg.org <1159132704708-git-send-email-sam@ravnborg.org> <11591327042606-git-send-email-sam@ravnborg.org> <11591327042944-git-send-email-sam@ravnborg.org> <11591327041272-git-send-email-sam@ravnborg.org> <11591327041374-git-send-email-sam@ravnborg.org> <11591327041093-git-send-email-sam@ravnborg.org> <11591327053484-git-send-email-sam@ravnborg.org>
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
 Documentation/kbuild/modules.txt |  119 +++++++++++++++++++-------------------
 1 files changed, 60 insertions(+), 59 deletions(-)

diff --git a/Documentation/kbuild/modules.txt b/Documentation/kbuild/modules.txt
index 61fc079..a2a178d 100644
--- a/Documentation/kbuild/modules.txt
+++ b/Documentation/kbuild/modules.txt
@@ -1,7 +1,7 @@
 
 In this document you will find information about:
 - how to build external modules
-- how to make your module use kbuild infrastructure
+- how to make your module use the kbuild infrastructure
 - how kbuild will install a kernel
 - how to install modules in a non-standard location
 
@@ -36,13 +36,13 @@ In this document you will find informati
 
 kbuild includes functionality for building modules both
 within the kernel source tree and outside the kernel source tree.
-The latter is usually referred to as external modules and is used
-both during development and for modules that are not planned to be
-included in the kernel tree.
+The latter is usually referred to as external or "out-of-tree"
+modules and is used both during development and for modules that
+are not planned to be included in the kernel tree.
 
 What is covered within this file is mainly information to authors
-of modules. The author of an external modules should supply
-a makefile that hides most of the complexity so one only has to type
+of modules. The author of an external module should supply
+a makefile that hides most of the complexity, so one only has to type
 'make' to build the module. A complete example will be present in
 chapter 4, "Creating a kbuild file for an external module".
 
@@ -137,7 +137,7 @@ when building an external module.
 	      module versioning work.
 
 --- 2.5 Building separate files for a module
-	It is possible to build single files which is part of a module.
+	It is possible to build single files which are part of a module.
 	This works equal for the kernel, a module and even for external
 	modules.
 	Examples (module foo.ko, consist of bar.o, baz.o):
@@ -151,7 +151,7 @@ when building an external module.
 
 This example shows the actual commands to be executed when building
 an external module for the currently running kernel.
-In the example below the distribution is supposed to use the
+In the example below, the distribution is supposed to use the
 facility to locate output files for a kernel compile in a different
 directory than the kernel source - but the examples will also work
 when the source and the output files are mixed in the same directory.
@@ -170,7 +170,7 @@ the following commands to build the modu
 	        O=/lib/modules/`uname-r`/build        \
 	        M=`pwd`
 
-Then to install the module use the following command:
+Then, to install the module use the following command:
 
 	make -C /usr/src/`uname -r`/source            \
 	        O=/lib/modules/`uname-r`/build        \
@@ -230,7 +230,7 @@ following files:
 
 		endif
 
-	In example 1 the check for KERNELRELEASE is used to separate
+	In example 1, the check for KERNELRELEASE is used to separate
 	the two parts of the Makefile. kbuild will only see the two
 	assignments whereas make will see everything except the two
 	kbuild assignments.
@@ -255,7 +255,7 @@ following files:
 			echo "X" > 8123_bin_shipped
 
 
-	In example 2 we are down to two fairly simple files and for simple
+	In example 2, we are down to two fairly simple files and for simple
 	files as used in this example the split is questionable. But some
 	external modules use Makefiles of several hundred lines and here it
 	really pays off to separate the kbuild part from the rest.
@@ -282,9 +282,9 @@ following files:
 
 		endif
 
-		The trick here is to include the Kbuild file from Makefile so
-		if an older version of kbuild picks up the Makefile the Kbuild
-		file will be included.
+	The trick here is to include the Kbuild file from Makefile, so
+	if an older version of kbuild picks up the Makefile, the Kbuild
+	file will be included.
 
 --- 4.2 Binary blobs included in a module
 
@@ -301,18 +301,19 @@ following files:
 		obj-m  := 8123.o
 		8123-y := 8123_if.o 8123_pci.o 8123_bin.o
 
-	In example 4 there is no distinction between the ordinary .c/.h files
+	In example 4, there is no distinction between the ordinary .c/.h files
 	and the binary file. But kbuild will pick up different rules to create
 	the .o file.
 
 
 === 5. Include files
 
-Include files are a necessity when a .c file uses something from another .c
-files (not strictly in the sense of .c but if good programming practice is
-used). Any module that consist of more than one .c file will have a .h file
+Include files are a necessity when a .c file uses something from other .c
+files (not strictly in the sense of C, but if good programming practice is
+used). Any module that consists of more than one .c file will have a .h file
 for one of the .c files. 
-- If the .h file only describes a module internal interface then the .h file
+
+- If the .h file only describes a module internal interface, then the .h file
   shall be placed in the same directory as the .c files.
 - If the .h files describe an interface used by other parts of the kernel
   located in different directories, the .h files shall be located in
@@ -323,11 +324,11 @@ under include/ such as include/scsi. Ano
 .h files which are located under include/asm-$(ARCH)/*.
 
 External modules have a tendency to locate include files in a separate include/
-directory and therefore needs to deal with this in their kbuild file.
+directory and therefore need to deal with this in their kbuild file.
 
 --- 5.1 How to include files from the kernel include dir
 
-	When a module needs to include a file from include/linux/ then one
+	When a module needs to include a file from include/linux/, then one
 	just uses:
 
 		#include <linux/modules.h>
@@ -348,7 +349,7 @@ directory and therefore needs to deal wi
 	The trick here is to use either EXTRA_CFLAGS (take effect for all .c
 	files) or CFLAGS_$F.o (take effect only for a single file).
 
-	In our example if we move 8123_if.h to a subdirectory named include/
+	In our example, if we move 8123_if.h to a subdirectory named include/
 	the resulting Kbuild file would look like:
 
 		--> filename: Kbuild
@@ -362,9 +363,9 @@ directory and therefore needs to deal wi
 
 --- 5.3 External modules using several directories
 
-	If an external module does not follow the usual kernel style but
-	decide to spread files over several directories then kbuild can
-	support this too.
+	If an external module does not follow the usual kernel style, but
+	decides to spread files over several directories, then kbuild can
+	handle this too.
 
 	Consider the following example:
 	
@@ -374,7 +375,7 @@ directory and therefore needs to deal wi
 	|   +- hal/include/hardwareif.h
 	+- include/complex.h
 	
-	To build a single module named complex.ko we then need the following
+	To build a single module named complex.ko, we then need the following
 	kbuild file:
 
 	Kbuild:
@@ -387,12 +388,12 @@ directory and therefore needs to deal wi
 
 
 	kbuild knows how to handle .o files located in another directory -
-	although this is NOT reccommended practice. The syntax is to specify
+	although this is NOT recommended practice. The syntax is to specify
 	the directory relative to the directory where the Kbuild file is
 	located.
 
-	To find the .h files we have to explicitly tell kbuild where to look
-	for the .h files. When kbuild executes current directory is always
+	To find the .h files, we have to explicitly tell kbuild where to look
+	for the .h files. When kbuild executes, the current directory is always
 	the root of the kernel tree (argument to -C) and therefore we have to
 	tell kbuild how to find the .h files using absolute paths.
 	$(src) will specify the absolute path to the directory where the
@@ -412,7 +413,7 @@ External modules are installed in the di
 
 --- 6.1 INSTALL_MOD_PATH
 
-	Above are the default directories, but as always some level of
+	Above are the default directories, but as always, some level of
 	customization is possible. One can prefix the path using the variable
 	INSTALL_MOD_PATH:
 
@@ -420,17 +421,17 @@ External modules are installed in the di
 		=> Install dir: /frodo/lib/modules/$(KERNELRELEASE)/kernel
 
 	INSTALL_MOD_PATH may be set as an ordinary shell variable or as in the
-	example above be specified on the command line when calling make.
+	example above, can be specified on the command line when calling make.
 	INSTALL_MOD_PATH has effect both when installing modules included in
 	the kernel as well as when installing external modules.
 
 --- 6.2 INSTALL_MOD_DIR
 
-	When installing external modules they are default installed in a
+	When installing external modules they are by default installed to a
 	directory under /lib/modules/$(KERNELRELEASE)/extra, but one may wish
 	to locate modules for a specific functionality in a separate
-	directory. For this purpose one can use INSTALL_MOD_DIR to specify an
-	alternative name than 'extra'.
+	directory. For this purpose, one can use INSTALL_MOD_DIR to specify an
+	alternative name to 'extra'.
 
 		$ make INSTALL_MOD_DIR=gandalf -C KERNELDIR \
 			M=`pwd` modules_install
@@ -444,16 +445,16 @@ Module versioning is enabled by the CONF
 Module versioning is used as a simple ABI consistency check. The Module
 versioning creates a CRC value of the full prototype for an exported symbol and
 when a module is loaded/used then the CRC values contained in the kernel are
-compared with similar values in the module. If they are not equal then the
+compared with similar values in the module. If they are not equal, then the
 kernel refuses to load the module.
 
 Module.symvers contains a list of all exported symbols from a kernel build.
 
 --- 7.1 Symbols fron the kernel (vmlinux + modules)
 
-	During a kernel build a file named Module.symvers will be generated.
+	During a kernel build, a file named Module.symvers will be generated.
 	Module.symvers contains all exported symbols from the kernel and
-	compiled modules. For each symbols the corresponding CRC value
+	compiled modules. For each symbols, the corresponding CRC value
 	is stored too.
 
 	The syntax of the Module.symvers file is:
@@ -461,27 +462,27 @@ Module.symvers contains a list of all ex
 	Sample:
 		0x2d036834  scsi_remove_host   drivers/scsi/scsi_mod
 
-	For a kernel build without CONFIG_MODVERSIONING enabled the crc
+	For a kernel build without CONFIG_MODVERSIONING enabled, the crc
 	would read: 0x00000000
 
-	Module.symvers serve two purposes.
-	1) It list all exported symbols both from vmlinux and all modules
-	2) It list CRC if CONFIG_MODVERSION is enabled
+	Module.symvers serves two purposes:
+	1) It lists all exported symbols both from vmlinux and all modules
+	2) It lists the CRC if CONFIG_MODVERSION is enabled
 
 --- 7.2 Symbols and external modules
 
-	When building an external module the build system needs access to
+	When building an external module, the build system needs access to
 	the symbols from the kernel to check if all external symbols are
 	defined. This is done in the MODPOST step and to obtain all
-	symbols modpost reads Module.symvers from the kernel.
+	symbols, modpost reads Module.symvers from the kernel.
 	If a Module.symvers file is present in the directory where
-	the external module is being build this file will be read too.
-	During the MODPOST step a new Module.symvers file will be written
-	containing all exported symbols that was not defined in the kernel.
+	the external module is being built, this file will be read too.
+	During the MODPOST step, a new Module.symvers file will be written
+	containing all exported symbols that were not defined in the kernel.
 	
 --- 7.3 Symbols from another external module
 
-	Sometimes one external module uses exported symbols from another
+	Sometimes, an external module uses exported symbols from another
 	external module. Kbuild needs to have full knowledge on all symbols
 	to avoid spitting out warnings about undefined symbols.
 	Two solutions exist to let kbuild know all symbols of more than
@@ -490,9 +491,9 @@ Module.symvers contains a list of all ex
 	impractical in certain situations.
 
 	Use a top-level Kbuild file
-		If you have two modules: 'foo', 'bar' and 'foo' needs symbols
-		from 'bar' then one can use a common top-level kbuild file so
-		both modules are compiled in same build.
+		If you have two modules: 'foo' and 'bar', and 'foo' needs
+		symbols from 'bar', then one can use a common top-level kbuild
+		file so both modules are compiled in same build.
 
 		Consider following directory layout:
 		./foo/ <= contains the foo module
@@ -509,15 +510,15 @@ Module.symvers contains a list of all ex
 		knowledge on symbols from both modules.
 
 	Use an extra Module.symvers file
-		When an external module is build a Module.symvers file is
+		When an external module is built, a Module.symvers file is
 		generated containing all exported symbols which are not
 		defined in the kernel.
-		To get access to symbols from module 'bar' one can copy the
+		To get access to symbols from module 'bar', one can copy the
 		Module.symvers file from the compilation of the 'bar' module
-		to the directory where the 'foo' module is build.
-		During the module build kbuild will read the Module.symvers
+		to the directory where the 'foo' module is built.
+		During the module build, kbuild will read the Module.symvers
 		file in the directory of the external module and when the
-		build is finished a new Module.symvers file is created
+		build is finished, a new Module.symvers file is created
 		containing the sum of all symbols defined and not part of the
 		kernel.
 		
@@ -525,7 +526,7 @@ Module.symvers contains a list of all ex
 
 --- 8.1 Testing for CONFIG_FOO_BAR
 
-	Modules often needs to check for certain CONFIG_ options to decide if
+	Modules often need to check for certain CONFIG_ options to decide if
 	a specific feature shall be included in the module. When kbuild is used
 	this is done by referencing the CONFIG_ variable directly.
 
@@ -537,7 +538,7 @@ Module.symvers contains a list of all ex
 
 	External modules have traditionally used grep to check for specific
 	CONFIG_ settings directly in .config. This usage is broken.
-	As introduced before external modules shall use kbuild when building
-	and therefore can use the same methods as in-kernel modules when testing
-	for CONFIG_ definitions.
+	As introduced before, external modules shall use kbuild when building
+	and therefore can use the same methods as in-kernel modules when
+	testing for CONFIG_ definitions.
 
-- 
1.4.1

