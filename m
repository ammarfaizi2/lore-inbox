Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbUL3UKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbUL3UKv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 15:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbUL3UKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 15:10:51 -0500
Received: from black.click.cz ([62.141.0.10]:2439 "EHLO click.cz")
	by vger.kernel.org with ESMTP id S261706AbUL3UKi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 15:10:38 -0500
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: intel onboard sound card with modem - alsa problem
Date: Thu, 30 Dec 2004 21:08:28 +0100
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200412302108.28824.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried a new alsa module to get working my soundcard and build-in modem, but 
with no success:

cat /usr/src/linux-2.6.10.tar.bz2 > /dev/dsp

I get:

Dec 26 17:24:49 notas kernel: codec_semaphore: semaphore is not ready [0x1]
[0x700300]
Dec 26 17:24:49 notas kernel: codec_write 1: semaphore is not ready for 
register 0x54
Dec 26 17:24:55 notas kernel: codec_semaphore: semaphore is not ready [0x1]
[0x700300]
Dec 26 17:24:55 notas kernel: codec_write 1: semaphore is not ready for 
register 0x54
Dec 26 17:24:55 notas kernel: codec_semaphore: semaphore is not ready [0x1]
[0x700300]
Dec 26 17:24:55 notas kernel: codec_write 1: semaphore is not ready for 
register 0x54
Dec 26 17:24:57 notas kernel: codec_semaphore: semaphore is not ready [0x1]
[0x700300]
Dec 26 17:24:57 notas kernel: codec_write 1: semaphore is not ready for 
register 0x54
Dec 26 17:24:57 notas kernel: codec_semaphore: semaphore is not ready [0x1]
[0x700300]
Dec 26 17:24:57 notas kernel: codec_write 1: semaphore is not ready for 
register 0x54
Dec 26 17:24:58 notas kernel: codec_semaphore: semaphore is not ready [0x1]
[0x700304]
Dec 26 17:24:58 notas kernel: codec_write 1: semaphore is not ready for 
register 0x54
Dec 26 17:24:58 notas kernel: codec_semaphore: semaphore is not ready [0x1]
[0x700300]
Dec 26 17:24:58 notas kernel: codec_write 1: semaphore is not ready for 
register 0x54
Dec 26 17:24:59 notas kernel: codec_semaphore: semaphore is not ready [0x1]
[0x700300]
Dec 26 17:24:59 notas kernel: codec_write 1: semaphore is not ready for 
register 0x54

Standart sound module for this card works normally.
Modem works with slmodem module slamr.ko normally.

notas:/# lspci
0000:00:00.0 Host bridge: Intel Corp. 82852/855GM Host Bridge (rev 02)
0000:00:00.1 System peripheral: Intel Corp. 855GM/GME GMCH Memory I/O Control 
Registers (rev 02)
0000:00:00.3 System peripheral: Intel Corp. 855GM/GME GMCH Configuration 
Process Registers (rev 02)
0000:00:02.0 VGA compatible controller: Intel Corp. 82852/855GM Integrated 
Graphics Device (rev 02)
0000:00:02.1 Display controller: Intel Corp. 82852/855GM Integrated Graphics 
Device (rev 02)
0000:00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
USB UHCI Controller #1 (rev 03)
0000:00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
USB UHCI Controller #2 (rev 03)
0000:00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
USB UHCI Controller #3 (rev 03)
0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 
EHCI Controller (rev 03)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 83)
0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 
03)
0000:00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage 
Controller (rev 03)
0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus 
Controller (rev 03)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
0000:00:1f.6 Modem: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 
Modem Controller (rev 03)
0000:02:04.0 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus 
Controller (rev 01)
0000:02:04.1 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus 
Controller (rev 01)
0000:02:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)

notas:/# uname -a
Linux notas 2.6.10 #2 Sun Dec 26 15:51:25 CET 2004 i686 GNU/Linux

Thanks

Michal
