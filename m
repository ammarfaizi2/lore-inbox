Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276411AbRJURkL>; Sun, 21 Oct 2001 13:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276424AbRJURkB>; Sun, 21 Oct 2001 13:40:01 -0400
Received: from www.transvirtual.com ([206.14.214.140]:61700 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S276411AbRJURjr>; Sun, 21 Oct 2001 13:39:47 -0400
Date: Sun, 21 Oct 2001 10:40:06 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Allan Sandfeld <linux@sneulv.dk>, linux-kernel@vger.kernel.org
Subject: Re: The new X-Kernel !
In-Reply-To: <E15vMMU-0007Ot-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10110211025130.13079-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > at the problems GPM and X have had before. This problem gets more complex
> > as more pieces of software that play around with mice and keyboards 
> > emerges besides X or even while running in X. 
> 
> What is this non-X thing 8)

In the embedded market their is alot of GUI environments that are not X.
Working for a embedded linux company I come across many of them. Talking
to other embedded companies they all have the same answer. We will not use
X. They need something more portable and more powerful. A few off the top
of my head.

MicroWindows. 
Kaffe
Embedix   

Now before you say embedded devices don't use PS/2 mice and keyboards. I 
have a adapter to connect a PS/2 keyboard or mouse to the iPAQ at work. I
also have a alchemy board which allows you to plug in usb mice/keyboards. 

Plus for real game support I really like to see OpenGL use direct input.
Sorry but you need real time response in games. Have input events going
back a forth between the X cleint and the X server is just a waste.

> Seriously however most of this can be done well in userspace. The fact that
> X + gpm years ago got it wrong doesn't disprove the theory. 

As a said it is a matter of managing the hardware state between processes.
Consider a SMP machine that supports multiple desktops. Person on desktop
fires up a X server. It sets the hardware state of the keyboards and the
mice. The user runs apps that alter the state. The second user comes along
and log in on desktop two. He runs another small application to test the
mice. It changes the state which in turn effects the person on desktop
one. 


