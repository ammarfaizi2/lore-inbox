Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274589AbRITST5>; Thu, 20 Sep 2001 14:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274593AbRITSTw>; Thu, 20 Sep 2001 14:19:52 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:56335 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S274589AbRITSTW>;
	Thu, 20 Sep 2001 14:19:22 -0400
Date: Thu, 20 Sep 2001 20:19:43 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: Linux not detecting ide0
To: vojtech@suse.cz,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        andre@linux-ide.org
Message-id: <3BAA333F.64725B02@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I discovered some weird behavior in IDE interface handling.
I some cases linux detects the ide1 channel , but not ide0.
More precisely , it prints a line like :

ide0: BM-DMA xxxxxx

but that is it. Nothing else. No line of :

ide0:  at 0x0170 blah blah 

no drives on the channel are recognized.
No ide0 entry in /proc/devices 
etc.

ide1 and the devices on it are more or less OK. ( I didn't notice
any problems, but it is hard to test if linux does not see the root
fs on hda ! )

I tested the redhat kernel-2.4.7-10 and vanilla linux 2.4.9.

Hardware details :
- MSI K7T Pro2A motherboard , BIOS v2.9 , VIA KT133 chipset, via 686b southbridge
- hda is an IBM Deskstar 75GXP 45 GB hard drive ( DTLA-307045 ) ( 80-wire cable,
    cable-select , connected to the end of the cable, thus master )
- hdb : none
- hdc : Acer 1208A CD-RW drive ( cable select (master))
- hdd : Teac CD532E-B CD-ROM ( cable select (slave))    80-wire cable

The way to trigger this is to set one of the IDE devices in BIOS to wrong geometry.
Maybe it is a BIOS bug.

I some cases I also got a weird line from linux :
hd1: C/H/S=0/0/0 from BIOS ignored

I thought that disk are enumerated by letter only, not numbers.
( it is H-D-one , not H-D-ell, in case you have a funny font )


-- 
David Balazic
--------------
"Be excellent to each other." - Bill S. Preston, Esq., & "Ted" Theodore Logan
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
