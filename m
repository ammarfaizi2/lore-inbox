Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751820AbWHNDfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbWHNDfW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 23:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751828AbWHNDfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 23:35:22 -0400
Received: from xenotime.net ([66.160.160.81]:31156 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751820AbWHNDfV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 23:35:21 -0400
Date: Sun, 13 Aug 2006 20:38:10 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] kbuild: more doc. cleanups
Message-Id: <20060813203810.37d244b7.rdunlap@xenotime.net>
In-Reply-To: <20060813210907.GA22409@mars.ravnborg.org>
References: <20060813194503.GA21736@mars.ravnborg.org>
	<20060813135426.8211204c.rdunlap@xenotime.net>
	<20060813135754.3c4a83a6.rdunlap@xenotime.net>
	<20060813210907.GA22409@mars.ravnborg.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Aug 2006 23:09:07 +0200 Sam Ravnborg wrote:

> On Sun, Aug 13, 2006 at 01:57:54PM -0700, Randy.Dunlap wrote:
> > On Sun, 13 Aug 2006 13:54:26 -0700 Randy.Dunlap wrote:
> > 
> > > Were any of these used?
> > > http://marc.theaimsgroup.com/?l=linux-kernel&m=115410865910922&w=2
> 
> No. I have your original mail queued but never got around to it.
> A resubmit would be appreciated - with proper Signed-of-by:...

---
From: Randy Dunlap <rdunlap@xenotime.net>

Fix typos/spellos in kbuild/makefiles.txt.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/kbuild/makefiles.txt |   33 +++++++++++++++++----------------
 1 files changed, 17 insertions(+), 16 deletions(-)

--- linux-2618-rc4-ext4.orig/Documentation/kbuild/makefiles.txt
+++ linux-2618-rc4-ext4/Documentation/kbuild/makefiles.txt
@@ -34,7 +34,7 @@ This document describes the Linux kernel
 	   --- 6.1 Set variables to tweak the build to the architecture
 	   --- 6.2 Add prerequisites to archprepare:
 	   --- 6.3 List directories to visit when descending
-	   --- 6.4 Architecture specific boot images
+	   --- 6.4 Architecture-specific boot images
 	   --- 6.5 Building non-kbuild targets
 	   --- 6.6 Commands useful for building a boot image
 	   --- 6.7 Custom kbuild commands
@@ -124,7 +124,7 @@ more details, with real examples.
 	Example:
 		obj-y += foo.o
 
-	This tell kbuild that there is one object in that directory, named
+	This tells kbuild that there is one object in that directory, named
 	foo.o. foo.o will be built from foo.c or foo.S.
 
 	If foo.o shall be built as a module, the variable obj-m is used.
@@ -353,7 +353,7 @@ more details, with real examples.
 	Special rules are used when the kbuild infrastructure does
 	not provide the required support. A typical example is
 	header files generated during the build process.
-	Another example are the architecture specific Makefiles which
+	Another example are the architecture-specific Makefiles which
 	need special rules to prepare boot images etc.
 
 	Special rules are written as normal Make rules.
@@ -416,7 +416,7 @@ more details, with real examples.
 		#arch/i386/kernel/Makefile
 		vsyscall-flags += $(call ld-option, -Wl$(comma)--hash-style=sysv)
 
-	In the above example vsyscall-flags will be assigned the option
+	In the above example, vsyscall-flags will be assigned the option
 	-Wl$(comma)--hash-style=sysv if it is supported by $(CC).
 	The second argument is optional, and if supplied will be used
 	if first argument is not supported.
@@ -429,7 +429,7 @@ more details, with real examples.
 		#arch/i386/Makefile
 		cflags-y += $(call cc-option,-march=pentium-mmx,-march=i586)
 
-	In the above example cflags-y will be assigned the option
+	In the above example, cflags-y will be assigned the option
 	-march=pentium-mmx if supported by $(CC), otherwise -march=i586.
 	The second argument to cc-option is optional, and if omitted,
 	cflags-y will be assigned no value if first option is not supported.
@@ -650,14 +650,14 @@ Both possibilities are described in the 
 
 --- 4.7 Using hostprogs-$(CONFIG_FOO)
 
