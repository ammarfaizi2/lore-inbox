Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270464AbRIYTVk>; Tue, 25 Sep 2001 15:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272588AbRIYTVb>; Tue, 25 Sep 2001 15:21:31 -0400
Received: from scispor.dolphinics.no ([193.71.152.117]:48900 "EHLO
	scispor.dolphinics.no") by vger.kernel.org with ESMTP
	id <S270464AbRIYTVU> convert rfc822-to-8bit; Tue, 25 Sep 2001 15:21:20 -0400
Message-ID: <200109252125050609.3061D3F9@scispor.dolphinics.no>
X-Mailer: Calypso Version 3.00.03.02 (1)
Date: Tue, 25 Sep 2001 21:25:05 +0200
From: "Simen Thoresen" <simentt@dolphinics.no>
To: "alan" <alan@lxorguk.ukuu.org.uk>, andre@aslab.com
Cc: linux-kernel@vger.kernel.org
Subject: repeatable hard hang with 2.2.19+ide.2.2.19.05042001
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Box is a dual P3 866 on a ViA Apollo Pro 133A card (Epox D3VA).
The ide patch is neccesary for the HPT370 controllers (one onboard + one on addon card).
Kernel is compiled using the same config as working 2.2.17+ide.2.2.17.all.20000904, with the addition of CONFIG_BLK_DEV_VIA82CXXX. 
No other patches are applied.

Hang occurs during boot after listing ide devices on controllers;

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0x9800-0x9807,0x9c02 on irq 16
ide3 at 0xa000-0xa007,0xa402 on irq 16
ide4 at 0xac00-0xac07,0xb002 on irq 16
ide5 at 0xb400-0xb407,0xb802 on irq 16
<hang>

On the working kernel, the next entry here is
hda: IBM-DTLA-305020, 19623MB w/380kB Cache, CHS=39870/16/63, UDMA(33)
(the table above seems identical on the working 2.2.17 and 2.2.19 kernels)

After the listing above, the system hangs without any other output. Scrollback is not working.

As I'm currently using the 2.2.17 kernel and things are perfectly stable there, this is non-critical for me, but it might be of interest for others. The system is non-critical, so I can perform further tests on request.

Yours,
-S
--
Simen Thoresen, Beowulf-cleaner and random artist - close and personal.

Er det ikke rart?
The gnu RART-project on http://valinor.dolphinics.no:1080/~simentt/rart


