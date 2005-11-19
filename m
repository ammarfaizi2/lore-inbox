Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbVKSTXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbVKSTXp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 14:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbVKSTXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 14:23:45 -0500
Received: from mtiwmhc11.worldnet.att.net ([204.127.131.115]:46016 "EHLO
	mtiwmhc11.worldnet.att.net") by vger.kernel.org with ESMTP
	id S1750770AbVKSTXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 14:23:44 -0500
From: Larry.Finger@att.net (Larry.Finger@lwfinger.net)
To: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org (kernel)
Subject: Re: DMA mode locked off when via82cxxx ide driver built as module in 2.6.14
Date: Sat, 19 Nov 2005 19:23:43 +0000
Message-Id: <111920051923.4214.437F7BBF00022AD50000107621603763169D0A09020700D2979D9D0E04@att.net>
X-Mailer: AT&T Message Center Version 1 (Nov 10 2005)
X-Authenticated-Sender: TGFycnkuRmluZ2VyQGF0dC5uZXQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 -------------- Original message ----------------------
From: Vojtech Pavlik <vojtech@suse.cz>
> On Sat, Nov 19, 2005 at 06:59:37PM +0000, Larry.Finger@lwfinger.net wrote:
> > My HP ze1115 notebook uses the via82cxxx ide driver. If I configure the kernel 
> build to make that driver as a module, the driver is correctly added to initrd 
> and is loaded at boot time; however, DMA mode is turned off. It cannot be turned 
> on even if I use an 'hdparm -d1 /dev/hda' command.
> > 
> > Is this a bug, or do I need some kind of IDE=XXX boot command? As expected, 
> system performance in this mode is horrible.
>  
> What chipset does your notebook use? 'lspci -vv' should give a good
> answer.

Portion of output of lspci -vv:
 
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: Hewlett-Packard Company: Unknown device 0022
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at 1100 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-



