Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132592AbRC1WEe>; Wed, 28 Mar 2001 17:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132582AbRC1WE1>; Wed, 28 Mar 2001 17:04:27 -0500
Received: from kerberos.suse.cz ([195.47.106.10]:52495 "EHLO kerberos.suse.cz") by vger.kernel.org with ESMTP id <S132596AbRC1V76>; Wed, 28 Mar 2001 16:59:58 -0500
Date: Wed, 28 Mar 2001 23:59:13 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Gunther Mayer <Gunther.Mayer@t-online.de>
Cc: linas@linas.org, linux-kernel@vger.kernel.org
Subject: Re: mouse problems in 2.4.2 -> lost byte
Message-ID: <20010328235913.A6994@suse.cz>
References: <20010327204551.623181B7A5@backlot.linas.org> <3AC22E18.1DD50338@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AC22E18.1DD50338@t-online.de>; from Gunther.Mayer@t-online.de on Wed, Mar 28, 2001 at 08:31:52PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2001 at 08:31:52PM +0200, Gunther Mayer wrote:
> linas@linas.org wrote:
> > 
> > It's been rumoured that Gunther Mayer said:
> > >
> > > > I am experiencing debilitating intermittent mouse problems & was about
> > > ...
> > > > Symptoms:
> > > > After a long time of flawless operation (ranging from nearly a week to
> > > > as little as five minutes), the X11 pointer flies up to top-right corner,
> > >                                                           ^^^^^^^^^^^^^^^^
> > > > and mostly wants to stay there.  Moving the mouse causes a cascade of
> > > > spurious button-press events get generated.
> > >
> > > This is easily explained: some byte of the mouse protocol was lost.
> > 
> > Bing!
> > 
> > That's it! This would also explain why gpm seems to work i.e. correctly
> > process the events, even when X11 can't.  I will take this up on the
> > Xf86 lists ...
> > 
> > > (Some mouse protocols are even designed to allow
> > >  easy resync/recovery by fixed bit patterns!)
> > 
> > This mouse seems to set every fourth byte to zero, which should allow
> > syncing ...
> 
> The fourth byte is propably the wheel or 5 button support, see
> http://www.microsoft.com/hwdev/input/5b_wheel.htm
> to get a hint about mouse protocol variations.
> 
> Getting resync right is not as easy as detecting zero bytes. You
> should account for wild protocol variations in the world wide mouse
> population, too.

The new input psmouse driver can resync when bytes are lost and also
shouldn't lose any bytes if there are not transmission problems on the
wire. But this is 2.5 stuff.

-- 
Vojtech Pavlik
SuSE Labs
