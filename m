Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317630AbSGFLbx>; Sat, 6 Jul 2002 07:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317631AbSGFLbw>; Sat, 6 Jul 2002 07:31:52 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:27614 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S317630AbSGFLbu>; Sat, 6 Jul 2002 07:31:50 -0400
Message-ID: <3D26D446.6050206@oracle.com>
Date: Sat, 06 Jul 2002 13:28:06 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Consulting Premium Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020606
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Bug] 2.5.25 build as one user and install as root
References: <29475.1025944546@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 2.5.25 existing build system has a nasty bug.  Build as one user then
> make install as root.  It does supurious recompiles of some files and
> leaves them owned as root.  All of these files are now owned by root
> and cause problems when the build user wants to rebuild.
> 
> arch/i386/boot/compressed/vmlinux.bin
> arch/i386/boot/compressed/piggy.o
> arch/i386/boot/compressed/vmlinux
> arch/i386/boot/.setup.o.cmd
> arch/i386/boot/setup.o
> arch/i386/boot/setup
> arch/i386/boot/vmlinux.bin
> include/linux/compile.h
> init/.version.o.cmd
> init/version.o
> init/init.o
> .version
> vmlinux

Doesn't happen for me.

[asuardi@dolphin asuardi]$ cd /usr/src/linux-2.5.25/arch/i386/boot/compressed/
[asuardi@dolphin compressed]$ ls -l
total 5492
-rw-r--r--    1 asuardi  asuardi       904 Jul  6 02:27 head.o
-rw-r--r--    1 asuardi  asuardi      2880 May  2 23:24 head.S
-rw-r--r--    1 asuardi  asuardi       669 Jul  6 02:13 Makefile
-rw-r--r--    1 asuardi  asuardi      9220 Jun 28 11:52 misc.c
-rw-r--r--    1 asuardi  asuardi     14896 Jul  6 02:27 misc.o
-rw-r--r--    1 asuardi  asuardi   1065041 Jul  6 02:27 piggy.o
-rwxr-xr-x    1 asuardi  asuardi   1081033 Jul  6 02:27 vmlinux
-rwxr-xr-x    1 asuardi  asuardi   2344608 Jul  6 02:27 vmlinux.bin
-rw-r--r--    1 asuardi  asuardi   1064452 Jul  6 02:27 vmlinux.bin.gz
-rw-r--r--    1 asuardi  asuardi       130 Jul  6 02:13 vmlinux.scr

(My keyboard and mouse ceased to work, but that's another subject
  and I'll post details in another email).

--alessandro

  "my actions make me beautiful / and dignify the flesh"
                 (R.E.M., "Falls to Climb")

