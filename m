Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265143AbTLFMjg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 07:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265148AbTLFMjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 07:39:36 -0500
Received: from law9-f31.law9.hotmail.com ([64.4.9.31]:23819 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S265143AbTLFMjd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 07:39:33 -0500
X-Originating-IP: [80.74.198.136]
X-Originating-Email: [tero1001@hotmail.com]
From: "Tero Knuutila" <tero1001@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: cdrecord hangs my computer
Date: Sat, 06 Dec 2003 14:39:31 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law9-F31pOlJrMjfF5N00011ce9@hotmail.com>
X-OriginalArrivalTime: 06 Dec 2003 12:39:32.0182 (UTC) FILETIME=[FF579F60:01C3BBF5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, John, Ethan and others!

I tried everything suggested. First I compiled my kernel to use ide-cd 
instead of ide-scsi. No success, cdrecord did hang. Fortunately the whole 
machine did not hang.

Then I tried apply a patch Linus send me. So I changed settings so that HP 
7200 ide burner is seen as ide-scsi device. After that cdrecord still 
freezes totally my machine.
I forgot to mention earlier: I tried cdrecord with older 2.4 kernel and it 
works fine (as ide-scsi device).

So I try to give more accurate info so You can debug this ide-scsi thing 
which is broken. I repeat already mentioned things so that "everything" is 
on one mail:

- Kernel 2.6.0-test11 with one patch on ide-scsi.c
- AMD Duron(tm) processor AuthenticAMD GNU/Linux
- Soltek motherboard: SL-75DRV
- Another CDROM drive: LG GCR-8520B idereader
- HP7200 Ide burner:
cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: HP       Model: CD-Writer+ 7200  Rev: 3.01
  Type:   CD-ROM                           ANSI SCSI revision: 02

And then I guess this is useful too:
-------
lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 
AGP]
00:08.0 VGA compatible controller: nVidia Corporation NV5M64 [RIVA TNT2 
Model 64/Model 64 Pro] (rev 15)
00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a)
00:0b.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 
0a)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 23)
00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 23)
-------

So here's everything I could find. Please let me know what other useful info 
I may submit. I am not guru like You are, so I need advices what to do.

With best regards,
     Tero Knuutila

_________________________________________________________________
Help STOP SPAM with the new MSN 8 and get 2 months FREE*  
http://join.msn.com/?page=features/junkmail

