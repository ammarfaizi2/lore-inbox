Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129465AbQKNC2z>; Mon, 13 Nov 2000 21:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130107AbQKNC2p>; Mon, 13 Nov 2000 21:28:45 -0500
Received: from host55.osagesoftware.com ([209.142.225.55]:59914 "EHLO
	netmax.osagesoftware.com") by vger.kernel.org with ESMTP
	id <S129465AbQKNC2e>; Mon, 13 Nov 2000 21:28:34 -0500
Message-Id: <4.3.2.7.2.20001113205514.00af7d20@mail.osagesoftware.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Mon, 13 Nov 2000 20:58:05 -0500
To: "Corisen" <csyap@starnet.gov.sg>
From: David Relson <relson@osagesoftware.com>
Subject: Re: anyone compiled 2.2.17 on RH7 successfully?
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <005a01c04ddc$6dc14360$050010ac@starnet.gov.sg>
In-Reply-To: <200011140118.eAE1IuV17166@moisil.dev.hydraweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corisen,

RedHat 7.0's version of gcc, known as gcc 2.96, is incompatible with the 
kernel's code.  Preprocessor changes cause the problem you encountered.  It 
also has some defects in how it optimizes code that would cause the kernel 
to run incorrectly.

The 7.0 distribution includes an older version of gcc, known as kgcc (for 
kernel gcc), that compiles code correctly and can be used for kernel 
compilation.  Install the rpm and go for it!

David

At 08:44 PM 11/13/00, Corisen wrote:
>has anyone running RedHat7(with kernel 2.2.16, gcc 2.96, kgcc 2.91.66)
>complied 2.2.17 kernel successfully?
>
>i've downloaded the source and gunzip/untar to /root/linux-2.2.17
>
>1. make menuconfig (ok)
>2. make dep (ok)
>3. make zImage
>===> lots of warning message
>===> error: checksum.S:231 badly punctuated parameter list in #define
>===> error: checksum.S:237 badly punctuated parameter list in #define
>
>4. make CC=kgcc zImage
>===> snapshot of errors reported:
>In file included from init/main.c:15:
>/usr/i386-glibc21-linux/include/linux/proc_fs.h:283: parse error before
>`mode_t'
>/usr/i386-glibc21-linux/include/linux/proc_fs.h:283: warning: no semicolon
>at end of struct or union
>/usr/i386-glibc21-linux/include/linux/proc_fs.h:284: warning: data
>definition has no type or storage class
>/usr/i386-glibc21-linux/include/linux/proc_fs.h:285: parse error before
>`uid'
>/usr/i386-glibc21-linux/include/linux/proc_fs.h:285: warning: data
>definition has no type or storage class
>/usr/i386-glibc21-linux/include/linux/proc_fs.h:286: parse error before
>`gid'
>/usr/i386-glibc21-linux/include/linux/proc_fs.h:286: warning: data
>definition has no type or storage class
>....many more errors
>....many more errors
>....
>
>5. changed CC= kgcc in Makefile and execute "make zImage"
>===> same error as 3 (strange, seems like the the compilation is still by
>gcc and not kgcc despite the change)
>
>i was able to compile 2.4.0-test10 kernel image with "make CC=kgcc bzImage"
>
>pls kindly advise on the possible solutions.
>
>thanks.
>
>
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>Please read the FAQ at http://www.tux.org/lkml/

--------------------------------------------------------
David Relson                   Osage Software Systems, Inc.
relson@osagesoftware.com       514 W. Keech Ave.
www.osagesoftware.com          Ann Arbor, MI 48103
voice: 734.821.8800            fax: 734.821.8800

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
