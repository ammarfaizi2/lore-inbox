Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316610AbSHOIWA>; Thu, 15 Aug 2002 04:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316614AbSHOIWA>; Thu, 15 Aug 2002 04:22:00 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:2308 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S316610AbSHOIV7>; Thu, 15 Aug 2002 04:21:59 -0400
Message-Id: <200208150821.g7F8L6p19730@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Andrew Rodland <arodland@noln.com>, Stas Sergeev <stssppnn@yahoo.com>
Subject: Re: [ANNOUNCE] New PC-Speaker driver
Date: Thu, 15 Aug 2002 11:18:01 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <3D5A8C2C.9010700@yahoo.com> <20020814184407.4ca9e406.arodland@noln.com>
In-Reply-To: <20020814184407.4ca9e406.arodland@noln.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 August 2002 20:44, Andrew Rodland wrote:
> > >> The latest patch for 2.4.18 kernel
> > >> is available here:
> > >> http://www.geocities.com/stssppnn/pcsp.html
> > >
> > > Tested. Works for playing MP3s.
> >
> > Thanks for your testing, indeed my primary
> > goal was to make the sound quality acceptable
> > even for playing MP3s.
> > With the motherboard's output attached to an
> > external speakers the quality is definitely
> > acceptable, but for the internal beeper I am not
> > shure if it is possible to really enjoy MP3s however:)

I'm afraid I'll disappoint you guys but chances of getting this into mainline
are slim for the following reasons:

1.New motherboards have built-in sound, it may be crappy but definitely
  better than PC speaker.
2.PC speaker hardware is not standardized enough. It is designed to beep reliably,
  but no manufacturer tests it for good frequency diagram and such. Since they may
  be wired differently, you can't be sure which way you can force maximum amplitude
  on a particular mobo (there are 2 or 3 ways to reach max on different mobos.
  Or so I read in a magazine a long ago).
3.It loads CPU enormously. Even more so considering that some recent chipsets _emulate_
  speaker via their integrated sound and SMM mode (ick).

These are typical symptoms:
> I can get some pretty decent sound out of it, but I also get some
> horrible noise. Even if I send the driver a stream of zeroes, as soon
> as it's opened it starts generating some horrible clicks and a
> high-pitched whine.
>
> Do I blame my motherboard (actually, a laptop)? Is there any way to fix
> this, or at least improve it?

In short: making it work right on wide variety of hardware is next to impossible
and even then results are mediocre (low volume, radio quality).

Of course I understand the desire to make simple hardware do nice and unexpected
things which it even wasn't designed to do.  :-)  Maybe ALSA team have some member
crazy enough to join you.
--
vda
