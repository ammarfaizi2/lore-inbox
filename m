Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282364AbRK2EGL>; Wed, 28 Nov 2001 23:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282363AbRK2EGB>; Wed, 28 Nov 2001 23:06:01 -0500
Received: from mtiwmhc21.worldnet.att.net ([204.127.131.46]:20930 "EHLO
	mtiwmhc21.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S282361AbRK2EFv>; Wed, 28 Nov 2001 23:05:51 -0500
Message-ID: <3C05B310.4030402@softhome.net>
Date: Wed, 28 Nov 2001 23:01:20 -0500
From: Mark Moss <kc8dei@softhome.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernal Panic while reading loop device.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In Kernel 2.5.1-pre3, I receive a kernal panic whenever I execute the 
following two commands.  This panic does not occur in 2.5.1-pre1.  The 
stock kernel has been patched with Alan Cox's pc_keyb.c patch and with 
the early_printk patch.

I don't have time tonite to revert the early_printk patch and see if the 
panic still happens.  If anyone thinks it is relevant, I will try this 
tomorrow without the early_printk patch.

If anyone would like more information, please let me know.

Mark Moss
kc8dei@softhome.net

The commands which generate the panic are:

losetup /dev/loop0 /dev/scd0
cat /dev/loop0

/dev/scd0 contains a CD-RW burned using the text "This is a test." as 
the image.

Here is my transcription of the panic message: (Apologies for any 
write-p's, it was transcribed by hand).

---
Unable to handle kernel NULL pointer dereference at virtual address 
00000000.

printing eip
C01865F7
*pde=00000000
Oops: 0002
CPU: 0
EIP: 0010:[<C01865f7>]
EEFlags: 00010046
eax: 00000000 ebx: 00000200 ecx:00000400 edx: 00000170
esi: C0283158 edi: 00000000 ebp:C0283158 esp: C022bcc4
dsi: 0018 esi:0018 ss:0018

Process Swapper CPU:0 Stackpage (022b0000)

Stack:
0000000C 00000003 00000801 C0283158 00000000 C0283158 C018671E C0283158
00000000 00000200 00000800 C0CD16E0 00000000 C886D12C C0283158 00000000
00000800 C0CD16C0 00000800 00000800 C0283158 C886D66D C0283158 C0CD1600

Call Trace:
C018671E C886D12E C886D66D C8825730 C886D4B0 C0188078 C0181FA0 C0108378
C01053B0 C010A3E9 C01053B0 C01053D3 C0105452 C0105000

Code:
F3 66 6D 5B 5E 5B 5E 5F 5D C3 EB 0D 90 90 90 90 90 90 90 90

<0> Kernel Panic: Proc Killing Interrupt Handler!
In Interrupt Handler - not syncing
---


Modules Loaded:
sg
ide-scsi
sr_mod
cdrom
smbfs
3c95x
usb-uhci
nls-iso8859-1
nls-cp437
msdos
fat

Dump of SCSI Bus:
Attached Devices
Host: scsi0 Channel: 00 Id: 00 Lun: 00
    Vendor: MITSUMI  Model: CR-4804-TE    Rev: 2.4C
    Type: CD-ROM                          ANSI SCSI revision 02.

