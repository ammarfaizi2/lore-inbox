Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287322AbSACPWW>; Thu, 3 Jan 2002 10:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287337AbSACPWM>; Thu, 3 Jan 2002 10:22:12 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:16796 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S287334AbSACPWH>; Thu, 3 Jan 2002 10:22:07 -0500
Message-ID: <3C347779.D33BD961@oracle.com>
Date: Thu, 03 Jan 2002 16:23:37 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] Re: NFS "dev_t" issues..
In-Reply-To: <UTC200201030128.BAA192710.aeb@cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> 
>     From alessandro.suardi@oracle.com Thu Jan  3 00:22:23 2002
> 
>     It doesn't build for me in make_rdonly() in ext3 with debug
>      configured in:
> 
> Yes. Still w.i.p. but a better version is now
> 2.5.2pre6-kdev_t-diff-v3 (443024 bytes).

Compiles and boots fine with my config - laptop including ext2,
 ext3, fat, vfat, reiserfs, iso9660, tmpfs, ramfs, IrDA, PPP,
 Xircom Cardbus (old driver), parport, floppy, ramdisk, loop,
 IDE, ipv4, nfs/nfsd, samba, maestro3, usb UHCI and more. Not
 everything tested and one possibly related warning:

gcc -D__KERNEL__ -I/usr/src/linux-2.5.2-pre6/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686
-DMODULE   -c -o write.o write.c
write.c: In function `nfs_commit_done':
write.c:1204: warning: unsigned int format, kdev_t arg (arg 2)

Quite good so far :) thanks a lot,

--alessandro

 "this machine will, will not communicate
   these thoughts and the strain I am under
  be a world child, form a circle before we all go under"
                         (Radiohead, "Street Spirit [fade out]")
