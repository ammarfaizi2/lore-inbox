Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263364AbTIGRKI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 13:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbTIGRKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 13:10:08 -0400
Received: from mail.hometree.net ([212.34.184.41]:221 "EHLO mail.hometree.net")
	by vger.kernel.org with ESMTP id S263364AbTIGRKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 13:10:03 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: [2.4.23-pre3] - OHCI1394 - Runaway loop while stopping context
Date: Sun, 7 Sep 2003 17:09:51 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <bjfoov$gcr$1@tangens.hometree.net>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1062954591 16795 212.34.184.4 (7 Sep 2003 17:09:51 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Sun, 7 Sep 2003 17:09:51 +0000 (UTC)
X-Copyright: (C) 1996-2003 Henning Schmiedehausen
X-No-Archive: yes
User-Agent: nn/6.6.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From my brand-spanking new Toshiba Satellite 5200-903 Laptop

Kernel: 2.4.23-pre3 + cpad driver + alsa-sound

ohci1394: $Rev: 1010 $ Ben Collins <bcollins@debian.org>
ohci1394_0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394_0: Runaway loop while stopping context: ...
ohci1394_0: Runaway loop while stopping context: ...
ohci1394_0: Runaway loop while stopping context: ...
ohci1394_0: Runaway loop while stopping context: ...
ohci1394_0: OHCI-1394 165.165 (PCI): IRQ=[10]  MMIO=[20000800-20000fff]  Max Packet=[65536]
ohci1394_0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394_0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394_0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394_0: Runaway loop while stopping context: ...
ohci1394_0: Runaway loop while stopping context: ...
ohci1394_0: Runaway loop while stopping context: ...
ohci1394_0: Runaway loop while stopping context: ...

/sbin/lspci -vvt
-[00]-+-00.0  Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge
      +-01.0-[01]----00.0  nVidia Corporation: Unknown device 031a
      +-1e.0-[02-04]--+-06.0  NEC Corporation USB
      |               +-06.1  NEC Corporation USB
      |               +-06.2  NEC Corporation USB 2.0
      |               +-07.0  Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
      |               +-08.0  Intel Corp. 82801CAM (ICH3) PRO/100 VE (LOM) Ethernet Controller
      |               +-0b.0  Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support
      |               \-0d.0  Toshiba America Info Systems SD TypA Controller
      +-1f.0  Intel Corp. 82801CAM ISA Bridge (LPC)
      +-1f.1  Intel Corp. 82801CAM IDE U100
      +-1f.5  Intel Corp. 82801CA/CAM AC'97 Audio
      \-1f.6  Intel Corp. 82801CA/CAM AC'97 Modem

uname -an
Linux uzi.hutweide.de 2.4.23-pre3 #3 Sun Sep 7 10:52:47 CEST 2003 i686 i686 i386 GNU/Linux

Needless to say that it does not load the module...

Any ideas√

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

Java, perl, Solaris, Linux, xSP Consulting, Web Services 
freelance consultant -- Jakarta Turbine Development  -- hero for hire

"Dominate!! Dominate!! Eat your young and aggregate! I have grotty silicon!" 
      -- AOL CD when played backwards  (User Friendly - 200-10-15)
