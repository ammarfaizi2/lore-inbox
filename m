Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272329AbRIEVqo>; Wed, 5 Sep 2001 17:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272330AbRIEVqe>; Wed, 5 Sep 2001 17:46:34 -0400
Received: from smtp4.vol.cz ([195.250.128.84]:30477 "EHLO smtp4.vol.cz")
	by vger.kernel.org with ESMTP id <S272329AbRIEVqV>;
	Wed, 5 Sep 2001 17:46:21 -0400
Date: Wed, 5 Sep 2001 23:45:44 +0200
From: Stanislav Brabec <utx@penguin.cz>
To: linux-kernel@vger.kernel.org
Subject: PCI (?) problems of MSI K7T266 Pro = MS-6380 / VIA KT266 8233
Message-ID: <20010905234544.A18413@utx.vol.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.18i
X-Accept-Language: cs, sk, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

I have Microstar mainboard MSI K7T266 Pro (MS-6380) with 
VIA KT266 chipset (VIA 8233), Athlon 1200/266, linux-2.4.9

Does anybody with this mainboard have some problems (or using it
succesfull), or should I suspect some bad setup / problematic PCI card
or more particular bugs?

Thanks for any info (please reply to my e-mail address)


I have encountered many, probably PCI related problems:

- USB PC2PC driver sometimes looses data errors (cca once per 20MB)
- SCSI scanner sometimes hangs scanning
- SCSI CD-ROM/writer sometimes fails to mount CD-ROM (read errors)
- Mangled sound output from AC97 codec
- PCI bus cannot be overclocked to more than 34.5 MHz



Used patches:
defined VIA_NEW_BRIDGES_TESTED uncommented in drivers/ide/via82cxxx.c
ftp://ftp.suse.com/pub/people/garloff/linux/dc395/ (driver for SCSI DC315U)
ftp://ftp.penguin.cz/pub/users/utx/linux-kernel/ (driver for USB PC2PC cable)

Compiler: gcc-2.95.3 & gcc-3.0.1

I have tried to activate all PCI quirks and special inits from older
chipsets without any success.

I cannot test my machine with other OS.

00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP]
00:07.0 VGA compatible controller: Tseng Labs Inc ET6000 (rev 70)
00:08.0 SCSI storage controller: Tekram Technology Co.,Ltd. TRM-S1040 (rev 01)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 18)
00:11.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 18)
00:11.4 USB Controller: VIA Technologies, Inc. UHCI USB (rev 18)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 10)


-- 
Stanislav Brabec
