Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269116AbUJURr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269116AbUJURr7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 13:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270805AbUJURob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 13:44:31 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:12307 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S270782AbUJUPkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 11:40:32 -0400
Message-ID: <4177DB2F.9050203@techsource.com>
Date: Thu, 21 Oct 2004 11:52:15 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Zan Lynx <zlynx@acm.org>
CC: Timothy Miller <theosib@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
References: <20041020234819.23232.qmail@web40706.mail.yahoo.com> <1098321921.4215.30.camel@localhost>
In-Reply-To: <1098321921.4215.30.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Zan Lynx wrote:
> On Wed, 2004-10-20 at 16:48 -0700, Timothy Miller wrote:
> 
>>I'm posting from home, so this won't look right.  Sorry.
>>
>>Anyhow, Andre Eisenbach said this:
>>
>>
>>If the graphics card mostly supports 2D initially, it's really not
>>much better then just about any off the shelf graphics card with VESA
>>drivers. As in, the hardware doesn't need to be open for just that.
>>Most (all?) the frustration in Linux graphics card land comes from
>>unsupported/closed 3D drivers.
>><<<
>>
>>I have tried using cards with VESA drivers before, and I found it to be
>>very painful.  Certainly, you can turn off certain features and get a
>>reasonably useful UI experience, but dragging windows around with "show
>>window contents while moving" enabled is painfully slow, even with AGP
>>4x.  Just imagine doing it over PCI.
>>
>>When it comes to desktop applications, the FIRST thing you need is good
>>2D acceleration.  In fact, that's really the ONLY thing.  OpenOffice
>>does not need to use OpenGL.  GNOME doesn't need to use OpenGL.  In
>>fact, for the most part, they don't bother.  There are some instances
>>where they use OpenGL, but most of what a workstation user does fits
>>squarely within all the functionality supplied by Xlib, which is
>>entirely 2D.
> 
> [snip]
> 
> My opinion, for what its worth:
> 
> Do 3D first and only.  2D is a subset of 3D.  Implement as much of
> OpenGL as you can in hardware and software can emulate any 2D interface
> desired.

If that's what's important, then fine.  Just keep in mind the resulting 
performance hit for many 2D operations.

A 2D engine is simple, and it's very parallelizable.  For instance, the 
logic to process 8 pixels at a time isn't much more than what's required 
to process 1 pixel at a time.  Since everything has a fixed orientation, 
you can make lots of simplifying assumptions.  With 3D, you can't 
parallelize things like texture-mapping in the same way, because 
although the destination pixels are fixed in orientation, the source 
pixels are not.  So while you can have one 2D pipeline that processes 8 
pixels, the 3D equivalent would be 8 separate 3D pipelines.  In other 
words, 2D scales better than 3D.

> 
> I agree that existing graphics cards do 2D just fine.  I can get a ATI
> card for $20 that does all the 2D I need.  But 2D isn't enough for me.
> I spend $400 on one Nvidia card.  Maybe I'm not the average, common
> user, but users like me have the highest profit margin. :-)

I don't think we can produce a $20 card, at least not as a first-run.

To get our volumes up, we would TRY to sell this card into the Windows 
market.  Yeah, I know... PAIN.  But even so, Windows is a different 
world where ideals like open source don't matter, which means the 
benefits of this product mostly disappear.

As I understand it, one of the reasons nVidia doesn't release specs is 
because they don't own all of their IP, so they're contractually 
disallowed from releasing certain information.  And that's just fine. 
The problem is that if you want to save money and buy a faster, cheaper 
nVidia card, you're stuck with closed-source drivers.  If you run into a 
kernel bug, LKML members are going to be reluctant to help you with your 
tainted kernel.

I don't know anything about ATI's position, but since I don't want to 
deal with closed-source drivers (and the fact that ATI's drivers don't 
play nice with fbconsole), I'm stuck with a Radeon 9000.  (I do believe 
the 9200 also works with the open source drivers.)  I'm also stuck with 
3D acceleration which is not nearly what I'd get from ATI-supplied drivers.

I REALLY LIKE ATI and nVidia cards.... for WINDOWS.  For Linux, I think 
I want something else.

Hmmm... so it seems that if you want open source drivers, you're going 
to have to live with slow 3D no matter WHAT you do.  :)

> I'm a pragmatic user.  I'd like full-featured Open Source drivers for my
> Nvidia card but I use the binary because they work really well and for
> me, (excellent_performance - closed_drivers) > (crappy_performance +
> open_drivers).

I haven't upgraded my kernel on this RH7.2 box here in AGES, because 
every time I do, I have to try to remember how to rebuild the nVidia 
driver.  Eventually, I just gave up on it.  Of course, that leaves me 
without all sorts of enhancements and bug fixes.  Some time soon, I'm 
going to switch over to Gentoo, but to do that, I've procured a Radeon 
9200 so I don't have to worry about closed-source drivers.

> If it can be done well enough to run Doom 3 in 640x480 at 20 fps for
> less than $500, I'll buy one.  That's the performance level where I'd
> consider sacrificing 60 fps for the open drivers.

Well, that might be doable at $500.  I don't know.  I haven't started 
thinking about some of the more high-end stuff like programmable virtex 
shading, bump mapping, or applying multiple textures in a single pass.

> Of course, in 5 years I'll expect 120 fps so its definitely a moving
> target.

Heh.

Oh, hey... another advantage of doing the open approach is that if we 
decide to completely redesign the register set, it isn't a problem, 
because there won't be any guessing about what's changed and what hasn't.

