Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318894AbSHEVnd>; Mon, 5 Aug 2002 17:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318895AbSHEVnc>; Mon, 5 Aug 2002 17:43:32 -0400
Received: from axp01.e18.physik.tu-muenchen.de ([129.187.154.129]:23565 "EHLO
	axp01.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S318894AbSHEVnc>; Mon, 5 Aug 2002 17:43:32 -0400
Date: Mon, 5 Aug 2002 23:46:43 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: "Robert A. Hayden" <rhayden@geek.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, <davem@redhat.com>
Subject: Re: 2.4.18 crashdump - P4/3ware/NFS
In-Reply-To: <Pine.NEB.4.44.0208051104300.27501-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.4.44.0208052338080.1357-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Please excuse my jumping in, but I have a very similar problem: when
copying data in both directions between the 3ware RAID and the 3C996B-T
GE-card (tg3 driver) the machine will lock up after some seconds. It
happens always in the same spot, BUG in line 1557 of tg3.c (v0.99). I have
also tried the bcm5700 driver (I know, it's unreadable), and this one died
on the exact same occasion, namely that an interrupt arrives to notify a
completed transmission, but there was none queued.

Upgrading to 2.4.19 did not help. Nor did upgrading the PS to 550W.

This happens on a dozen of dual Athlon MP (Tyan Tiger v1.02) machines, the
fs on the RAID is reiserfs. And both directions of data flow (about 10MB/s
each) have to be present to trigger this.

On Mon, 5 Aug 2002, Adrian Bunk wrote:

> On Tue, 30 Jul 2002, Robert A. Hayden wrote:
> 
> >...
> > Several times now the p4 system has either frozen (usually with a
> > crashdump), or just mysteriously rebooted while moving large quantities of
> > data over the NFS link.
> >
> > I'm at a loss to explain this unless it starts to point to hardware
> > problems (bad CPU? Memory? motherboard?).  I thought for a bit it was due
> >...
> > I don't have a text log of the dump, but I did take a digital picture of
> > it at http://www.roberthayden.com/crashdump.jpg
> >
> > If anyone has ANY thoughts here, they would be appreciated.  I hate to
> > start randomly replacing parts without an idea where to look.
> 
> - Does this problem still exist in 2.4.19?
> - Are there temperature problems inside your machine?
> - Does your power supply give your system enough energy?
> - You can test your memory using memtest86 [1].
> - Is there anything in the logfiles after the machine "mysteriously
>   rebooted"?
> - If none of the above helps, could you type the information of the
>   screenshot (best the information if it happens using 2.4.19) to a file
>   and run it through ksymoops?
> 
> > Thanks all.
> >
> > Robert
> >...
> 
> cu
> Adrian
> 
> [1] http://www.memtest86.com/
> 
> 

Ciao,
					Roland

+---------------------------+-------------------------+
|    TU Muenchen            |                         |
|    Physik-Department E18  |  Raum    3558           |
|    James-Franck-Str.      |  Telefon 089/289-12592  |
|    85747 Garching         |                         |
+---------------------------+-------------------------+

