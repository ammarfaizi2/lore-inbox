Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129955AbQKNCPB>; Mon, 13 Nov 2000 21:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129765AbQKNCOv>; Mon, 13 Nov 2000 21:14:51 -0500
Received: from [203.116.59.241] ([203.116.59.241]:27398 "HELO
	aquarius.starnet.gov.sg") by vger.kernel.org with SMTP
	id <S129955AbQKNCOg>; Mon, 13 Nov 2000 21:14:36 -0500
Message-ID: <005a01c04ddc$6dc14360$050010ac@starnet.gov.sg>
From: "Corisen" <csyap@starnet.gov.sg>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <200011140118.eAE1IuV17166@moisil.dev.hydraweb.com>
Subject: anyone compiled 2.2.17 on RH7 successfully?
Date: Tue, 14 Nov 2000 09:44:28 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

has anyone running RedHat7(with kernel 2.2.16, gcc 2.96, kgcc 2.91.66)
complied 2.2.17 kernel successfully?

i've downloaded the source and gunzip/untar to /root/linux-2.2.17

1. make menuconfig (ok)
2. make dep (ok)
3. make zImage
===> lots of warning message
===> error: checksum.S:231 badly punctuated parameter list in #define
===> error: checksum.S:237 badly punctuated parameter list in #define

4. make CC=kgcc zImage
===> snapshot of errors reported:
In file included from init/main.c:15:
/usr/i386-glibc21-linux/include/linux/proc_fs.h:283: parse error before
`mode_t'
/usr/i386-glibc21-linux/include/linux/proc_fs.h:283: warning: no semicolon
at end of struct or union
/usr/i386-glibc21-linux/include/linux/proc_fs.h:284: warning: data
definition has no type or storage class
/usr/i386-glibc21-linux/include/linux/proc_fs.h:285: parse error before
`uid'
/usr/i386-glibc21-linux/include/linux/proc_fs.h:285: warning: data
definition has no type or storage class
/usr/i386-glibc21-linux/include/linux/proc_fs.h:286: parse error before
`gid'
/usr/i386-glibc21-linux/include/linux/proc_fs.h:286: warning: data
definition has no type or storage class
....many more errors
....many more errors
....

5. changed CC= kgcc in Makefile and execute "make zImage"
===> same error as 3 (strange, seems like the the compilation is still by
gcc and not kgcc despite the change)

i was able to compile 2.4.0-test10 kernel image with "make CC=kgcc bzImage"

pls kindly advise on the possible solutions.

thanks.





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
