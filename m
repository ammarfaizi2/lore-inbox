Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266195AbUJBODF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266195AbUJBODF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 10:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266204AbUJBODF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 10:03:05 -0400
Received: from mailgate.pit.comms.marconi.com ([169.144.68.6]:5876 "EHLO
	mailgate.pit.comms.marconi.com") by vger.kernel.org with ESMTP
	id S266195AbUJBOCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 10:02:51 -0400
Message-ID: <313680C9A886D511A06000204840E1CF0A6471FF@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: lmbench results (with and without "kernel preemption") for Linux 
	2.6.8-rc4 on MPC 8275 (PQ2FADS-VR) ?
Date: Sat, 2 Oct 2004 10:02:39 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> 
> Here are my lmbench results (with and without "kernel preemption") for
> Linux 2.6.8-rc4 on MPC 8275 (PQ2FADS-VR).
> Are results making any sense in your respected opinion ?
Is running lmbench once for each case (with and without "kernel preemption")
enough for making any reasonable 
> conclusions (if not - how many times do you recommend to run it ? )
> 
> Thanks,
> Alex Povolotsky
PS Configuration details are listed below the test results
> ***************
> 
> /* kernel preemption is "off" */
> # ./lat_fs 
> 0k      2       352     534
> 1k      2       311     657
> 4k      2       275     645
> 10k     2       192     635
> 
> /* kernel preemption is "on" */
> # ./lat_fs
> 0k      33      6171    12039
> 1k      15      2701    4557
> 4k      12      2326    4585
> 10k     9       1534    3693
> *************************************
> /* kernel preemption is "off" */
> # ./lat_pipe 
> Pipe latency: 29.3697 microseconds
> 
> /* kernel preemption is "on" */
> # ./lat_pipe
> Pipe latency: 35.3225 microseconds
> *************************************
> /* kernel preemption is "off" */
> # ./lat_fifo 
> Fifo latency: 29.9354 microseconds
> 
> /* kernel preemption is "on" */
> # ./lat_fifo
> Fifo latency: 33.4318 microseconds
> *************************************
> /* kernel preemption is "off" */
> # ./lat_syscall read
> Simple read: 1.9111 microseconds
> # ./lat_syscall write
> Simple write: 2.3664 microseconds
> # ./lat_syscall stat ../../ACKNOWLEDGEMENTS
> Simple stat: 28.1538 microseconds
> # ./lat_syscall fstat ../../ACKNOWLEDGEMENTS
> Simple fstat: 4.0989 microseconds
> # ./lat_syscall open  ../../ACKNOWLEDGEMENTS
> Simple open/close: 673.8750 microseconds
> 
> /* kernel preemption is "on" */
> # ./lat_syscall read
> Simple read: 2.1007 microseconds
> # ./lat_syscall write
> Simple write: 1.6922 microseconds
> # ./lat_syscall stat ../../ACKNOWLEDGEMENTS
> Simple stat: 24.8492 microseconds
> # ./lat_syscall fstat ../../ACKNOWLEDGEMENTS
> Simple fstat: 5.0310 microseconds
> # ./lat_syscall open  ../../ACKNOWLEDGEMENTS
> Simple open/close: 716.4286 microseconds
> *******************************************
> /* kernel preemption is "off" */
> # ./lat_proc fork
> Process fork+exit: 2281.0000 microseconds
> # ./lat_proc exec
> Process fork+execve: 13794.0000 microseconds
> # ./lat_proc shell
> Process fork+/bin/sh -c: 26913.0000 microseconds
> 
> /* kernel preemption is "on" */
> # ./lat_proc fork
> Process fork+exit: 2349.3333 microseconds
> # ./lat_proc exec
> Process fork+execve: 2450.3333 microseconds
> # ./lat_proc shell
> Process fork+/bin/sh -c: 27038.0000 microseconds
> *****************************************8
> /* kernel preemption is "off" */
> # ./lat_sig install
> Signal handler installation: 4.0664 microseconds
> # ./lat_sig catch
> Signal handler overhead: 16.5183 microseconds
> 
> /* kernel preemption is "on" */
> # ./lat_sig install
> Signal handler installation: 4.1338 microseconds
> # ./lat_sig catch
> Signal handler overhead: 18.3801 microseconds
> *************************************
> /* kernel preemption is "off" */
> ./lat_pagefault ../../ACKNOWLEDGEMENTS
> Pagefaults on ../../ACKNOWLEDGEMENTS: 8.1880 microseconds
> 
> /* kernel preemption is "on" */
>  ./lat_pagefault ../../ACKNOWLEDGEMENTS
> Pagefaults on ../../ACKNOWLEDGEMENTS: 8.3943 microseconds
> ******************************************
> /* kernel preemption is "off" */
> # ./lat_ops
> integer bit: 30.45 nanoseconds
> integer add: 30.39 nanoseconds
> integer mul: 39.88 nanoseconds
> integer div: 121.70 nanoseconds
> integer mod: 153.55 nanoseconds
> int64 bit: 51.74 nanoseconds
> int64 add: 61.48 nanoseconds
> int64 mul: 118.17 nanoseconds
> int64 div: 912.71 nanoseconds
> int64 mod: 809.03 nanoseconds
> float add: 50.09 nanoseconds
> float mul: 50.17 nanoseconds
> float div: 130.98 nanoseconds
> double add: 50.10 nanoseconds
> double mul: 55.25 nanoseconds
> double div: 202.25 nanoseconds
> float bogomflops: 216.12 nanoseconds
> double bogomflops: 292.37 nanoseconds
> 
> /* kernel preemption is "on" */
> # ./lat_ops
> integer bit: 30.53 nanoseconds
> integer add: 30.40 nanoseconds
> integer mul: 39.92 nanoseconds
> integer div: 121.75 nanoseconds
> integer mod: 152.53 nanoseconds
> int64 bit: 52.20 nanoseconds
> int64 add: 61.07 nanoseconds
> int64 mul: 118.21 nanoseconds
> int64 div: 913.45 nanoseconds
> int64 mod: 802.58 nanoseconds
> float add: 50.14 nanoseconds
> float mul: 50.21 nanoseconds
> float div: 130.95 nanoseconds
> double add: 50.15 nanoseconds
> double mul: 55.29 nanoseconds
> double div: 202.18 nanoseconds
> float bogomflops: 216.32 nanoseconds
> double bogomflops: 292.68 nanoseconds
> ************************************
> /* kernel preemption is "off" */
> # ./bw_pipe
> Pipe bandwidth: 42.49 MB/sec
> 
> /* kernel preemption is "on" */
> # ./bw_pipe
> Pipe bandwidth: 42.00 MB/sec
*********************************************** 
Test environment info (I and II) :

I) both kernel (after applying the patch) and lmbench are compiled on
windows under cygwin.

