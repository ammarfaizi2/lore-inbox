Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264657AbSLLOsA>; Thu, 12 Dec 2002 09:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264666AbSLLOsA>; Thu, 12 Dec 2002 09:48:00 -0500
Received: from alpham.uni-mb.si ([164.8.1.101]:48358 "EHLO alpham.uni-mb.si")
	by vger.kernel.org with ESMTP id <S264657AbSLLOr7>;
	Thu, 12 Dec 2002 09:47:59 -0500
Date: Thu, 12 Dec 2002 15:55:19 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: Floppy operation blocks ATA transfer ?
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-id: <3DF8A357.F501DEA4@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.8 [en] (Windows NT 5.0; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

While I was performing a "badblocks -nvs /dev/hdb" on VT1,
I did a "mcopy some.300k.file a:" and noticed that while the
file was written to the floppy, the badblocks process was
effectively blocked. The displayed sector number did not advance
and the drive LED was not blinking ( or lit ). After the "mcopy"
finished, "badblocks" continued. Is this normal and expected
behavior ? ( I sure did not expect it )

This is on a RHL 8.0 ( Psyche ) system with kernel-2.4.18-18.8.0

HW is :
Athlon 900, SiS 745 chipset
hda : Teac CD-W540E ( CD-RW )
hdb : Maxtor DiamondMax ( 4D040H2 ) 5400RPM , 40GB ATA100 harddrive
hdc : Teac CD-532E-B CDROM
hdd : IBM Deskstar 120GXP , 60GB harddrive

The "some.300k.file" was on /mnt/x which is /dev/hdd2 ( FAT32 )

I know this is a redhat patched kernel, but if any of you has
60 seconds time, please test this on your vanilla-linus ( or
any other version for that matter ) kernel and tell me if it
happens for you too.

Many thanks !
And please CC me with answers.

Regards,
David "only-amiga-can-really-multitask" Balazic
