Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132128AbRC1Scq>; Wed, 28 Mar 2001 13:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132137AbRC1Scg>; Wed, 28 Mar 2001 13:32:36 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:44557 "EHLO mailout01.sul.t-online.com") by vger.kernel.org with ESMTP id <S132128AbRC1ScV>; Wed, 28 Mar 2001 13:32:21 -0500
Message-ID: <3AC22E18.1DD50338@t-online.de>
Date: Wed, 28 Mar 2001 20:31:52 +0200
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linas@linas.org
CC: linux-kernel@vger.kernel.org
Subject: Re: mouse problems in 2.4.2 -> lost byte
References: <20010327204551.623181B7A5@backlot.linas.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linas@linas.org wrote:
> 
> It's been rumoured that Gunther Mayer said:
> >
> > > I am experiencing debilitating intermittent mouse problems & was about
> > ...
> > > Symptoms:
> > > After a long time of flawless operation (ranging from nearly a week to
> > > as little as five minutes), the X11 pointer flies up to top-right corner,
> >                                                           ^^^^^^^^^^^^^^^^
> > > and mostly wants to stay there.  Moving the mouse causes a cascade of
> > > spurious button-press events get generated.
> >
> > This is easily explained: some byte of the mouse protocol was lost.
> 
> Bing!
> 
> That's it! This would also explain why gpm seems to work i.e. correctly
> process the events, even when X11 can't.  I will take this up on the
> Xf86 lists ...
> 
> > (Some mouse protocols are even designed to allow
> >  easy resync/recovery by fixed bit patterns!)
> 
> This mouse seems to set every fourth byte to zero, which should allow
> syncing ...

The fourth byte is propably the wheel or 5 button support, see
http://www.microsoft.com/hwdev/input/5b_wheel.htm
to get a hint about mouse protocol variations.

Getting resync right is not as easy as detecting zero bytes. You
should account for wild protocol variations in the world wide mouse
population, too.
