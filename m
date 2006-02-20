Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932648AbWBTTbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932648AbWBTTbW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 14:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932649AbWBTTbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 14:31:22 -0500
Received: from smtp.enter.net ([216.193.128.24]:37136 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S932648AbWBTTbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 14:31:21 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Nick Warne <nick@linicks.net>
Subject: Re: No sound from SB live!
Date: Mon, 20 Feb 2006 14:31:35 -0500
User-Agent: KMail/1.8.1
Cc: Lee Revell <rlrevell@joe-job.com>, ghrt@dial.kappa.ro, perex@suse.cz,
       kernel list <linux-kernel@vger.kernel.org>
References: <20060218231419.GA3219@elf.ucw.cz> <1140381117.2733.374.camel@mindpipe> <200602201918.57087.nick@linicks.net>
In-Reply-To: <200602201918.57087.nick@linicks.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602201431.36229.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 February 2006 14:18, Nick Warne wrote:
<snip>
> Loading ALSA mixer settings:  /usr/sbin/alsactl restore
> /usr/sbin/alsactl: set_control:894: warning: name mismatch (Mic Select/3D
> Control Sigmatel - Depth) for control #74
> /usr/sbin/alsactl: set_control:896: warning: index mismatch (0/0) for
> control #74
> /usr/sbin/alsactl: set_control:994: bad control.74.value type
>
> Heh.  Every reboot I get a different control error.  But why it all works
> OK before a reboot with the same very /etc/asound.state file I don't know.

I had a similar problem, but solved that with an upgrade of alsa-lib.

I've been following this thread, because apparently my SB Live! isn't 
supported by ALSA either. I need to use the gnome mixer to affect any change 
in sound levels... Apparently none of the numerous controls offered by 
alsamixer and kmix work.

Attached is the lspci output for the card.

0000:00:10.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 
07)
        Subsystem: Creative Labs CT4780 SBLive! Value
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at 1460
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.1 Input device controller: Creative Labs SB Live! MIDI/Game Port 
(rev 07)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 0: I/O ports at 14a8
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Alsa reports it as "unknown" but functions well. To my knowledge the card came 
as OEM equipment on a Dell XPS-T850r, so I told ALSA to use the "Dell OEM" 
driver in the kernel. Before updating alsa-lib I had the problem with the 
controls. Now all I have is the fact that it seems nothing allows me to 
change the sound level programatically except the gnome mixer.

DRH
