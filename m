Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbUL1MVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbUL1MVf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 07:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbUL1MVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 07:21:35 -0500
Received: from imap.gmx.net ([213.165.64.20]:29569 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261203AbUL1MV1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 07:21:27 -0500
X-Authenticated: #23921511
Message-ID: <41D14FAF.1070507@gmx.de>
Date: Tue, 28 Dec 2004 13:21:03 +0100
From: "prem.de.ms" <prem.de.ms@gmx.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, kraxel@bytesex.org
Subject: problems with cx88 driver
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

First of all, thanks Adrian, your cx88 patch works well.
But I have some other problems with the cx88 driver:
My card is sometimes shown as an unknown device and it is also 
recognized as a "Hauppauge WinTV 34xxx models"  by dmesg and tvtime (the 
card is a Hauppauge WinTV-PCI).
The screen stays b/w until I set hue to 0 and saturation to 100 in tvtime.

Here is the output of lspci -vv:
00:0e.0 Multimedia video controller: Conexant: Unknown device 8800 (rev 05)
       Subsystem: Hauppauge computer works Inc.: Unknown device 3401
       Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
       Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
       Latency: 32 (5000ns min, 13750ns max), cache line size 08
       Interrupt: pin A routed to IRQ 10
       Region 0: Memory at ec000000 (32-bit, non-prefetchable) [size=16M]
       Capabilities: [44] Vital Product Data
       Capabilities: [4c] Power Management version 2
               Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.1 Multimedia controller: Conexant: Unknown device 8811 (rev 05)
       Subsystem: Hauppauge computer works Inc.: Unknown device 3401
       Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
       Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
       Latency: 32 (1000ns min, 63750ns max), cache line size 08
       Interrupt: pin A routed to IRQ 10
       Region 0: Memory at eb000000 (32-bit, non-prefetchable) [size=16M]
       Capabilities: [4c] Power Management version 2
               Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-

dmesg:
[...]
Linux video capture interface: v1.00
cx2388x v4l2 driver version 0.0.4 loaded
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI interrupt 0000:00:0e.0[A] -> GSI 10 (level, low) -> IRQ 10
cx88[0]: subsystem: 0070:3401, board: Hauppauge WinTV 34xxx models 
[card=1,autodetected]
cx88[0]: hauppauge eeprom: model=34514, tuner=LG TPI8PSB01D (28), radio=yes
cx88[0]/0: found at 0000:00:0e.0, rev: 5, irq: 10, latency: 32, mmio: 
0xec000000
cx88[0]/0: registered device video0 [v4l2]
cx88[0]/0: registered device vbi0
cx88[0]/0: registered device radio0
cx88[0]/0: set_audio_standard_BTSC (status: known-good)
cx2388x blackbird driver version 0.0.4 loaded
cx88[0]/0: cx88: tvaudio thread started
cx88[0]/0: AUD_STATUS: 0x22 [mono/no pilot] ctl=BTSC_AUTO_STEREO
tuner: chip found at addr 0xc2 i2c-bus cx88[0]
tuner: type set to 28 (LG PAL_BG+FM (TPI8PSB01D)) by cx88[0]
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
[...]
cx88[0]/0: AUD_STATUS: 0x5172 [mono/no pilot] ctl=A2_FORCE_MONO1
cx88[0]/0: AUD_STATUS: 0x5176 [mono/pilot c1] ctl=A2_FORCE_MONO1
cx88[0]/0: AUD_STATUS: 0x5172 [mono/no pilot] ctl=A2_FORCE_MONO1
cx88[0]/0: AUD_STATUS: 0x51b6 [mono/pilot c1] ctl=A2_FORCE_MONO1
cx88[0]/0: AUD_STATUS: 0x5172 [mono/no pilot] ctl=A2_FORCE_MONO1
cx88[0]/0: AUD_STATUS: 0x513a [mono/pilot c2] ctl=A2_FORCE_MONO1
cx88[0]/0: AUD_STATUS: 0x5132 [mono/no pilot] ctl=A2_FORCE_MONO1
cx88[0]/0: AUD_STATUS: 0x517a [mono/pilot c2] ctl=A2_FORCE_MONO1
cx88[0]/0: AUD_STATUS: 0x5176 [mono/pilot c1] ctl=A2_FORCE_MONO1
cx88[0]/0: AUD_STATUS: 0x51ba [mono/pilot c2] ctl=A2_FORCE_MONO1
cx88[0]/0: AUD_STATUS: 0x51b2 [mono/no pilot] ctl=A2_FORCE_MONO1
cx88[0]/0: AUD_STATUS: 0x5176 [mono/pilot c1] ctl=A2_FORCE_MONO1
cx88[0]/0: AUD_STATUS: 0x5172 [mono/no pilot] ctl=A2_FORCE_MONO1
cx88[0]/0: AUD_STATUS: 0x51f6 [mono/pilot c1] ctl=A2_FORCE_MONO1
cx88[0]/0: AUD_STATUS: 0x51f2 [mono/no pilot] ctl=A2_FORCE_MONO1
cx88[0]/0: AUD_STATUS: 0x51b2 [mono/no pilot] ctl=A2_FORCE_MONO1
cx88[0]/0: AUD_STATUS: 0x5172 [mono/no pilot] ctl=A2_FORCE_MONO1
cx88[0]/0: AUD_STATUS: 0x51b2 [mono/no pilot] ctl=A2_FORCE_MONO1
cx88[0]/0: AUD_STATUS: 0x517a [mono/pilot c2] ctl=A2_FORCE_MONO1
cx88[0]/0: AUD_STATUS: 0x5172 [mono/no pilot] ctl=A2_FORCE_MONO1
cx88[0]/0: AUD_STATUS: 0x51b2 [mono/no pilot] ctl=A2_FORCE_MONO1
cx88[0]/0: AUD_STATUS: 0x5176 [mono/pilot c1] ctl=A2_FORCE_MONO1
cx88[0]/0: AUD_STATUS: 0x513a [mono/pilot c2] ctl=A2_FORCE_MONO1
cx88[0]/0: AUD_STATUS: 0x50f6 [mono/pilot c1] ctl=A2_FORCE_MONO1
cx88[0]/0: AUD_STATUS: 0x5132 [mono/no pilot] ctl=A2_FORCE_MONO1
cx88[0]/0: AUD_STATUS: 0x5136 [mono/pilot c1] ctl=A2_FORCE_MONO1
cx88[0]/0: AUD_STATUS: 0x5176 [mono/pilot c1] ctl=A2_FORCE_MONO1
cx88[0]/0: AUD_STATUS: 0x5172 [mono/no pilot] ctl=A2_FORCE_MONO1
cx88[0]/0: AUD_STATUS: 0x51b2 [mono/no pilot] ctl=A2_FORCE_MONO1
cx88[0]/0: AUD_STATUS: 0x51f2 [mono/no pilot] ctl=A2_FORCE_MONO1
cx88[0]/0: AUD_STATUS: 0x51ba [mono/pilot c2] ctl=A2_FORCE_MONO1
cx88[0]/0: AUD_STATUS: 0x51b6 [mono/pilot c1] ctl=A2_FORCE_MONO1
cx88[0]/0: AUD_STATUS: 0x51f6 [mono/pilot c1] ctl=A2_FORCE_MONO1
cx88[0]/0: AUD_STATUS: 0x51b6 [mono/pilot c1] ctl=A2_FORCE_MONO1
cx88[0]/0: AUD_STATUS: 0x51f2 [mono/no pilot] ctl=A2_FORCE_MONO1
cx88[0]/0: AUD_STATUS: 0x51b2 [mono/no pilot] ctl=A2_FORCE_MONO1
[...and many lines similar to those before]

Any suggestions?
