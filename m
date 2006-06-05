Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750765AbWFEW1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWFEW1i (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 18:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWFEW1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 18:27:38 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:4761 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S1750765AbWFEW1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 18:27:37 -0400
Date: Tue, 6 Jun 2006 00:27:35 +0200
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: kbuild patch (20a468b51325b3636785a8ca0047ae514b39cbd5) breaks parallels-config
Message-ID: <20060605222735.GG4552@cip.informatik.uni-erlangen.de>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <20060605164950.GB4552@cip.informatik.uni-erlangen.de> <20060605213111.GA15346@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <20060605213111.GA15346@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Sam,

> x86 not supported - and I do not want to dig up my sparc...

this are all x86:

http://download.parallels.com/GA/Parallels-2.1.1670-lin.i386.rpm
http://download.parallels.com/GA/Parallels-2.1.1670-lin.deb
http://download.parallels.com/GA/Parallels-2.1.1670-lin.tgz
http://download.parallels.com/GA/Parallels-workstation.ebuild.tar.gz

> Can you please provide a copy of:
> -> The offending Makfile
> -> The exact command executed to build the module

a tgz of my /usr/lib/parallels is at
http://wwwcip.informatik.uni-erlangen.de/~sithglan/parallels/parallels.tgz (14M)

one offending Makefile attached.

this happens when I use the vanilla linux kernel without the patch:

(mini) [/usr/lib/parallels] ./configure
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for gawk... no
checking for mawk... mawk
checking whether make sets ${MAKE}... yes
checking whether to enable maintainer-specific portions of Makefiles... no
checking for gcc... gcc
checking for C compiler default output... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... no
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for style of include used by make... GNU
checking dependency style of gcc... gcc3
checking for g++... g++
checking whether we are using the GNU C++ compiler... yes
checking whether g++ accepts -g... yes
checking dependency style of g++... gcc3
checking whether make sets ${MAKE}... (cached) yes
checking build system type... i686-pc-linux
checking host system type... i686-pc-linux
checking for ld used by GCC... /usr/bin/ld
checking if the linker (/usr/bin/ld) is GNU ld... yes
checking for /usr/bin/ld option to reload object files... -r
checking for BSD-compatible nm... /usr/bin/nm -B
checking whether ln -s works... yes
checking how to recognise dependant libraries... pass_all
checking command to parse /usr/bin/nm -B output... ok
checking how to run the C preprocessor... gcc -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking dlfcn.h usability... yes
checking dlfcn.h presence... yes
checking for dlfcn.h... yes
checking for ranlib... ranlib
checking for strip... strip
checking for objdir... .libs
checking for gcc option to produce PIC... -fPIC
checking if gcc PIC flag -fPIC works... yes
checking if gcc static flag -static works... yes
checking if gcc supports -c -o file.o... yes
checking if gcc supports -c -o file.lo... yes
checking if gcc supports -fno-rtti -fno-exceptions... yes
checking whether the linker (/usr/bin/ld) supports shared libraries... yes
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking dynamic linker characteristics... GNU/Linux ld.so
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... yes
checking whether -lc should be explicitly linked in... no
creating libtool
checking for gcc option to accept ANSI C... none needed
checking for inline... inline
checking Check for primary OS type... Linux
checking Linux kernel version... 2.6.x
checking kernel sources... ok (/lib/modules/2.6.17-rc5/build)
checking abnormal 2.4.20 remap_page_range... remap_page_range not need vma struct
checking freezing kthreads patch... no
checking scheduling problems... schedule has sleep calculations
checking mmu_cr4_features address... cat: /proc/ksyms: No such file or directory
0x7858e670
checking for x86 platform... not a x86 platform
checking for Fedora Core stock kernel... not stock kernel used
configure: creating ./config.status
config.status: creating Makefile
config.status: creating drivers/Makefile
config.status: creating drivers/hypervisor/Makefile
config.status: creating drivers/drv_main/Makefile
config.status: creating drivers/drv_net/Makefile
config.status: creating drivers/drv_net/linux/Makefile
config.status: creating drivers/drv_virtualnic/Makefile
config.status: executing depfiles commands
(mini) [/usr/lib/parallels] make
Making all in drivers
make[1]: Entering directory `/usr/lib/parallels/drivers'
Making all in .
make[2]: Entering directory `/usr/lib/parallels/drivers'
=> Patching modules makefiles for 2.6.x kernel ...
for i in hypervisor/Makefile drv_main/Makefile drv_net/linux/Makefile drv_virtualnic/Makefile; do \
                sed s/CFLAGS\ =/CFLAGS\ :=\ \$\(CFLAGS\)/ $i | \
                sed s/obj_m/obj-m/ | \
                sed s/hypervisor_objs/hypervisor-objs/ | \
                sed s/vm_main_objs/vm-main-objs/ | \
                sed s/vm_bridge_objs/vm-bridge-objs/ | \
                sed s/vmvirtualnic_objs/vmvirtualnic-objs/ | \
                sed s/_extra_ldflags\ =/EXTRA_LDFLAGS+=/ | \
                sed s/_extra_cflags\ =/EXTRA_CFLAGS+=/ | \
                sed s/include\ .\\/\$\(DEPDIR\)/#/ > $i.t; mv -f $i.t $i;\
        done
cp -f drv_main/common/md5.c hypervisor/;
cp -f drv_main/common/utils.c hypervisor/;
make[2]: Leaving directory `/usr/lib/parallels/drivers'
Making all in hypervisor
make[2]: Entering directory `/usr/lib/parallels/drivers/hypervisor'
make -C /lib/modules/2.6.17-rc5/build SUBDIRS=/usr/lib/parallels/drivers/hypervisor SRCROOT=/usr/lib/parallels/drivers/hypervisor modules && mv -f hypervisor.ko hypervisor.o
make[3]: Entering directory `/home/sithglan/work/linux-2.6'
make -C /lib/modules/2.6.17-rc5/build SUBDIRS=/home/sithglan/work/linux-2.6 SRCROOT=/home/sithglan/work/linux-2.6 modules && mv -f hypervisor.ko hypervisor.o
make -C /lib/modules/2.6.17-rc5/build SUBDIRS=/home/sithglan/work/linux-2.6 SRCROOT=/home/sithglan/work/linux-2.6 modules && mv -f hypervisor.ko hypervisor.o
make -C /lib/modules/2.6.17-rc5/build SUBDIRS=/home/sithglan/work/linux-2.6 SRCROOT=/home/sithglan/work/linux-2.6 modules && mv -f hypervisor.ko hypervisor.o
make -C /lib/modules/2.6.17-rc5/build SUBDIRS=/home/sithglan/work/linux-2.6 SRCROOT=/home/sithglan/work/linux-2.6 modules && mv -f hypervisor.ko hypervisor.o
make -C /lib/modules/2.6.17-rc5/build SUBDIRS=/home/sithglan/work/linux-2.6 SRCROOT=/home/sithglan/work/linux-2.6 modules && mv -f hypervisor.ko hypervisor.o
make -C /lib/modules/2.6.17-rc5/build SUBDIRS=/home/sithglan/work/linux-2.6 SRCROOT=/home/sithglan/work/linux-2.6 modules && mv -f hypervisor.ko hypervisor.o
make -C /lib/modules/2.6.17-rc5/build SUBDIRS=/home/sithglan/work/linux-2.6 SRCROOT=/home/sithglan/work/linux-2.6 modules && mv -f hypervisor.ko hypervisor.o

### I press ctrl-c here ####

make[16]: *** [/usr/lib/parallels/drivers/hypervisor/hypmain.o] Interrupt
make[15]: *** [_module_/usr/lib/parallels/drivers/hypervisor] Interrupt
make[14]: *** [/usr/lib/parallels/drivers/hypervisor/hypmain.o] Interrupt
make[13]: *** [_module_/usr/lib/parallels/drivers/hypervisor] Interrupt
make[12]: *** [/usr/lib/parallels/drivers/hypervisor/hypmain.o] Interrupt
make[11]: *** [_module_/usr/lib/parallels/drivers/hypervisor] Interrupt
make[10]: *** [/usr/lib/parallels/drivers/hypervisor/hypmain.o] Interrupt
make[9]: *** [_module_/usr/lib/parallels/drivers/hypervisor] Interrupt
make[8]: *** [/usr/lib/parallels/drivers/hypervisor/hypmain.o] Interrupt
make[7]: *** [_module_/usr/lib/parallels/drivers/hypervisor] Interrupt
make[6]: *** [/usr/lib/parallels/drivers/hypervisor/hypmain.o] Interrupt
make[5]: *** [_module_/usr/lib/parallels/drivers/hypervisor] Interrupt
make[4]: *** [/usr/lib/parallels/drivers/hypervisor/hypmain.o] Interrupt
make[3]: *** [_module_/usr/lib/parallels/drivers/hypervisor] Interrupt
make[2]: *** [hypervisor] Interrupt
make[1]: *** [all-recursive] Interrupt
make: *** [all-recursive] Interrupt

and it works when I have the patch (http://thomas.glanzmann.de/parallels/patch) applied:

(mini) [/usr/lib/parallels] make
Making all in drivers
make[1]: Entering directory `/usr/lib/parallels/drivers'
Making all in .
make[2]: Entering directory `/usr/lib/parallels/drivers'
=> Patching modules makefiles for 2.6.x kernel ...
for i in hypervisor/Makefile drv_main/Makefile drv_net/linux/Makefile drv_virtualnic/Makefile; do \
                sed s/CFLAGS\ =/CFLAGS\ :=\ \$\(CFLAGS\)/ $i | \
                sed s/obj_m/obj-m/ | \
                sed s/hypervisor_objs/hypervisor-objs/ | \
                sed s/vm_main_objs/vm-main-objs/ | \
                sed s/vm_bridge_objs/vm-bridge-objs/ | \
                sed s/vmvirtualnic_objs/vmvirtualnic-objs/ | \
                sed s/_extra_ldflags\ =/EXTRA_LDFLAGS+=/ | \
                sed s/_extra_cflags\ =/EXTRA_CFLAGS+=/ | \
                sed s/include\ .\\/\$\(DEPDIR\)/#/ > $i.t; mv -f $i.t $i;\
        done
cp -f drv_main/common/md5.c hypervisor/;
cp -f drv_main/common/utils.c hypervisor/;
make[2]: Leaving directory `/usr/lib/parallels/drivers'
Making all in hypervisor
make[2]: Entering directory `/usr/lib/parallels/drivers/hypervisor'
make -C /lib/modules/2.6.17-rc5/build SUBDIRS=/usr/lib/parallels/drivers/hypervisor SRCROOT=/usr/lib/parallels/drivers/hypervisor modules && mv -f hypervisor.ko hypervisor.o
make[3]: Entering directory `/home/sithglan/work/linux-2.6'
  CC [M]  /usr/lib/parallels/drivers/hypervisor/logging.o
  CC [M]  /usr/lib/parallels/drivers/hypervisor/pages.o
  CC [M]  /usr/lib/parallels/drivers/hypervisor/utils.o
  CC [M]  /usr/lib/parallels/drivers/hypervisor/md5.o
  LD [M]  /usr/lib/parallels/drivers/hypervisor/hypervisor.o
  Building modules, stage 2.
  MODPOST
  LD [M]  /usr/lib/parallels/drivers/hypervisor/hypervisor.ko
make[3]: Leaving directory `/home/sithglan/work/linux-2.6'
make[2]: Leaving directory `/usr/lib/parallels/drivers/hypervisor'
Making all in drv_main
make[2]: Entering directory `/usr/lib/parallels/drivers/drv_main'
mkdir -p .deps/mm .deps/common
for i in vmmain.o vmproc.o device.o dwrap.o intgate.o ioctls.o monexport.o mm/manager.o mm/pages.o mm/collector.o mm/monmem.o mm/wset.o common/bma.o common/logging.o common/timer.o common/idata.o common/utils.o common/md5.o; do \
        if test -e `basename $i`; then \
        cp -f `basename $i` mm/`basename $i` > /dev/null 2>&1; \
        cp -f `basename $i` common/`basename $i` > /dev/null 2>&1; \
        fi; done
make -C /lib/modules/2.6.17-rc5/build SUBDIRS=/usr/lib/parallels/drivers/drv_main SRCROOT=/usr/lib/parallels/drivers/drv_main modules && mv -f vm-main.ko vm-main.o
make[3]: Entering directory `/home/sithglan/work/linux-2.6'
  Building modules, stage 2.
  MODPOST
WARNING: "hypervisorPresentInSystem" [/usr/lib/parallels/drivers/drv_main/vm-main.ko] undefined!
WARNING: "appDecCounter" [/usr/lib/parallels/drivers/drv_main/vm-main.ko] undefined!
WARNING: "appIncCounter" [/usr/lib/parallels/drivers/drv_main/vm-main.ko] undefined!
  LD [M]  /usr/lib/parallels/drivers/drv_main/vm-main.ko
make[3]: Leaving directory `/home/sithglan/work/linux-2.6'
make[2]: Leaving directory `/usr/lib/parallels/drivers/drv_main'
Making all in drv_net
make[2]: Entering directory `/usr/lib/parallels/drivers/drv_net'
Making all in linux
make[3]: Entering directory `/usr/lib/parallels/drivers/drv_net/linux'
make -C /lib/modules/2.6.17-rc5/build SUBDIRS=/usr/lib/parallels/drivers/drv_net/linux modules && mv -f vm-bridge.ko vm-bridge.o
make[4]: Entering directory `/home/sithglan/work/linux-2.6'
  Building modules, stage 2.
  MODPOST
WARNING: /usr/lib/parallels/drivers/drv_net/linux/vm-bridge.o - Section mismatch: reference to .init.text:init_module from .gnu.linkonce.this_module after '__this_module' (at offset 0xcc)
WARNING: /usr/lib/parallels/drivers/drv_net/linux/vm-bridge.o - Section mismatch: reference to .exit.text:cleanup_module from .gnu.linkonce.this_module after '__this_module' (at offset 0x30c)
  LD [M]  /usr/lib/parallels/drivers/drv_net/linux/vm-bridge.ko
make[4]: Leaving directory `/home/sithglan/work/linux-2.6'
make[3]: Leaving directory `/usr/lib/parallels/drivers/drv_net/linux'
make[3]: Entering directory `/usr/lib/parallels/drivers/drv_net'
make[3]: Nothing to be done for `all-am'.
make[3]: Leaving directory `/usr/lib/parallels/drivers/drv_net'
make[2]: Leaving directory `/usr/lib/parallels/drivers/drv_net'
Making all in drv_virtualnic
make[2]: Entering directory `/usr/lib/parallels/drivers/drv_virtualnic'
make -C /lib/modules/2.6.17-rc5/build SUBDIRS=/usr/lib/parallels/drivers/drv_virtualnic modules && mv -f vmvirtualnic.ko vmvirtualnic.o
make[3]: Entering directory `/home/sithglan/work/linux-2.6'
  Building modules, stage 2.
  MODPOST
WARNING: /usr/lib/parallels/drivers/drv_virtualnic/vmvirtualnic.o - Section mismatch: reference to .init.text:init_module from .gnu.linkonce.this_module after '__this_module' (at offset 0xcc)
WARNING: /usr/lib/parallels/drivers/drv_virtualnic/vmvirtualnic.o - Section mismatch: reference to .exit.text:cleanup_module from .gnu.linkonce.this_module after '__this_module' (at offset 0x30c)
  LD [M]  /usr/lib/parallels/drivers/drv_virtualnic/vmvirtualnic.ko
make[3]: Leaving directory `/home/sithglan/work/linux-2.6'
make[2]: Leaving directory `/usr/lib/parallels/drivers/drv_virtualnic'
make[1]: Leaving directory `/usr/lib/parallels/drivers'
make[1]: Entering directory `/usr/lib/parallels'
make[1]: Nothing to be done for `all-am'.
make[1]: Leaving directory `/usr/lib/parallels'

        Thomas

--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=Makefile

# Makefile.in generated by automake 1.6.3 from Makefile.am.
# drivers/hypervisor/Makefile.  Generated from Makefile.in by configure.

# Copyright 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002
# Free Software Foundation, Inc.
# This Makefile.in is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY, to the extent permitted by law; without
# even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE.



############################################################# 
# Copyright (C) 2004 Parallels Inc. All Rights Reserved.
#############################################################
SHELL = /bin/sh

srcdir = .
top_srcdir = ../..

prefix = /usr/local
exec_prefix = ${prefix}

bindir = ${exec_prefix}/bin
sbindir = ${exec_prefix}/sbin
libexecdir = ${exec_prefix}/libexec
datadir = ${prefix}/share
sysconfdir = ${prefix}/etc
sharedstatedir = ${prefix}/com
localstatedir = ${prefix}/var
libdir = ${exec_prefix}/lib
infodir = ${prefix}/info
mandir = ${prefix}/man
includedir = ${prefix}/include
oldincludedir = /usr/include
pkgdatadir = $(datadir)/pvs
pkglibdir = $(libdir)/pvs
pkgincludedir = $(includedir)/pvs
top_builddir = ../..

ACLOCAL = ${SHELL} /usr/lib/parallels/missing --run aclocal-1.6
AUTOCONF = ${SHELL} /usr/lib/parallels/missing --run autoconf
AUTOMAKE = ${SHELL} /usr/lib/parallels/missing --run automake-1.6
AUTOHEADER = ${SHELL} /usr/lib/parallels/missing --run autoheader

am__cd = CDPATH="$${ZSH_VERSION+.}$(PATH_SEPARATOR)" && cd
INSTALL = /usr/bin/install -c
INSTALL_PROGRAM = ${INSTALL}
INSTALL_DATA = ${INSTALL} -m 644
install_sh_DATA = $(install_sh) -c -m 644
install_sh_PROGRAM = $(install_sh) -c
install_sh_SCRIPT = $(install_sh) -c
INSTALL_SCRIPT = ${INSTALL}
INSTALL_HEADER = $(INSTALL_DATA)
transform = s,x,x,
NORMAL_INSTALL = :
PRE_INSTALL = :
POST_INSTALL = :
NORMAL_UNINSTALL = :
PRE_UNINSTALL = :
POST_UNINSTALL = :
host_alias = i686-pc-linux
host_triplet = i686-pc-linux

EXEEXT = 
OBJEXT = o
PATH_SEPARATOR = :
AMTAR = ${SHELL} /usr/lib/parallels/missing --run tar
ARCH_F = -march=pentium2
AS = @AS@
AWK = mawk
CC = gcc
CC_WARN = 
CXX = g++
DEPDIR = .deps
DLLTOOL = @DLLTOOL@
ECHO = echo
INSTALL_STRIP_PROGRAM = ${SHELL} $(install_sh) -c -s
KERNEL_VER = 26
LIBTOOL = $(SHELL) $(top_builddir)/libtool
LN_S = ln -s
MAINT = #
MAKE_CLEAN = clean-linux
MAKE_FILE = make
MAKE_TARGET = make-linux
MISCFLAGS := $(CFLAGS) 
MOD_EXT = ko
OBJDUMP = @OBJDUMP@
OS_BASEDIR = /lib/modules/2.6.17-rc5/build
OS_SRC = /lib/modules/2.6.17-rc5/build
PACKAGE = pvs
PREFX = f
RANLIB = ranlib
STRIP = strip
TARGET_OS = LINUX
VERSION = 2.1.0
am__include = include
am__quote = 
install_sh = /usr/lib/parallels/install-sh
topdir = /usr/lib/parallels

INCLUDES = -I$(top_srcdir)/Include -I. -I$(OS_SRC)/include \
	   -I$(topdir)/Private/Include/ -I/usr/src/linux -I$(topdir)/include \
	-I$(topdir)/drivers/hypervisor/ \
	-I$(topdir)/drivers/drv_main/ \
	-I$(topdir)/drivers/drv_main/common/ \
	-I$(topdir)/drivers/drv_main/compat/ \
	-I$(topdir)/drivers/drv_main/mm/


COMPILE = $(CC) $(INCLUDES) $(AM_CFLAGS)

bin_PROGRAMS = hypervisor
SRCROOT = .

OBJECTS = hypmain.o \
	hdevice.o \
	hioctls.o \
	hypvmstate.o \
	interrupt.o \
	hypercall.o \
	hypcalls.o \
	decode.o \
	posidt.o \
	hypidtemul.o \
	logging.o \
	pages.o \
	utils.o \
	md5.o \
	vtx_init.o \
	HyperSwitch.obj


AM_CFLAGS := $(CFLAGS) -D__KERNEL__ -DMODULE -D_FILE_OFFSET_BITS=64 -fno-exceptions \
	-fno-strength-reduce -pipe $(ARCH_F) \
	-$(PREFX)align-loops=2 -$(PREFX)align-jumps=2 -$(PREFX)align-functions=2 \
	-fno-exceptions -DCPU=686 -D_LINUX_ $(ABNORMAL_REMAP) $(CFLAGS) \
	-D_HYPERVISOR_


AM_LDFLAGS = 


# 26 kernel
EXTRA_LDFLAGS+= $(AM_LDFLAGS)
EXTRA_CFLAGS+= $(ABNORMAL_REMAP) $(INCLUDES) -I$(topdir)/Include -I$(topdir)/Private/Include \
	-I$(SRCROOT)/ $(AM_CFLAGS)


hypervisor-objs := $(OBJECTS)
obj-m := hypervisor.o

cmd = $(MAKE) -C $(OS_BASEDIR) SUBDIRS=$(shell pwd) SRCROOT=$(shell pwd) modules && \
	mv -f hypervisor.ko hypervisor.o

#cmd = $(LD) $(AM_LDFLAGS) $(OBJECTS) -r -s -o hypervisor.o

# 24 kernel
NEED_OBJECTS = 
#NEED_OBJECTS = $(OBJECTS)

subclean = `rm -f hdevice.o hypmain.o hypvmstate.o pages.o logging.o md5.o utils.o hypervisor.o`
#subclean = `find . -type f -iname *.O | xargs rm -f`
subdir = drivers/hypervisor
mkinstalldirs = $(SHELL) $(top_srcdir)/mkinstalldirs
CONFIG_CLEAN_FILES =
bin_PROGRAMS = hypervisor$(EXEEXT)
PROGRAMS = $(bin_PROGRAMS)

hypervisor_SOURCES = hypervisor.c
hypervisor_OBJECTS = hypervisor.$(OBJEXT)
hypervisor_LDADD = $(LDADD)
hypervisor_DEPENDENCIES =
hypervisor_LDFLAGS =

DEFS = -DPACKAGE_NAME=\"\" -DPACKAGE_TARNAME=\"\" -DPACKAGE_VERSION=\"\" -DPACKAGE_STRING=\"\" -DPACKAGE_BUGREPORT=\"\" -DPACKAGE=\"pvs\" -DVERSION=\"2.1.0\" -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 
DEFAULT_INCLUDES =  -I. -I$(srcdir)
CPPFLAGS = 
LDFLAGS = 
LIBS = 
depcomp = $(SHELL) $(top_srcdir)/depcomp
am__depfiles_maybe = depfiles
DEP_FILES = ./$(DEPDIR)/hypervisor.Po
LTCOMPILE = $(LIBTOOL) --mode=compile $(CC) $(DEFS) $(DEFAULT_INCLUDES) \
	$(INCLUDES) $(AM_CPPFLAGS) $(CPPFLAGS) $(AM_CFLAGS) $(CFLAGS)
CCLD = $(CC)
LINK = $(LIBTOOL) --mode=link $(CCLD) $(AM_CFLAGS) $(CFLAGS) \
	$(AM_LDFLAGS) $(LDFLAGS) -o $@
CFLAGS := $(CFLAGS) -Wall -pipe -D_FILE_OFFSET_BITS=64 -D_LINUX_  -DSLEEP_AVG  -DCR4_FEATURES_ADDR=0x7858e670 -O2 -DENABLE_MODULES_PROTECT
DIST_SOURCES = hypervisor.c
DIST_COMMON = Makefile.am Makefile.in
SOURCES = hypervisor.c

all: all-am

.SUFFIXES:
.SUFFIXES: .S .c .lo .o .obj
$(srcdir)/Makefile.in: # Makefile.am  $(top_srcdir)/configure.in $(ACLOCAL_M4)
	cd $(top_srcdir) && \
	  $(AUTOMAKE) --gnu  drivers/hypervisor/Makefile
Makefile: # $(srcdir)/Makefile.in  $(top_builddir)/config.status
	cd $(top_builddir) && $(SHELL) ./config.status $(subdir)/$@ $(am__depfiles_maybe)
binPROGRAMS_INSTALL = $(INSTALL_PROGRAM)
install-binPROGRAMS: $(bin_PROGRAMS)
	@$(NORMAL_INSTALL)
	$(mkinstalldirs) $(DESTDIR)$(bindir)
	@list='$(bin_PROGRAMS)'; for p in $$list; do \
	  p1=`echo $$p|sed 's/$(EXEEXT)$$//'`; \
	  if test -f $$p \
	     || test -f $$p1 \
	  ; then \
	    f=`echo "$$p1" | sed 's,^.*/,,;$(transform);s/$$/$(EXEEXT)/'`; \
	   echo " $(INSTALL_PROGRAM_ENV) $(LIBTOOL) --mode=install $(binPROGRAMS_INSTALL) $$p $(DESTDIR)$(bindir)/$$f"; \
	   $(INSTALL_PROGRAM_ENV) $(LIBTOOL) --mode=install $(binPROGRAMS_INSTALL) $$p $(DESTDIR)$(bindir)/$$f; \
	  else :; fi; \
	done

uninstall-binPROGRAMS:
	@$(NORMAL_UNINSTALL)
	@list='$(bin_PROGRAMS)'; for p in $$list; do \
	  f=`echo "$$p" | sed 's,^.*/,,;s/$(EXEEXT)$$//;$(transform);s/$$/$(EXEEXT)/'`; \
	  echo " rm -f $(DESTDIR)$(bindir)/$$f"; \
	  rm -f $(DESTDIR)$(bindir)/$$f; \
	done

clean-binPROGRAMS:
	@list='$(bin_PROGRAMS)'; for p in $$list; do \
	  f=`echo $$p|sed 's/$(EXEEXT)$$//'`; \
	  echo " rm -f $$p $$f"; \
	  rm -f $$p $$f ; \
	done

mostlyclean-compile:
	# -rm -f *.$(OBJEXT) core *.core

distclean-compile:
	-rm -f *.tab.c

#/hypervisor.Po

distclean-depend:
	-rm -rf ./$(DEPDIR)

.c.o:
	source='$<' object='$@' libtool=no \
	depfile='$(DEPDIR)/$*.Po' tmpdepfile='$(DEPDIR)/$*.TPo' \
	$(CCDEPMODE) $(depcomp) \
	$(COMPILE) -c `test -f '$<' || echo '$(srcdir)/'`$<

.c.obj:
	source='$<' object='$@' libtool=no \
	depfile='$(DEPDIR)/$*.Po' tmpdepfile='$(DEPDIR)/$*.TPo' \
	$(CCDEPMODE) $(depcomp) \
	$(COMPILE) -c `cygpath -w $<`

.c.lo:
	source='$<' object='$@' libtool=yes \
	depfile='$(DEPDIR)/$*.Plo' tmpdepfile='$(DEPDIR)/$*.TPlo' \
	$(CCDEPMODE) $(depcomp) \
	$(LTCOMPILE) -c -o $@ `test -f '$<' || echo '$(srcdir)/'`$<
CCDEPMODE = depmode=gcc3

mostlyclean-libtool:
	-rm -f *.lo

clean-libtool:
	-rm -rf .libs _libs

distclean-libtool:
	-rm -f libtool
uninstall-info-am:

ETAGS = etags
ETAGSFLAGS =

tags: TAGS

ID: $(HEADERS) $(SOURCES) $(LISP) $(TAGS_FILES)
	list='$(SOURCES) $(HEADERS) $(LISP) $(TAGS_FILES)'; \
	unique=`for i in $$list; do \
	    if test -f "$$i"; then echo $$i; else echo $(srcdir)/$$i; fi; \
	  done | \
	  $(AWK) '    { files[$$0] = 1; } \
	       END { for (i in files) print i; }'`; \
	mkid -fID $$unique

TAGS:  $(HEADERS) $(SOURCES)  $(TAGS_DEPENDENCIES) \
		$(TAGS_FILES) $(LISP)
	tags=; \
	here=`pwd`; \
	list='$(SOURCES) $(HEADERS)  $(LISP) $(TAGS_FILES)'; \
	unique=`for i in $$list; do \
	    if test -f "$$i"; then echo $$i; else echo $(srcdir)/$$i; fi; \
	  done | \
	  $(AWK) '    { files[$$0] = 1; } \
	       END { for (i in files) print i; }'`; \
	test -z "$(ETAGS_ARGS)$$tags$$unique" \
	  || $(ETAGS) $(ETAGSFLAGS) $(AM_ETAGSFLAGS) $(ETAGS_ARGS) \
	     $$tags $$unique

GTAGS:
	here=`$(am__cd) $(top_builddir) && pwd` \
	  && cd $(top_srcdir) \
	  && gtags -i $(GTAGS_ARGS) $$here

distclean-tags:
	-rm -f TAGS ID GTAGS GRTAGS GSYMS GPATH
DISTFILES = $(DIST_COMMON) $(DIST_SOURCES) $(TEXINFOS) $(EXTRA_DIST)

top_distdir = ../..
distdir = $(top_distdir)/$(PACKAGE)-$(VERSION)

distdir: $(DISTFILES)
	@list='$(DISTFILES)'; for file in $$list; do \
	  if test -f $$file || test -d $$file; then d=.; else d=$(srcdir); fi; \
	  dir=`echo "$$file" | sed -e 's,/[^/]*$$,,'`; \
	  if test "$$dir" != "$$file" && test "$$dir" != "."; then \
	    dir="/$$dir"; \
	    $(mkinstalldirs) "$(distdir)$$dir"; \
	  else \
	    dir=''; \
	  fi; \
	  if test -d $$d/$$file; then \
	    if test -d $(srcdir)/$$file && test $$d != $(srcdir); then \
	      cp -pR $(srcdir)/$$file $(distdir)$$dir || exit 1; \
	    fi; \
	    cp -pR $$d/$$file $(distdir)$$dir || exit 1; \
	  else \
	    test -f $(distdir)/$$file \
	    || cp -p $$d/$$file $(distdir)/$$file \
	    || exit 1; \
	  fi; \
	done
check-am: all-am
check: check-am
all-am: Makefile $(PROGRAMS)

installdirs:
	$(mkinstalldirs) $(DESTDIR)$(bindir)

install: install-am
install-exec: install-exec-am
install-data: install-data-am
uninstall: uninstall-am

install-am: all-am
	@$(MAKE) $(AM_MAKEFLAGS) install-exec-am install-data-am

installcheck: installcheck-am
install-strip:
	$(MAKE) $(AM_MAKEFLAGS) INSTALL_PROGRAM="$(INSTALL_STRIP_PROGRAM)" \
	  INSTALL_STRIP_FLAG=-s \
	  `test -z '$(STRIP)' || \
	    echo "INSTALL_PROGRAM_ENV=STRIPPROG='$(STRIP)'"` install
mostlyclean-generic:

clean-generic:

distclean-generic:
	-rm -f Makefile $(CONFIG_CLEAN_FILES)

maintainer-clean-generic:
	@echo "This command is intended for maintainers to use"
	@echo "it deletes files that may require special tools to rebuild."
clean: clean-am

clean-am: clean-binPROGRAMS clean-generic clean-libtool mostlyclean-am

distclean: distclean-am

distclean-am: clean-am distclean-compile distclean-depend \
	distclean-generic distclean-libtool distclean-tags

dvi: dvi-am

dvi-am:

info: info-am

info-am:

install-data-am:

install-exec-am: install-binPROGRAMS

install-info: install-info-am

install-man:

installcheck-am:

maintainer-clean: maintainer-clean-am

maintainer-clean-am: distclean-am maintainer-clean-generic

mostlyclean: mostlyclean-am

mostlyclean-am: mostlyclean-compile mostlyclean-generic \
	mostlyclean-libtool

uninstall-am: uninstall-binPROGRAMS uninstall-info-am

.PHONY: GTAGS all all-am check check-am clean clean-binPROGRAMS \
	clean-generic clean-libtool distclean distclean-compile \
	distclean-depend distclean-generic distclean-libtool \
	distclean-tags distdir dvi dvi-am info info-am install \
	install-am install-binPROGRAMS install-data install-data-am \
	install-exec install-exec-am install-info install-info-am \
	install-man install-strip installcheck installcheck-am \
	installdirs maintainer-clean maintainer-clean-generic \
	mostlyclean mostlyclean-compile mostlyclean-generic \
	mostlyclean-libtool tags uninstall uninstall-am \
	uninstall-binPROGRAMS uninstall-info-am


#.S.o:
#	if $(COMPILE) -MT $@ -MD -MP -MF "$(DEPDIR)/$*.Tpo" -c -o $@ $<; \
#	then mv -f "$(DEPDIR)/$*.Tpo" "$(DEPDIR)/$*.Po"; else rm -f "$(DEPDIR)/$*.Tpo"; exit 1; fi

# real target
hypervisor: $(NEED_OBJECTS)
	$(cmd)

clean:
	$(subclean);\
	find . -type f -iname *.mod\.\* | xargs rm -f; \
	find . -type f -iname *.cmd\.\* | xargs rm -f; \
	find . -type f -iname *.cmd | xargs rm -f; \
	find . -type f -iname *.ko | xargs rm -f; \
	rm -rf .tmp_versions
# Tell versions [3.59,3.63) of GNU make to not export all variables.
# Otherwise a system limit (for SysV at least) may be exceeded.
.NOEXPORT:

--yrj/dFKFPuw6o+aM--