-	A typcal pattern in a Kbuild file looks like this:
+	A typical pattern in a Kbuild file looks like this:
 
 	Example:
 		#scripts/Makefile
 		hostprogs-$(CONFIG_KALLSYMS) += kallsyms
 
 	Kbuild knows about both 'y' for built-in and 'm' for module.
-	So if a config symbol evaluate to 'm', kbuild will still build
+	So if a config symbol evaluates to 'm', kbuild will still build
 	the binary. In other words, Kbuild handles hostprogs-m exactly
 	like hostprogs-y. But only hostprogs-y is recommended to be used
 	when no CONFIG symbols are involved.
@@ -744,10 +744,10 @@ When kbuild executes, the following step
    located at the root of the obj tree.
    The very first objects linked are listed in head-y, assigned by
    arch/$(ARCH)/Makefile.
-7) Finally, the architecture specific part does any required post processing
+7) Finally, the architecture-specific part does any required post processing
    and builds the final bootimage.
    - This includes building boot records
-   - Preparing initrd images and thelike
+   - Preparing initrd images and the like
 
 
 --- 6.1 Set variables to tweak the build to the architecture
@@ -874,7 +874,7 @@ When kbuild executes, the following step
 
 	$(head-y) lists objects to be linked first in vmlinux.
 	$(libs-y) lists directories where a lib.a archive can be located.
-	The rest lists directories where a built-in.o object file can be
+	The rest list directories where a built-in.o object file can be
 	located.
 
 	$(init-y) objects will be located after $(head-y).
@@ -882,7 +882,7 @@ When kbuild executes, the following step
 	$(core-y), $(libs-y), $(drivers-y) and $(net-y).
 
 	The top level Makefile defines values for all generic directories,
-	and arch/$(ARCH)/Makefile only adds architecture specific directories.
+	and arch/$(ARCH)/Makefile only adds architecture-specific directories.
 
 	Example:
 		#arch/sparc64/Makefile
@@ -891,7 +891,7 @@ When kbuild executes, the following step
 		drivers-$(CONFIG_OPROFILE)  += arch/sparc64/oprofile/
 
 
---- 6.4 Architecture specific boot images
+--- 6.4 Architecture-specific boot images
 
 	An arch Makefile specifies goals that take the vmlinux file, compress
 	it, wrap it in bootstrapping code, and copy the resulting files
@@ -918,7 +918,7 @@ When kbuild executes, the following step
 	"$(Q)$(MAKE) $(build)=<dir>" is the recommended way to invoke
 	make in a subdirectory.
 
-	There are no rules for naming architecture specific targets,
+	There are no rules for naming architecture-specific targets,
 	but executing "make help" will list all relevant targets.
 	To support this, $(archhelp) must be defined.
 
@@ -976,7 +976,7 @@ When kbuild executes, the following step
 			$(call if_changed,ld/objcopy/gzip)
 
 	When the rule is evaluated, it is checked to see if any files
-	needs an update, or the command line has changed since the last
+	need an update, or the command line has changed since the last
 	invocation. The latter will force a rebuild if any options
 	to the executable have changed.
 	Any target that utilises if_changed must be listed in $(targets),
@@ -1016,7 +1016,7 @@ When kbuild executes, the following step
 	In this example, there are two possible targets, requiring different
 	options to the linker. The linker options are specified using the
 	LDFLAGS_$@ syntax - one for each potential target.
-	$(targets) are assinged all potential targets, by which kbuild knows
+	$(targets) are assigned all potential targets, by which kbuild knows
 	the targets and will:
 		1) check for commandline changes
 		2) delete target during make clean
@@ -1083,7 +1083,7 @@ When kbuild executes, the following step
 	                  assignment.
 
 	The kbuild infrastructure for *lds file are used in several
-	architecture specific files.
+	architecture-specific files.
 
 
 === 7 Kbuild Variables
@@ -1127,7 +1127,7 @@ The top Makefile exports the following v
 
 	This variable defines a place for the arch Makefiles to install
 	the resident kernel image and System.map file.
-	Use this for architecture specific install targets.
+	Use this for architecture-specific install targets.
 
     INSTALL_MOD_PATH, MODLIB
 
