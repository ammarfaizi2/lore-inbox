Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265063AbSJWPit>; Wed, 23 Oct 2002 11:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265064AbSJWPit>; Wed, 23 Oct 2002 11:38:49 -0400
Received: from gateway.cinet.co.jp ([210.166.75.129]:64328 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S265063AbSJWPir>; Wed, 23 Oct 2002 11:38:47 -0400
Message-ID: <3DB6C3F4.4A2C4EC5@cinet.co.jp>
Date: Thu, 24 Oct 2002 00:44:52 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.44-pc98smp i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Dave Jones <davej@codemonkey.org.uk>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET 1/25] add support for PC-9800 architecture (apm)
References: <Pine.GSO.4.21.0210231257200.12783-100000@vervain.sonytel.be>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote:
> 
> On Fri, 18 Oct 2002, Dave Jones wrote:
> > On Sat, Oct 19, 2002 at 01:56:19AM +0900, Osamu Tomita wrote:
> >  > This patchset adds support for NEC PC-9800 architecture, against 2.5.43.
> >  > Fixed bad things commented by Russell King.
> >  >
> >  > PC-9800 series machines are made by NEC. But sold only in japan.
> >  > Formaly, they were best sellers in japan.
> >  > We port linux for PC-9800 since 2.1.57.
> >  >
> >  > I'm testing 2.5.43 with this patchset on some boxes.
> >  > - PC-9800 i586 UP with IDE drive
> >  > - PC-9800 i686 SMP with SCSI drive
> >  > - AT compatible with IDE drive (patch applied but not set CONFIG_PC9800).
> >  > They works well.
> >  > We are doing our best, patchset has no effect on original without configuring
> >  > for PC-9800.
> >  > Please apply this patchset.
> >
> > The biggest sticking point as far as I'm concerned with this patchset
> > is the source readability after applying it.
> > Something really needs to be done about the #if pollution this
> > patch adds before it's ready for inclusion. The whole patchset adds
> > over 700 #if's/ifdefs/ifndefs.
> 
> Indeed, I have the same comment after browsing through the frame buffer device
> and console patches.
> 
> I think the need for 32-bit character/attribute data on PC-9800 can easily be
> abstracted inside a few screen specific typedefs, macros, and functions, e.g.
>   - add typedef u32/u16 charattr_t
>   - add scr_kmalloc() to allocate virtual console buffers
>   - modify scr_readw() and friends for character/attribute data access
> and a lot of the #ifdef's can be removed.
> 
> What do you think?
Indeed. I'll try it in next step. Thank you very much.

Regards
Osamu Tomita
