Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293035AbSDKWWb>; Thu, 11 Apr 2002 18:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293135AbSDKWWa>; Thu, 11 Apr 2002 18:22:30 -0400
Received: from mail.cs.utexas.edu ([128.83.139.10]:34959 "EHLO
	mail.cs.utexas.edu") by vger.kernel.org with ESMTP
	id <S293035AbSDKWW3>; Thu, 11 Apr 2002 18:22:29 -0400
Date: Thu, 11 Apr 2002 17:22:23 -0500 (CDT)
From: Chin-Tser Huang <chuang@cs.utexas.edu>
To: <linux-kernel@vger.kernel.org>
Subject: question about compiling 2.4.9 using ARCH=um
Message-ID: <Pine.GSO.4.33.0204111714530.16722-100000@fugue.cs.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am a kernel newbie and I am trying to compile the 2.4.9 kernel
to user mode. The files I use are linux-2.4.9.tar and uml-patch-2.4.9.bz2.
However, when I executed "make linux ARCH=um", I got the following
error messages:
--
...
nm vmlinux | grep -v '\(compiled\)\|\(\.o$\)\|\( [aUw]
\)\|\(\.\.ng$\)\|\(LASH[RL]DI\)' | sort > System.map
mv vmlinux vmlinux.o
gcc -Wl,-T,/usr/src/uml/linux/arch/um/link.ld  -o linux -static \
        /usr/src/uml/linux/arch/um/main.o vmlinux.o -L/usr/lib
vmlinux.o: In function `rwsem_wake':
/usr/src/uml/linux/lib/rwsem.c:203: undefined reference to `_etext'
vmlinux.o: In function `linux_main':
/usr/src/uml/linux/arch/um/kernel/um_arch.c:201: undefined reference to
`_etext'
/usr/src/uml/linux/arch/um/kernel/um_arch.c:202: undefined reference to
`_edata'
/usr/src/uml/linux/arch/um/kernel/um_arch.c:202: undefined reference to
`_sdata'
/usr/src/uml/linux/arch/um/kernel/um_arch.c:204: undefined reference to
`__bss_start'
vmlinux.o: In function `unlock_pid':
/usr/src/uml/linux/arch/um/kernel/um_arch.c:326: undefined reference to
`switcheroo'
vmlinux.o: In function `do_exitcalls':
/usr/src/uml/linux/arch/um/kernel/process_kern.c:785: undefined reference
to `__exitcall_end'
/usr/src/uml/linux/arch/um/kernel/process_kern.c:785: undefined reference
to `__exitcall_begin'
/usr/src/uml/linux/arch/um/kernel/process_kern.c:786: undefined reference
to `__exitcall_begin'
vmlinux.o: In function `show_trace':
/usr/src/uml/linux/arch/um/kernel/process_kern.c:827: undefined reference
to `_etext'
vmlinux.o: In function `parse_options':
/usr/src/uml/linux/include/asm/arch/string.h:165: undefined reference to
`__start___ksymtab'
vmlinux.o: In function `process_timeout':
/usr/src/uml/linux/kernel/sched.c:359: undefined reference to
`__start___ex_table'
/usr/src/uml/linux/kernel/sched.c:359: undefined reference to
`__stop___ex_table'
/usr/bin/ld: final link failed: Bad value
collect2: ld returned 1 exit status
make: *** [linux] Error 1
--

Can anybody help me solve the problem and compile it? Thanks
a lot!!

Chin-Tser

