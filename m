Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280037AbRKDRlS>; Sun, 4 Nov 2001 12:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280969AbRKDRlI>; Sun, 4 Nov 2001 12:41:08 -0500
Received: from mpdr0.detroit.mi.ameritech.net ([206.141.239.206]:3458 "EHLO
	mailhost.det.ameritech.net") by vger.kernel.org with ESMTP
	id <S280037AbRKDRlD>; Sun, 4 Nov 2001 12:41:03 -0500
Date: Sun, 4 Nov 2001 12:44:48 -0500 (EST)
From: volodya@mindspring.com
Reply-To: volodya@mindspring.com
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: Mark McClelland <mark@alpha.dyndns.org>, video4linux-list@redhat.com,
        livid-gatos@linuxvideo.org, linux-kernel@vger.kernel.org
Subject: Re: [V4L] Re: [RFC] alternative kernel multimedia API
In-Reply-To: <200111040839.fA48deO123804@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.20.0111041230040.938-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 4 Nov 2001, Albert D. Cahalan wrote:

> Mark McClelland writes:
> > volodya@mindspring.com wrote:
> >> On Mon, 29 Oct 2001, Gerd Knorr wrote:
> 
> >>> You can't.  But I don't see why this is a issue:  The only thing a
> >>> application can handle easily are controls like contrast/hue where the
> >>> only thing a application needs to do is to map it to a GUI and let the
> >>> user understand and adjust stuff.  The other stuff has way to much
> >>> non-trivial dependences, I doubt a application can blindly use new
> >>> driver features.
> >>
> >> Have you ever thought that the reason we only use these controls is
> >> because they are the only ones easy to implement now ?
> >
> > What I don't understand is how will your driver implement these controls 
> > in a generic V4L3  GUI control app automatically? No matter how powerful 

kmultimedia, not V4L3. The interface is meant to be used with _all_
multimedia devices, not just video ones.

> > the semantic information you give to the app is, it can still only build 
> > interfaces from standard GUI components that it already knows about. The 
> > app cannot build a gamma curve control on its own. If it could, we 
> > wouldn't need programmers anymore :)
> 
> The driver provides this:  /proc/v4l3/vid0/gamma.java
> 
> :-)
> 
> The very idea of a gamma table is featuritis. Just a single number
> will do for most anyone. You get from 0.01 to 2.55 and "off" with
> just 8 bits.

And the color correction is unnecessary too. In fact I see a big
opportunity for you to try selling IBM PCs with DOS and generic monitors
to artistic community. Just imagine the slogan "Be free from the confines
of color!" ;)

But on a more serious note: the hardware already has it. All I want is to
export the interface to the userspace so that users can decide whether
they want to or not.

> 
> If you want to get fancy, I guess you need:
> 
> 1 gamma value per primary
> 3 tri-stimulus values for each primary  ("What color is red?")
> 3 tri-stimulus values for the whitepoint (maybe)
> 1 black level for each primary
> 
> That is 18 values at most.

See ? You are in the same pit as everyone else. You are trying to
construct a single model that fits everything. This is the exact 
problem that makes Windows so awkward: if you are doing what Microsoft
thought you might do you are ok(more or less), if you are trying something
new you are screwed.

Leave the choice to the user and application programmer. Make it easy for
them to support it.

Regardless, I am going to give it a try implementing it. It looks like the
main argument boiled down to: why bother while we have v4l2 and if you
really want we can extend it, which is more or less what I expected, I
don't believe any further discussion will make sense until there is some
code to look at.

Big thanks to everyone for comments :)

                              Vladimir Dergachev

> 
> 


