Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130499AbQKNEHt>; Mon, 13 Nov 2000 23:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130604AbQKNEHj>; Mon, 13 Nov 2000 23:07:39 -0500
Received: from c837140-a.vncvr1.wa.home.com ([65.0.81.146]:61956 "EHLO
	cyclonehq.dnsalias.net") by vger.kernel.org with ESMTP
	id <S130499AbQKNEHY>; Mon, 13 Nov 2000 23:07:24 -0500
Date: Mon, 13 Nov 2000 19:37:58 -0800 (PST)
From: Dan Browning <danb@cyclonehq.dnsalias.net>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
cc: Corisen <csyap@starnet.gov.sg>, linux-kernel@vger.kernel.org
Subject: Re: anyone compiled 2.2.17 on RH7 successfully?
In-Reply-To: <3A10B64A.257D8345@holly-springs.nc.us>
Message-ID: <Pine.LNX.4.21.0011131937310.17160-100000@cyclonehq.dnsalias.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did you make clean; make mrproper?

On Mon, 13 Nov 2000, Michael Rothwell wrote:

> GCCLOC=`which gcc`
> rm `echo $GCCLOC`
> ln -s `which kgcc` `echo $GCCLOC`
> 
> ... repeat for g++
> 
> 
> -M
> 
> 
> Corisen wrote:
> > 
> > thanks for the info. i've kgcc installed during RH7 installation. i've
> > checked the version to be 2.91.66. i've used the following 2 methods with
> > kgcc but it won't even allow me to compile:
> > 1. make CC=kgcc zImage
> > 2. change the CC=gcc to CC=kgcc in Makefile
> > 
> > the "make CC=kgcc zImage" process reports the following error messages:
> > 
> > In file included from init/main.c:15:
> > /usr/i386-glibc21-linux/include/linux/proc_fs.h:283: parse error before
> > `mode_t'
> > /usr/i386-glibc21-linux/include/linux/proc_fs.h:283: warning: no semicolon
> > at end of struct or union
> > /usr/i386-glibc21-linux/include/linux/proc_fs.h:284: warning: data
> > definition has no type or storage class
> > /usr/i386-glibc21-linux/include/linux/proc_fs.h:285: parse error before
> > `uid'
> > /usr/i386-glibc21-linux/include/linux/proc_fs.h:285: warning: data
> > definition has no type or storage class
> > /usr/i386-glibc21-linux/include/linux/proc_fs.h:286: parse error before
> > `gid'
> > /usr/i386-glibc21-linux/include/linux/proc_fs.h:286: warning: data
> > definition has no type or storage class
> > /usr/i386-glibc21-linux/include/linux/proc_fs.h:289: parse error before
> > `off_t'
> > /usr/i386-glibc21-linux/include/linux/proc_fs.h:290: warning: `struct inode'
> > declared inside parameter list
> > /usr/i386-glibc21-linux/include/linux/proc_fs.h:290: warning: its scope is
> > only this definition or declaration,
> > /usr/i386-glibc21-linux/include/linux/proc_fs.h:290: warning: which is
> > probably not what you want.
> > /usr/i386-glibc21-linux/include/linux/proc_fs.h:293: parse error before
> > `off_t'
> > /usr/i386-glibc21-linux/include/linux/proc_fs.h:296: warning: `struct file'
> > declared inside parameter list
> > /usr/i386-glibc21-linux/include/linux/proc_fs.h:300: parse error before `}'
> > /usr/i386-glibc21-linux/include/linux/proc_fs.h:302: parse error before
> > `off_t'
> > /usr/i386-glibc21-linux/include/linux/proc_fs.h:305: warning: `struct file'
> > declared inside parameter list
> > /usr/i386-glibc21-linux/include/linux/proc_fs.h:308: parse error before
> > `off_t'
> > /usr/i386-glibc21-linux/include/linux/proc_fs.h: In function
> > `proc_scsi_register':
> > /usr/i386-glibc21-linux/include/linux/proc_fs.h:344: dereferencing pointer
> > to incomplete type
> > /usr/i386-glibc21-linux/include/linux/proc_fs.h:345: dereferencing pointer
> > to incomplete type
> > /usr/i386-glibc21-linux/include/linux/proc_fs.h: In function
> > `proc_scsi_unregister':
> > /usr/i386-glibc21-linux/include/linux/proc_fs.h:359: dereferencing pointer
> > to incomplete type
> > /usr/i386-glibc21-linux/include/linux/proc_fs.h:362: `NULL' undeclared
> > (first use in this function)
> > /usr/i386-glibc21-linux/include/linux/proc_fs.h:362: (Each undeclared
> > identifier is reported only once
> > /usr/i386-glibc21-linux/include/linux/proc_fs.h:362: for each function it
> > appears in.)
> > /usr/i386-glibc21-linux/include/linux/proc_fs.h:363: dereferencing pointer
> > to incomplete type
> > /usr/i386-glibc21-linux/include/linux/proc_fs.h:365: dereferencing pointer
> > to incomplete type
> > /usr/i386-glibc21-linux/include/linux/proc_fs.h:368: sizeof applied to an
> > incomplete type
> > .....many more lines
> > .....many more lines
> > 
> > ----- Original Message -----
> > From: David Relson <relson@osagesoftware.com>
> > To: Corisen <csyap@starnet.gov.sg>
> > Cc: <linux-kernel@vger.kernel.org>
> > Sent: Tuesday, November 14, 2000 9:58 AM
> > Subject: Re: anyone compiled 2.2.17 on RH7 successfully?
> > 
> > > Corisen,
> > >
> > > RedHat 7.0's version of gcc, known as gcc 2.96, is incompatible with the
> > > kernel's code.  Preprocessor changes cause the problem you encountered.
> > It
> > > also has some defects in how it optimizes code that would cause the kernel
> > > to run incorrectly.
> > >
> > > The 7.0 distribution includes an older version of gcc, known as kgcc (for
> > > kernel gcc), that compiles code correctly and can be used for kernel
> > > compilation.  Install the rpm and go for it!
> > >
> > > David
> > >
> > > At 08:44 PM 11/13/00, Corisen wrote:
> > > >has anyone running RedHat7(with kernel 2.2.16, gcc 2.96, kgcc 2.91.66)
> > > >complied 2.2.17 kernel successfully?
> > > >
> > > >i've downloaded the source and gunzip/untar to /root/linux-2.2.17
> > > >
> > > >1. make menuconfig (ok)
> > > >2. make dep (ok)
> > > >3. make zImage
> > > >===> lots of warning message
> > > >===> error: checksum.S:231 badly punctuated parameter list in #define
> > > >===> error: checksum.S:237 badly punctuated parameter list in #define
> > > >
> > > >4. make CC=kgcc zImage
> > > >===> snapshot of errors reported:
> > > >In file included from init/main.c:15:
> > > >/usr/i386-glibc21-linux/include/linux/proc_fs.h:283: parse error before
> > > >`mode_t'
> > > >/usr/i386-glibc21-linux/include/linux/proc_fs.h:283: warning: no
> > semicolon
> > > >at end of struct or union
> > > >/usr/i386-glibc21-linux/include/linux/proc_fs.h:284: warning: data
> > > >definition has no type or storage class
> > > >/usr/i386-glibc21-linux/include/linux/proc_fs.h:285: parse error before
> > > >`uid'
> > > >/usr/i386-glibc21-linux/include/linux/proc_fs.h:285: warning: data
> > > >definition has no type or storage class
> > > >/usr/i386-glibc21-linux/include/linux/proc_fs.h:286: parse error before
> > > >`gid'
> > > >/usr/i386-glibc21-linux/include/linux/proc_fs.h:286: warning: data
> > > >definition has no type or storage class
> > > >....many more errors
> > > >....many more errors
> > > >....
> > > >
> > > >5. changed CC= kgcc in Makefile and execute "make zImage"
> > > >===> same error as 3 (strange, seems like the the compilation is still by
> > > >gcc and not kgcc despite the change)
> > > >
> > > >i was able to compile 2.4.0-test10 kernel image with "make CC=kgcc
> > bzImage"
> > > >
> > > >pls kindly advise on the possible solutions.
> > > >
> > > >thanks.
> > > >
> > > >
> > > >
> > > >
> > > >
> > > >-
> > > >To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > in
> > > >the body of a message to majordomo@vger.kernel.org
> > > >Please read the FAQ at http://www.tux.org/lkml/
> > >
> > > --------------------------------------------------------
> > > David Relson                   Osage Software Systems, Inc.
> > > relson@osagesoftware.com       514 W. Keech Ave.
> > > www.osagesoftware.com          Ann Arbor, MI 48103
> > > voice: 734.821.8800            fax: 734.821.8800
> > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > Please read the FAQ at http://www.tux.org/lkml/
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > Please read the FAQ at http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
