Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbUCAVob (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 16:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbUCAVob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 16:44:31 -0500
Received: from everest.2mbit.com ([24.123.221.2]:14317 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S261446AbUCAVoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 16:44:23 -0500
Date: Mon, 1 Mar 2004 16:44:35 -0500
From: Andrew D Kirch <trelane@trelane.net>
To: Andreas Boman <aboman@eiwaz.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Message-Id: <20040301164435.70fd0a13.trelane@trelane.net>
In-Reply-To: <1078175250.2663.17.camel@asgaard.midgaard.us>
References: <20040301152357.0431ce83.trelane@trelane.net>
	<1078175250.2663.17.camel@asgaard.midgaard.us>
Organization: SOSDG
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-Scan-Signature: 74277e0eb54549721ca9ed9cad0ed133
X-SA-Exim-Connect-IP: 24.123.221.4
X-SA-Exim-Mail-From: trelane@trelane.net
Subject: Re: ALSA Issues in 2.6.3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
	*  0.0 AWL AWL: Auto-whitelist adjustment
X-SA-Exim-Version: 3.1+cvs (built Wed, 25 Feb 2004 14:12:50 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Mar 2004 16:07:30 -0500
Andreas Boman <aboman@eiwaz.com> wrote:

Aumix reflects the same mixer information as alsamixergui does.  
Both show main and pcm as 100% and unmuted.  XMMS which supports both
ALSA and OSS, functions with the same behavior, no audio output but the 
spectrum analyzer functions as it should.


> Do you have oss emulation compiled in (or loaded modules)? If so make
> sure that the oss pcm and master volumes are not muted.  
> 
> 
> 	Andreas
> 
> 
> 
> On Mon, 2004-03-01 at 15:23 -0500, Andrew D Kirch wrote:
> > I've noted repeated issues being discussed in #ALSA on freenode regarding the upgraded 1.0.2 alsa drivers in 2.6.3.  The general symptoms appear to be that the card refuses to play sound.  My configuration (Though i8x0 and emu10k1 have also been blaimed) is a via 8237 southbridge with integrated realtek sound.  The modules load without error and the speakers give an audible pop as if the card is unmuting, the speakers pop again, and no other sound is to be heard.  Playback of audio fails in mplayer, alsaplayer, esd, artsd, mpg123, all of which were compiled against alsa, of interest is that xmms will also "play" without sound.  The spectrum analyzer functions properly showing that audio is being processed, however with the already mentioned lack of actual sound.  I'm utterly befuddled to explain the cause of this, so I won't call it a bug, more an issue (I'd also assume it's been discussed already today or recently, but I just subscribed.)  I would be grateful for an answer in advance as to what might be causing this, I fully believe all settings are correct (MAIN and PCM are unmuted and at 75%, speakers are plugged in correctly, chip is enabled in bios, and detected in lspci)  For sanity reasons I am including pastes of /proc/modules, and lspci.  All other complaints are from upgrades to 2.6.3.  Alsa-libs and alsa-utils 1.0.2 are installed.
> > 
> > My system is as follows:
> > Gigabyte GA-K8VNXP
> > AMD Athlon 64 3200+ 1mb L2
> > 1gb Corsair XMS PRO series memory
> > pny Geforce 4 ti 4200
> > 40gb maxtor harddrive
> > via_rhine eth0
> > rtl8169 eth1
> > 8237 southbridge
> > 
> > gentoo64 root # lspci
> > 00:00.0 Host bridge: VIA Technologies, Inc. VT8385 [K8T800 AGP] Host Bridge (rev 01)
> > 00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800 South]
> > 00:0f.0 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 06)
> > 00:10.0 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 81)
> > 00:10.1 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 81)
> > 00:10.2 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 81)
> > 00:10.3 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 81)
> > 00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
> > 00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
> > 00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
> > 00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 78)
> > 00:13.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 (rev 10)
> > 00:14.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8025 (rev 01)
> > 00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
> > 00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
> > 00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
> > 00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
> > 01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti 4200] (rev a3)
> > 
> > gentoo64 root # cat /proc/modules
> > nvidia 2564596 0 - Live 0xffffffffa00c9000
> > parport_pc 36696 0 - Live 0xffffffffa00bf000
> > parport 39532 1 parport_pc, Live 0xffffffffa00b4000
> > r8169 10692 0 - Live 0xffffffffa00b0000
> > via_rhine 18888 0 - Live 0xffffffffa00aa000
> > mii 4544 1 via_rhine, Live 0xffffffffa00a7000
> > snd_via82xx 23392 3 - Live 0xffffffffa00a0000
> > snd_ac97_codec 63044 1 snd_via82xx, Live 0xffffffffa008f000
> > gameport 4032 1 snd_via82xx, Live 0xffffffffa008d000
> > snd_mpu401_uart 6400 1 snd_via82xx, Live 0xffffffffa008a000
> > snd_rawmidi 21024 1 snd_mpu401_uart, Live 0xffffffffa0083000
> > uhci_hcd 28960 0 - Live 0xffffffffa007a000
> > ohci_hcd 17220 0 - Live 0xffffffffa0074000
> > ide_tape 51232 0 - Live 0xffffffffa0066000
> > st 35484 0 - Live 0xffffffffa005c000
> > sbp2 22088 0 - Live 0xffffffffa0055000
> > ohci1394 30852 0 - Live 0xffffffffa004c000
> > ieee1394 72200 2 sbp2,ohci1394, Live 0xffffffffa0039000
> > usb_storage 67008 0 - Live 0xffffffffa0027000
> > hid 23744 0 - Live 0xffffffffa0020000
> > ehci_hcd 23364 0 - Live 0xffffffffa0019000
> > usbcore 96240 7 uhci_hcd,ohci_hcd,usb_storage,hid,ehci_hcd, Live 0xffffffffa0000000
> > 
> > Thanks of course doubly if this is a stupid question.
> > 
> > 
> > Andrew Kirch
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Andrew D Kirch  |       Abusive Hosts Blocking List      | www.ahbl.org
Security Admin  |  Summit Open Source Development Group  | www.sosdg.org
Key At http://www.2mbit.com/~trelane/trelane.key
Key fingerprint = B4C2 8083 648B 37A2 4CCE  61D3 16D6 995D 026F 20CF
