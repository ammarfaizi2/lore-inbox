Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265082AbSJWQGv>; Wed, 23 Oct 2002 12:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265083AbSJWQGu>; Wed, 23 Oct 2002 12:06:50 -0400
Received: from gateway.cinet.co.jp ([210.166.75.129]:2633 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S265082AbSJWQGr>; Wed, 23 Oct 2002 12:06:47 -0400
Message-ID: <3DB6CA87.509F045E@cinet.co.jp>
Date: Thu, 24 Oct 2002 01:12:55 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.44-pc98smp i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET 22/25] add support for PC-9800 architecture (sound alsa)
References: <20021019015653.A1642@precia.cinet.co.jp>
		<s5hznt51ksm.wl@alsa2.suse.de>
		<3DB6C1BD.41DC80AC@cinet.co.jp> <s5hbs5l17ku.wl@alsa2.suse.de>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:
> 
> Hi,
> 
> At Thu, 24 Oct 2002 00:35:25 +0900,
> Osamu Tomita wrote:
> >
> > Thanks for comments.
> >
> > Takashi Iwai wrote:
> > > At Sat, 19 Oct 2002 01:56:53 +0900,
> > > Osamu Tomita wrote:
> > > >
> > > > This is part 23/26 of patchset for add support NEC PC-9800 architecture,
> > > > against 2.5.43.
> > > >
> > > > Summary:
> > > >  ALSA sound driver related modules.
> > > >   - add feature to support CS4231+OPL3 (not PNP)
> > >
> > > Are you sure that it's really CS4231?
> > > If it's a higher model, such as cs4232, cs4235 or cs4236, FM OPL3 is
> > > already supported (although additional codes to opl3 module are
> > > necessary for PC9800).
> > Your comment is reasonable. Some card has CS4232. But CS4232 is used
> > as CS4231. I guess there is some hardwired circuit. And some card has
> > CS4231. CS4231 driver works fine for ether chip on PC-9800.
> > So I choose CS4231 driver for PC-9800.
> 
> well, in fact, cs4232 is backward compatible to cs4231.
> 
> the question is, whether cs4232 module works on PC9800, or not.
> i guess the control-port is not used on this card.  in such a case,
> you can deactivate the control-port via module option (or even add
> ifdef for the specific kernel config).
> 
> if cs4232 doesn't work, we'll apply your patch to cs4231.
> 
> > > >   - add hardware specific initialization.
> > >
> > > The MPU401 hack looks odd.
> > > I'd propose to split a PC9800 specific driver up, rather than
> > > including bunch of ifdefs...
> > I see. I'll split MPU401 driver.
> 
> thanks.
> 
> please send me the new patch to me, too, so that i can merge it also
> to ALSA tree.
Thanks! I'll do everythig.

Regard
Osamu Tomita
