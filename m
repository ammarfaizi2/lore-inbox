Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312256AbSDKQuH>; Thu, 11 Apr 2002 12:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312279AbSDKQuG>; Thu, 11 Apr 2002 12:50:06 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:53436 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S312256AbSDKQuF>;
	Thu, 11 Apr 2002 12:50:05 -0400
Date: Thu, 11 Apr 2002 18:49:23 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux as a minicomputer ?
Message-ID: <20020411184923.A15238@ucw.cz>
In-Reply-To: <20020411154601.GY17962@antefacto.com> <20020411164331.GR612@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2002 at 05:43:31PM +0100, Dr. David Alan Gilbert wrote:
> * John P. Looney (john@antefacto.com) wrote:
> >  Sorry if this isn't the place for this question, but it's something that
> > came up in general office talk today.
> > 
> >  Many many moons ago, the GGI project promised us the ability to buy a
> > four-processor box, four PCI video cards, four USB mice & keyboards, and
> > let four people use that machine at once, with benefits all around.
> 
> <snip>
> 
> >  Are there any plans to bring this sort of functionality to Linux 2.6 ? As
> > I remember, some of the problems were that the GGI code was never going to
> > get into Linux proper, and enumeration of multiple keyboards and mice, but
> > I would have thought that was there a need, these problems would have been
> > fixed by now.
> 
> I'm not sure, but I don't think any code is needed if you run X.  Bung
> four USB mice, four USB keyboards in and four video cards.  Write a
> separate X config for each one specifying which PCI card should be used
> and which mouse/keyboard device should be used.  Now start an X server
> for each one.

Doesn't work unfortunately. The separate Xservers stomp on each others
toes in the process. It works if you use fbcon (thus no acceleration, no
3d), USB, and hack the X servers not to switch consoles, and take
keyboard input from /dev/input/event devices. But that's still far from
the desired state of things.

> (Fun should form in the efforts to figure out which mouse is associated
> with which keyboard and with which video output).

-- 
Vojtech Pavlik
SuSE Labs
