Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbTIZS3v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 14:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbTIZS3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 14:29:51 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:13573 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S261553AbTIZS3s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 14:29:48 -0400
From: Michael Frank <mhf@linuxmail.org>
To: Vojtech Pavlik <vojtech@suse.cz>,
       M?ns Rullg?rd <mru@users.sourceforge.net>
Subject: Re: [BUG?] SIS IDE DMA errors
Date: Sat, 27 Sep 2003 02:29:23 +0800
User-Agent: KMail/1.5.2
Cc: Vojtech Pavlik <vojtech@suse.cz>, andre@linux-ide.org,
       linux-kernel@vger.kernel.org
References: <yw1x7k3vlokf.fsf@users.sourceforge.net> <yw1x7k3vjw8o.fsf@users.sourceforge.net> <20030926175358.GA12072@ucw.cz>
In-Reply-To: <20030926175358.GA12072@ucw.cz>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309270229.23554.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 September 2003 01:53, Vojtech Pavlik wrote:
> On Fri, Sep 26, 2003 at 07:27:35PM +0200, M?ns Rullg?rd wrote:
> > Vojtech Pavlik <vojtech@suse.cz> writes:
> > 
> > > Actually, it's me who wrote the 961 and 963 support. It works fine for
> > > most people. Did you check you cabling?
> > 
> > I'm dealing with a laptop, but I suppose I could wiggle the cables a
> > bit.  I still doubt it's a cable problem, since reading works
> > flawlessly.
> 
> Hmm, that's indeed interesting and it'd point to a driver problem -
> when reading, the drive is dictating the timing, but when writing, it's
> the controllers turn.
> 
> So if the controller timing is not correctly programmed, reads function,
> but writes don't.
> 
> Can you send me the output of 'lspci -vvxxx' of the IDE device?
> I'll take a look to see if it looks correct.


00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (prog-if 80 [Master])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 5332
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Interrupt: pin ? routed to IRQ 10
        Region 4: I/O ports at 4000 [size=16]
        Capabilities: [58] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 39 10 13 55 05 00 10 02 00 80 01 01 00 80 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 40 00 00 00 00 00 00 00 00 00 00 62 14 32 53
30: 00 00 00 00 58 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 06 00 00 00 00 00
50: f2 07 f2 07 ea 96 d5 d0 01 00 02 86 00 00 00 00
60: ff aa ff aa 00 00 00 00 00 00 00 00 00 00 00 00
70: 17 21 06 04 00 60 1c 1e 00 60 1c 1e 00 60 1c 1e
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


> 
> > It appears to me that during heavy IO load, some DMA interrupts get
> > lost, for some reason.
> 
> Well, I've got this feeling that not just IDE interrupts get lost under
> heavy IO load with recent kernels ...

Timer interrupts too as clocks seem to run slow only
on a number of machines.

Regards
Michael

Regards
Michael

