Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276359AbRJURSS>; Sun, 21 Oct 2001 13:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276361AbRJURSJ>; Sun, 21 Oct 2001 13:18:09 -0400
Received: from www.transvirtual.com ([206.14.214.140]:54532 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S276359AbRJURSB>; Sun, 21 Oct 2001 13:18:01 -0400
Date: Sun, 21 Oct 2001 10:18:15 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Allan Sandfeld <linux@sneulv.dk>, linux-kernel@vger.kernel.org
Subject: Re: The new X-Kernel !
In-Reply-To: <E15vJRN-0006Sm-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10110211009260.13079-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > We have the AGP, DRM and framebuffer drivers in the kernel anyway. It would 
> > make sense to do all the autodetection in kernelspace, and let the info be 
> > available to the X-server. I would love to kill all the hardware specific 
> > stuff in /etc/XF86Config, especially the keyboard and mouse stuff that 
> > belongs in or near the kernel.
> 
> Quite the reverse. The handling for mice/keyboards and dynamic changes of
> keyboard/mouse need to be in X11.

I disagree. Mice and keyboards are becoming more complex. To the point
where the hardware state has to be managed between processes in a
possible SMP system. Consider mice with force feedback. If several process
program the mouse to vibrate at the smae time it sums all the values up.
You can end up breaking the mouse because it vibrated to hard. Also look
at the problems GPM and X have had before. This problem gets more complex
as more pieces of software that play around with mice and keyboards 
emerges besides X or even while running in X. 

