Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281834AbRKWAcF>; Thu, 22 Nov 2001 19:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281839AbRKWAbz>; Thu, 22 Nov 2001 19:31:55 -0500
Received: from sis.com.tw ([203.67.208.3]:57270 "EHLO maillog.sis.com.tw")
	by vger.kernel.org with ESMTP id <S281834AbRKWAbq>;
	Thu, 22 Nov 2001 19:31:46 -0500
From: "kmliu" <kmliu@sis.com.tw>
To: "nelson" <nelson@sis.com.tw>, <linux-kernel@vger.kernel.org>,
        "Krzysztof Oledzki" <ole@ans.pl>
Cc: "ron" <ronchang@sis.com.tw>, "JasonTsai" <jstsai@sis.com.tw>,
        "charles" <charles@sis.com.tw>, <andre@suse.com>
Subject: SiS601?!
Date: Fri, 23 Nov 2001 08:11:38 +0800
Message-ID: <NDBBJBFIOLNMNHAELGHFKEGACJAA.kmliu@sis.com.tw>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <Pine.LNX.4.33.0111222120440.18864-100000@dark.pcgames.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by leeloo.zip.com.au id LAA04720

Hi,

We do not have any product which name is SiS601,

The IDE controller is SiS5513, the north bridge is SiS620/530/630/540/550/635/735/730/740/640/645/640.

Please make sure what is the name of the chipset.

Nelson:

Do we have SiS601 in notebook market?

Regards,
K.M. Liu

-----Original Message-----
From: Krzysztof Oledzki [mailto:ole@ans.pl]
Sent: Friday, November 23, 2001 4:53 AM
To: linux-kernel@vger.kernel.org
Cc: kmliu@sis.com.tw; andre@suse.com
Subject: SIS IDE (sis5513.c)


Hello :)

I have a notebook with SIS IDE Chipset - SIS601. This week I have
installed Linux. It seems that this chipset is not supported by sis5513.c
driver. I tried adding support myself by putting PCI_DEVICE_ID_SI_601 in
each switch/case in this file (because I found that it sound work for
PCI_DEVICE_ID_SI_540 and PCI_DEVICE_ID_SI_620 ). Unfortunetly ugly
"unknown IDE controller" message still appeard. Then I go to the ide-pci.c
and noticed that int ide_pci_chipsets here is only one line for SIS:

        {DEVID_SIS5513, "SIS5513",      PCI_SIS5513,    ATA66_SIS5513,  INIT_SIS5513,   NULL,        {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},   ON_BOARD,       0 },

and one #define:
#define DEVID_SIS5513   ((ide_pci_devid_t){PCI_VENDOR_ID_SI,      PCI_DEVICE_ID_SI_5513})

BTW: Am I right, this makes that only PCI_DEVICE_ID_SI_5513 chipset is
supported and all other chipset listed in sis5513.c will not work?

Ok, I added DEVID_SIS601 (PCI_DEVICE_ID_SI_601) with parameters from
SIS5513 or all zeros but... now I have "neither IDE port enabled (BIOS)"
message. So? Is there any way to enable DMA transfers for my HDD? With PIO
my HDD is verry slow (hdparm shows 3 MB/sek).

Best regards,

				Krzysztof Oledzki
ı:.Ë›±Êâmçë¢kaŠÉb²ßìzwm…ébïîË›±Êâmébìÿ‘êçz_âØ^n‡r¡ö¦zËëh™¨è­Ú&£ûàz¿äz¹Ş—ú+€Ê+zf£¢·hšˆ§~†­†Ûiÿÿïêÿ‘êçz_è®æj:+v‰¨ş)ß£ømšSåy«­æ¶…­†ÛiÿÿğÃí»è®å’i
