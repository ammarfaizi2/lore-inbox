Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271032AbTHBH3i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 03:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272052AbTHBH3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 03:29:35 -0400
Received: from smtp.inet.fi ([192.89.123.192]:1182 "EHLO smtp.inet.fi")
	by vger.kernel.org with ESMTP id S271032AbTHBH3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 03:29:33 -0400
From: Pasi Savilaakso <pasi.savilaakso@pp.inet.fi>
To: linux-kernel@vger.kernel.org
Subject: audio problem with 2.4.22-pre10 and 2.4.22-pre10-ac1
Date: Sat, 2 Aug 2003 10:31:56 +0300
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200308021031.57014.pasi.savilaakso@pp.inet.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have one asus a7v8x-x, which I just installed. Everything else is fine but
no audio. when I got this on first time after compiling kernel and tried many
different configs but no success at all. current audio config is at the end of
mail.

dmesg tells:

Via 686a/8233/8235 audio driver 1.9.1-ac3
via82cxxx: Six channel audio available
PCI: Setting latency timer of device 00:11.5 to 64
via82cxxx: timeout while reading AC97 codec (0x8000000)
ac97_codec: AC97 Audio codec, id: ADS112 (Unknown)
via82cxxx: board #1 at 0xE000, IRQ 22
<--cut-->
via_audio: ignoring drain playback error -11

lspci:

00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge
00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus 
Master IDE (rev 06)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audio 
Controller (rev 50)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 MX 420] 
(rev a3)

lspci -n

00:00.0 Class 0600: 1106:3189
00:01.0 Class 0604: 1106:b168
00:10.0 Class 0c03: 1106:3038 (rev 80)
00:10.1 Class 0c03: 1106:3038 (rev 80)
00:10.2 Class 0c03: 1106:3038 (rev 80)
00:10.3 Class 0c03: 1106:3104 (rev 82)
00:11.0 Class 0601: 1106:3177
00:11.1 Class 0101: 1106:0571 (rev 06)
00:11.5 Class 0401: 1106:3059 (rev 50)
00:12.0 Class 0200: 1106:3065 (rev 74)
01:00.0 Class 0300: 10de:0172 (rev a3)

kernel config:

# Sound
#
CONFIG_SOUND=y
# CONFIG_SOUND_ALI5455 is not set
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_MIDI_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_FORTE is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
CONFIG_SOUND_VIA82CXXX=y
# CONFIG_SOUND_OSS is not set
# CONFIG_SOUND_TVMIXER is not set
CONFIG_SOUND_AD1980=y
# CONFIG_SOUND_WM97XX is not set

