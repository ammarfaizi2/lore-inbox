Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262084AbRFBH0w>; Sat, 2 Jun 2001 03:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262087AbRFBH0m>; Sat, 2 Jun 2001 03:26:42 -0400
Received: from brauhaus.paderlinx.de ([194.122.103.4]:18130 "EHLO
	imail.paderlinx.de") by vger.kernel.org with ESMTP
	id <S262084AbRFBH0e>; Sat, 2 Jun 2001 03:26:34 -0400
Date: Sat, 2 Jun 2001 09:25:49 +0200 (MEST)
From: Matthias Schniedermeyer <ms@citd.de>
To: linux-kernel@vger.kernel.org
Subject: SCSI-CD-Writer don't show up
Message-ID: <Pine.LNX.4.20.0106020917560.13579-100000@citd.owl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#Include <hallo.h>



I have 3 SCSI-CD-Writers. "Strange" is that the boot-process only finds
the first one (1 0 5 0), the other two i have to add with

echo "scsi add-single-device 2 0 4 0" > /proc/scsi/scsi
echo "scsi add-single-device 2 0 6 0" > /proc/scsi/scsi

to make them useable.

Here is the complete ist of my SCSI-Devices:

Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: IBM      Model: DDYS-T18350N     Rev: S93E
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: PLEXTOR  Model: CD-ROM PX-32TS   Rev: 1.03
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 01 Lun: 00
  Vendor: PIONEER  Model: DVD-ROM DVD-303  Rev: 1.10
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 05 Lun: 00
  Vendor: TEAC     Model: CD-R58S          Rev: 1.0N
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 02 Lun: 00
  Vendor: PIONEER  Model: DVD-ROM DVD-304  Rev: 1.03
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 03 Lun: 00
  Vendor: PIONEER  Model: DVD-ROM DVD-304  Rev: 1.03
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 04 Lun: 00
  Vendor: TEAC     Model: CD-R58S          Rev: 1.0K
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 06 Lun: 00
  Vendor: TEAC     Model: CD-R58S          Rev: 1.0P
  Type:   CD-ROM                           ANSI SCSI revision: 02

I have a "Symbios 53c1010 (Dual Channel Ultra 160)" and a "NCR 810a" The
two devices which are not found are connected through adapters onto the
second channel of the Symbios 53c1010.

Kernel is 2.4.4 or 2.4.5ac6. 
As host-adapter-driver i use the "SYM53C8XX"-driver

If other info is needed, no problem. :-)




Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.


