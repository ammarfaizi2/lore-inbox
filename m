Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316129AbSEJVWh>; Fri, 10 May 2002 17:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316130AbSEJVWh>; Fri, 10 May 2002 17:22:37 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:37282 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S316129AbSEJVWg>; Fri, 10 May 2002 17:22:36 -0400
Date: Fri, 10 May 2002 14:28:48 -0700
From: Erik Steffl <steffl@bigfoot.com>
Subject: Re: lost interrupt hell - Plea for Help
To: linux-kernel@vger.kernel.org
Message-id: <3CDC3B90.AADE1835@bigfoot.com>
MIME-version: 1.0
X-Mailer: Mozilla 4.7 [en]C-PBI-NC404  (WinNT; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en,sk
In-Reply-To: <Pine.LNX.3.96.1020509132713.1987A-100000@pioneer>
 <200205101112.g4ABCoX29098@Port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> 
> On 9 May 2002 09:34, Tomasz Rola wrote:
> > > I have tried every combination of master / slave between the two drives,
> > > the drives on their own, scsi emulation through ide-scsi, purely as IDE
> > > drives, ommitting ide cdrom support from teh kernel completely and only
> > > using ide-scsi... every time I try to get a track ripped, dmesg fills up
> > > with hdX: lost interrupt.
> > >
> > > If I try to rip from the DVD drive, the system hangs and its reset
> > > button time.
> > >
> > > Can anyone tell me where I'm going wrong? Is there anything from my
> > > system you need to see to help me?

  I have same problem (see some other emails from me, I haven't posted
about anything else), via motherboard, audio cd ripping doesn't work (I
get lost interrupt messages).

  I am pretty sure it's kernel problem (or motherboard design issue,
which is sort of kernel problem as well), I tried (none of it makes any
difference):

  - different cd-rom drivers (same situation),
  - dma on/off
  - 32 bit access on/off
  
  everything else except of audio ripping works (burning, data cd
reading, HD connected instead of cdrom drive etc.)

  PCI IDE card works (in same conmputer, same cdrom drive, same IDE
cables).

  the IRQ works ok, as long as the activity is something else than audio
ripping - the numbers in /proc/interrupts go up, there doesn't seem to
be any interrupt conflict (it's assigned by BIOS, IRQ 15, nothing else
seems to be using 15, at least nothing that would be visible on bios
bootup screen (it prints irq assignments) or linux (/proc/interupts
doesn't list 15 at all if the cdrom drive is not there, it lists hdc if
the drive is in).

  there are other people who have the same problem, it looks like all
are via chipsets related (I just got email from another guy who cannot
find a solution either).

  this is with stable kernel (I tried 2.4.17 and 2.4.18), via config
option compiled in (I haven't tried without via support in kernel yet,
I'll try that).

  any ideas? TIA

	erik
