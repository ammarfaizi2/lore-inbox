Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312395AbSDKRIf>; Thu, 11 Apr 2002 13:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312495AbSDKRIe>; Thu, 11 Apr 2002 13:08:34 -0400
Received: from gumby.it.wmich.edu ([141.218.23.21]:64761 "EHLO
	gumby.it.wmich.edu") by vger.kernel.org with ESMTP
	id <S312395AbSDKRId>; Thu, 11 Apr 2002 13:08:33 -0400
Subject: Re: linux as a minicomputer ?
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020411184923.A15238@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 11 Apr 2002 13:07:44 -0400
Message-Id: <1018544869.962.22.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-04-11 at 12:49, Vojtech Pavlik wrote:
> On Thu, Apr 11, 2002 at 05:43:31PM +0100, Dr. David Alan Gilbert wrote:
> > * John P. Looney (john@antefacto.com) wrote:
> > >  Sorry if this isn't the place for this question, but it's something that
> > > came up in general office talk today.
> > > 
> > >  Many many moons ago, the GGI project promised us the ability to buy a
> > > four-processor box, four PCI video cards, four USB mice & keyboards, and
> > > let four people use that machine at once, with benefits all around.
> > 
> > <snip>
> > 
> > >  Are there any plans to bring this sort of functionality to Linux 2.6 ? As
> > > I remember, some of the problems were that the GGI code was never going to
> > > get into Linux proper, and enumeration of multiple keyboards and mice, but
> > > I would have thought that was there a need, these problems would have been
> > > fixed by now.
> > 
> > I'm not sure, but I don't think any code is needed if you run X.  Bung
> > four USB mice, four USB keyboards in and four video cards.  Write a
> > separate X config for each one specifying which PCI card should be used
> > and which mouse/keyboard device should be used.  Now start an X server
> > for each one.
> 
> Doesn't work unfortunately. The separate Xservers stomp on each others
> toes in the process. It works if you use fbcon (thus no acceleration, no
> 3d), USB, and hack the X servers not to switch consoles, and take
> keyboard input from /dev/input/event devices. But that's still far from
> the desired state of things.
why would they step on eachother's toes?  You tell each one to goto a
separate vc and give each a separate identifier :2 vt8 :3 vt9 etc. If
each one is using a separate video card, then they should all be able to
run accelerated (no dri) and be fine.  

 
> > (Fun should form in the efforts to figure out which mouse is associated
> > with which keyboard and with which video output).
> 


