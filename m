Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129213AbQKTU4e>; Mon, 20 Nov 2000 15:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129189AbQKTU4O>; Mon, 20 Nov 2000 15:56:14 -0500
Received: from ALyon-201-1-3-184.abo.wanadoo.fr ([193.253.188.184]:5124 "EHLO
	kaboum.unstable.org") by vger.kernel.org with ESMTP
	id <S129165AbQKTU4L>; Mon, 20 Nov 2000 15:56:11 -0500
Message-Id: <200011202025.eAKKPZg01714@kaboum.unstable.org>
Subject: Re: PROBLEM: Bad PCI detection of a sound card
From: Frederic LESPEZ <frederic.lespez@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Cc: Chmouel Boudjnah <chmouel@mandrakesoft.com>
In-Reply-To: <m3zoiz62l4.fsf@matrix.mandrakesoft.com>
In-Reply-To: <200011162058.eAGKwmg05992@kaboum.unstable.org>  <m3zoiz62l4.fsf@matrix.mandrakesoft.com>
Content-Type: text/plain
X-Mailer: Evolution 0.6 (Developer Preview)
Date: 20 Nov 2000 19:25:35 -0100
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Frederic LESPEZ <frederic.lespez@wanadoo.fr> writes:
> 
> > I think the problem is due to a bad PCI detection but i let you judge.
> > Here is a description of the problem :
> > I'm under X (Xfree 4.0.1).
> > I switch to a VT (virtual terminal).
> > I load my sound module (modprobe emu10k1).
> 
> could you try with the alsa module it should be included with your mdk7.2.

I try with alsa modules on Debian with a 2.2.17 kernel :
Sound modules loads but nothoing appeared in logs.
Alsaplayer cannot initialize libalsa.so 
amixer returns :
The ALSA sound driver was not detected in this system.

Under Mandrake 7.2, it's just the same...

I *really* think that the problem related to what lspci output :
00:0a.0 VGA compatible unclassified device: Creative Labs SB Live! EMU10000 (rev 08)
	Subsystem: Creative Labs CT4760 SBLive!
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at b400 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

A "VGA compatible" device for a sound card is quite strange. I think that's why X is confused.

Regards,
Fred.

PS: Please CC me if you post a follow-up. 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
