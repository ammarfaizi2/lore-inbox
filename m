Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132147AbQLNDAN>; Wed, 13 Dec 2000 22:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132148AbQLNDAC>; Wed, 13 Dec 2000 22:00:02 -0500
Received: from aragorn.ics.muni.cz ([147.251.4.33]:9159 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S132147AbQLNC7w>; Wed, 13 Dec 2000 21:59:52 -0500
To: jmerkey@vger.timpanogas.org
Cc: dominik.kubla@uni-mainz.de, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18-25 DELL Laptop Video Problems
X-URL: http://www.fi.muni.cz/~pekon/
From: Petr Konecny <pekon@informatics.muni.cz>
Date: 14 Dec 2000 03:29:11 +0100
Message-ID: <qww1yvbivm0.fsf@decibel.fi.muni.cz>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Peisino,Ak(B)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2000 at 01:34:46AM +0100, Dominik Kubla wrote:
> On Mon, Dec 11, 2000 at 11:11:41AM -0700, Jeff V. Merkey wrote:
> ...
> > Then this is the vga=271 stuff?
> >
> > Jeff
>
> No, that's just selecting the VGA resolution. I am referring to the
> video parameter:
>
> video=<driver>:<option>[,<option>,...]
>
> Look at linux/Dokumentation/fb/modedb.txt.
>
It's not in my tree (2.2.18), the only documentation I could find was
the source code. Anyway, it seems that atyfb gets a precendence over
vesafb and screws up the LCD. Right now I use the following kernel params:
video=atyfb:off video=vesa:mtrr vga=795

For reference this is Dell Inspiron 5000, lspci -vv says this:
01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage P/M Mobility AGP 2x (rev 64) (prog-if 00 [VGA])
        Subsystem: Dell Computer Corporation: Unknown device 009f
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at fd000000 (32-bit, non-prefetchable)
        Region 1: I/O ports at 2000
        Region 2: Memory at fc000000 (32-bit, non-prefetchable)
        Capabilities: [50] AGP version 1.0
                Status: RQ=255 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [5c] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


                                                Regards, Petr
-- 
Snow Day -- stay home.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
