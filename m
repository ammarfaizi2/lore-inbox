Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130900AbRC3HDa>; Fri, 30 Mar 2001 02:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130940AbRC3HDU>; Fri, 30 Mar 2001 02:03:20 -0500
Received: from mailgate.bridgetrading.com ([62.49.201.178]:61447 "EHLO 
	directcommunications.net") by vger.kernel.org with ESMTP
	id <S130900AbRC3HDQ>; Fri, 30 Mar 2001 02:03:16 -0500
From: "Chris Funderburg" <chris@directcommunications.net>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: memcpy in 2.2.19
Date: Fri, 30 Mar 2001 08:04:17 +0100
Message-ID: <CHEEIAEEAIFDOCGJIAKPOEDCCJAA.chris@directcommunications.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What's wrong with this picture:

ld -m elf_i386 -T /usr/src/kernel/stable/linux/arch/i386/vmlinux.lds -e
stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o
fs/fs.o ipc/ipc.o \
        fs/filesystems.a \
        net/network.a \
        drivers/block/block.a drivers/char/char.o drivers/misc/misc.a
drivers/net/net.a drivers/scsi/scsi.a drivers/cdrom/cdrom.a
drivers/pci/pci.a drivers/pnp/pnp.a drivers/video/video.a \
        /usr/src/kernel/stable/linux/arch/i386/lib/lib.a
/usr/src/kernel/stable/linux/lib/lib.a
/usr/src/kernel/stable/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/scsi/scsi.a(aic7xxx.o): In function `aic7xxx_load_seeprom':
aic7xxx.o(.text+0x116bf): undefined reference to `memcpy'
make: *** [vmlinux] Error 1

Is this something outside the kernel tree that I've lost?  Seems a bit weird
since memcpy must be
used in thousands of other place.


---------------------------------------------------------------------
'E's not pinin'!
'E's passed on!
This parrot is no more!
He has ceased to be!
'E's expired and gone to meet 'is maker!
'E's a stiff!
Bereft of life, 'e rests in peace!
If you hadn't nailed 'im to the perch 'e'd be pushing up the daisies!
'Is metabolic processes are now 'istory!
'E's off the twig!
'E's kicked the bucket, 'e's shuffled off 'is mortal coil, run
down the curtain and joined the bleedin' choir invisibile!!
THIS IS AN EX-PARROT!!

