Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265361AbTA1NNK>; Tue, 28 Jan 2003 08:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265368AbTA1NNK>; Tue, 28 Jan 2003 08:13:10 -0500
Received: from skynet.stack.nl ([131.155.140.225]:45584 "EHLO skynet.stack.nl")
	by vger.kernel.org with ESMTP id <S265361AbTA1NNH>;
	Tue, 28 Jan 2003 08:13:07 -0500
Date: Tue, 28 Jan 2003 14:22:25 +0100 (CET)
From: Jos Hulzink <josh@stack.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Wichert Akkerman <wichert@wiggy.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bootscreen
In-Reply-To: <1043758528.8100.35.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <20030128140304.L28692-100000@snail.stack.nl>
References: <Pine.LNX.4.44.0301281113480.20283-100000@schubert.rdns.com> 
 <200301281144.h0SBi0ld000233@darkstar.example.net>  <20030128114840.GV4868@wiggy.net>
 <1043758528.8100.35.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jan 2003, Alan Cox wrote:

> On Tue, 2003-01-28 at 11:48, Wichert Akkerman wrote:
> > Kiosks and things like ATMs are another place where you do not want
> > a bootscreen. You do not want to possibly confuse customers with
> > stuff that they can't understand but show a nice friendly message saying
> > 'the system is currently unavailable'.
>
> The real question is whether you want to do this in the kernel or simply at
> the moment the kernel flips to user space. An init can easily open vt2,
> draw a pretty boot screen with something like nanogui or bogl and then
> continue to spew the text to vt1 so anyone can see the text messages if
> need be.
>

I agree with you that it's not the kernels main task to draw logos, though
it might be a little late to handle it in init. 2.4 kernels take quite
some time before entering init. True, 2.5 kernels are a lot faster
already, but, take an embedded device: all drivers might be built into the
kernel, and when the kernel is entering init, most stuff is done already.

Besides: There is no need for a user to see that the kernel detected the
CPU again. Maybe the kernel messages should automagically show up in case
of errors, and flip away the logo. Of course this implies the logo is
handled completely by the kernel.

I think you are mostly done by tweaking some fbcon code, it has
implemented some logo code already.

Jos

