Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276670AbRJUTxk>; Sun, 21 Oct 2001 15:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276671AbRJUTxa>; Sun, 21 Oct 2001 15:53:30 -0400
Received: from shake.vivendi.hu ([213.163.0.180]:18818 "EHLO
	vega.digitel2002.hu") by vger.kernel.org with ESMTP
	id <S276670AbRJUTxY>; Sun, 21 Oct 2001 15:53:24 -0400
Date: Sun, 21 Oct 2001 21:53:51 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: James Simmons <jsimmons@transvirtual.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The new X-Kernel !
Message-ID: <20011021215351.C19390@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
In-Reply-To: <E15vMMU-0007Ot-00@the-village.bc.nu> <Pine.LNX.4.10.10110211025130.13079-100000@transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10110211025130.13079-100000@transvirtual.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: vega Linux 2.4.12 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2001 at 10:40:06AM -0700, James Simmons wrote:
> 
> > > at the problems GPM and X have had before. This problem gets more complex
> > > as more pieces of software that play around with mice and keyboards 
> > > emerges besides X or even while running in X. 
> > 
> > What is this non-X thing 8)
> 
> In the embedded market their is alot of GUI environments that are not X.
> Working for a embedded linux company I come across many of them. Talking
> to other embedded companies they all have the same answer. We will not use
> X. They need something more portable and more powerful. A few off the top
> of my head.

OK then not use X for this purpose. But I don't see *ANY* point cause X
is not suitable for any usage with support kernel DRI API, giving you
XShm, DGA and many other things. Even you can create a tiny X like server
(actually it should be a library linked to applications or other) for
very low resourced embededd systems.

> have a adapter to connect a PS/2 keyboard or mouse to the iPAQ at work. I
> also have a alchemy board which allows you to plug in usb mice/keyboards. 
> 
> Plus for real game support I really like to see OpenGL use direct input.
> Sorry but you need real time response in games. Have input events going
> back a forth between the X cleint and the X server is just a waste.

This is something like DGA. DGA allows you to direct access the video
memory. DGA is very raw solution now, and yes, it should be more clever
for handling compilcated input devices as well, better integration into
X server (now, it simply mmap()s videoram so it needs root privs) and so on.
But I don't see any MAJOR point that is not possible with the current XFree
architecture which should be enhanced a bit (?) in the future, of course.

But don't move anything into kernel space which is possible in user space
as well! Just a point: XFree 4 now has got nice drivers (cross platform
compatibility on same CPU, vendors can release binary only drivers and so
on). It's MUCH harder to release binary only kernel modules not counting
cross OS compatibility ...

- Gabor
