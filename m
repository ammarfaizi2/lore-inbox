Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312085AbSCXWY6>; Sun, 24 Mar 2002 17:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312086AbSCXWYs>; Sun, 24 Mar 2002 17:24:48 -0500
Received: from CPE-203-51-26-136.nsw.bigpond.net.au ([203.51.26.136]:1787 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S312085AbSCXWYp>; Sun, 24 Mar 2002 17:24:45 -0500
Message-ID: <3C9E5226.FD8FAB70@eyal.emu.id.au>
Date: Mon, 25 Mar 2002 09:24:38 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre3-ac1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: list linux-kernel <linux-kernel@vger.kernel.org>
CC: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Andre Hedrick <andre@linux-ide.org>
Subject: Re: 2.4.18: many IDE errors
In-Reply-To: <Pine.LNX.4.30.0203242314350.31118-100000@mustard.heime.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk wrote:
> 
> > The PCI IDE cards I use are ATA-100, so this is the max speed available
> > to be. The four large disks can do ATA-133.
> >
> > The 48bit addressing (to allow >137GB) seems to be unrelated, and it
> > works with these cards. But I needed to apply:
> >       http://www.kernel.org/pub/linux/kernel/people/hedrick/ide-2.4.18/
> >               ide.2.4.18-rc1.02152002.patch.bz2
> 
> but ...
> 
> how can that work? i mean - 48bit addressing is in the udma133 standard
> but not in udma100...
> 
> how does the /proc/mdstat and /proc/partitions look?

I am not in front of the machine, but let me tell you that mdstat shows
a full 480GB RAID5. There are no partitions (hde/g/i/k are used raw).

Again, I think udma133 and 48bit addressing are two, independent issues.
The first is an electronic spec for the hardware, the second is an api
standard which, it seems, can run at any speed.

Maybe Andre can make a clear statement here?

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