Here is the list of all fixes I used to make it "cygwin compilable" :

1) per http://sources.redhat.com/ml/crossgcc/2004-06/msg00282.html
 
Install patch from bertrand marquis <bertrand_marquis at yahoo dot fr>
listed there
 
--- linux-x86-2.6.7/scripts/kconfig/Makefile 2004-06-16 07:20:26.000000000
+0200
+++ linux-x86-2.6.7.cyg/linux-x86-2.6.7/scripts/kconfig/Makefile 2004-06-24
10:39:18.824400000 +0200
@@ -68,8 +68,8 @@
libkconfig-objs := zconf.tab.o

host-progs    := conf mconf qconf gconf
-conf-objs    := conf.o  libkconfig.so
-mconf-objs    := mconf.o libkconfig.so
+conf-objs    := conf.o  libkconfig.o
+mconf-objs    := mconf.o zconf.tab.o
 

ifeq ($(MAKECMDGOALS),xconfig)
    qconf-target := 1
@@ -89,11 +89,12 @@
endif
 

clean-files    := libkconfig.so lkc_defs.h qconf.moc .tmp_qtcheck \
-           .tmp_gtkcheck zconf.tab.c zconf.tab.h lex.zconf.c
+           .tmp_gtkcheck zconf.tab.c zconf.tab.h lex.zconf.c libkconfig.o
 

# generated files seem to need this to find local include files
HOSTCFLAGS_lex.zconf.o    := -I$(src)
HOSTCFLAGS_zconf.tab.o    := -I$(src)
+HOSTCFLAGS_libkconfig.o    := -I$(src)

HOSTLOADLIBES_qconf = -L$(QTLIBPATH) -Wl,-rpath,$(QTLIBPATH) -l$(QTLIB) -ldl
HOSTCXXFLAGS_qconf.o = -I$(QTDIR)/include
@@ -101,6 +102,9 @@
HOSTLOADLIBES_gconf = `pkg-config gtk+-2.0 gmodule-2.0 libglade-2.0 --libs`
HOSTCFLAGS_gconf.o = `pkg-config gtk+-2.0 gmodule-2.0 libglade-2.0 --cflags`

+$(obj)/libkconfig.c: $(obj)/zconf.tab.c $(obj)/lex.zconf.c
+ cp $< $@
+
$(obj)/conf.o $(obj)/mconf.o $(obj)/qconf.o $(obj)/gconf.o:
$(obj)/zconf.tab.h

$(obj)/qconf.o: $(obj)/.tmp_qtcheck

2)download and install libelf package from: 

http://www.gnu.org/directory/libs/misc/libelf.html

which  provide <gelf.h>;

in /cygdrive/c/cygwin/usr/include you can then make an elf.h that just
contains

#include <gelf.h>

3)apply 2 patches from Martin Schaffner
 

http://mirror.vtx.ch/lfs/patches/downloads/linux/linux-2.6.7-build_on_case_i
nsensitive_fs-1.patch

http://mirror.vtx.ch/lfs/patches/downloads/linux/linux-2.6.7-build_on_osx-1.
patch


II) booting with RAMDISK from
<ftp://ftp.denx.de/pub/LinuxPPC/usr/src/SELF/images/
and then manually NFS mounting on /fadsroot (from Arabella)placed 
on Red Hat Linux NFS server PC running
[release 9 (Shrike)Kernel 2.4.20-28.9 on an i686]. 
Lmbench is placed within fadsroot and is executed from there.


