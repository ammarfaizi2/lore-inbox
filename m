Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267986AbTBMH0e>; Thu, 13 Feb 2003 02:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267987AbTBMH0e>; Thu, 13 Feb 2003 02:26:34 -0500
Received: from vaak.stack.nl ([131.155.140.140]:32525 "EHLO mailhost.stack.nl")
	by vger.kernel.org with ESMTP id <S267986AbTBMH0b>;
	Thu, 13 Feb 2003 02:26:31 -0500
Date: Thu, 13 Feb 2003 08:36:20 +0100 (CET)
From: Jos Hulzink <josh@stack.nl>
To: James Simmons <jsimmons@infradead.org>
Cc: Rick Warner <rick@sapphire.no-ip.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support for dual independent keyboards in devel kernel?
In-Reply-To: <Pine.LNX.4.44.0302121833480.31435-100000@phoenix.infradead.org>
Message-ID: <20030213082212.L32807-100000@toad.stack.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2003, James Simmons wrote:

> > I have been doing some research on running 2 independent displays off of 1
> > machine (ie 2 keyboards, 2 mice, 2 vid cards, 2 monitors).. there are some
> > hacks out there now that "sort of" work.... but nothing stable and official..
> > it's all hacks....   I have read that support for this is planned for
> > 2.5/2.6, and would like to know what progress has been done.  I am willing to
> > help where I can.  I am a good C/C++ programmer, but have not done any kernel
> > work so far.
>
>    You are talking about the linuxconsole project. Yes with alot of work
> we got a multi-desktop system working. We even got several X servers with
> several patches running on different desktops even tho they where working
> out of one box. The main problem with this research was the console system
> level of code was intertwine in each input and display driver. In 2.5.X
> you see the moving of the console keyboards etc to the input api which can
> function indepenedent of the console layer. You also had the same effect
> with the new framebuffer layer. This was done to make driver writing easy
> and to help the embedded space as well as prepare for the future
> multi-desktop of linux.
>    What has not been done is true multi-desktop support. I like to work on
> this in the future but due to recent events in my life I have to abandon
> such research :-(
>

There is another project dealing with this: KGI. This project not
only deals with Linux, but also with NetBSD and Freew:BSD. Together with
the
Linux input layer KGI should support as many keyboards / mice as you can
buy.... Multiple desktop consoles runs fluently, support for full 3D
accellerated desktops (with help from an user space lib: GGI) is almost
there.

I'm still looking at how to connect multiple keyboards, for now I use a
microcontroller on a serial port which gives me 4 keyboards extra.

Unfortunately we're still missing a programmer willing to take a look at
the multiple keyboard / mice issue. The code is almost there, though not
functional yet. For info about KGI please drop by on
http://kgi-wip.sourceforge.net or irc.freenode.net #kgi

Jos

P.S. For those thinking KGI is still that crazy project doing graphics
accelleration in the kernel trough ioctls, please look again !

