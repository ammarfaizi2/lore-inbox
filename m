Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263133AbTI3G72 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 02:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263135AbTI3G72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 02:59:28 -0400
Received: from [195.249.40.37] ([195.249.40.37]:29452 "HELO nettonet.dk")
	by vger.kernel.org with SMTP id S263133AbTI3G70 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 02:59:26 -0400
From: Simon Ask Ulsnes <simon@ulsnes.dk>
To: Matt Gibson <gothick@gothick.org.uk>
Subject: Re: Complaint: Wacom driver in 2.6
Date: Tue, 30 Sep 2003 08:59:23 +0200
User-Agent: KMail/1.5.4
References: <200309291421.45692.simon@ulsnes.dk> <200309291956.27688.gothick@gothick.org.uk>
In-Reply-To: <200309291956.27688.gothick@gothick.org.uk>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309300859.23281.simon@ulsnes.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for replying.
You aren't even using the wacom driver!
Mine works too in that way (I think it is some kind of regular PS/2 mouse 
emulation or so).

Come to think of it, maybe the problem lies in the XFree86 driver, which I 
suppose isn't really compatible with the new kernel. Well, whatayaknow... ;-)

- Simon

On Monday 29 September 2003 20:56, you wrote:
> On Monday 29 Sep 2003 13:21, Simon Ask Ulsnes wrote:
> > Hello there!
> > I am the lucky owner of a Wacom Graphire 2 tablet, which works great with
> > the latest 2.4-kernels. However, the 2.6-drive is unusually and utterly
> > broken. Frankly, it doesn't work at all.
>
> If it's any hope for you, I'm using the Wacom driver with an original
> Graphire, and it's working OK for me.  I'm currently on 2.6.0-test5, and
> I'm pretty sure I'm using the vanilla wacom.c (it's version 1.30 according
> to the comments.)
>
> If you want any info about how I've got things configured, feel free to
> give me a shout.  In particular, I've got these relevant entries in my
> XF86Config:
>
> # Our ordinary PS/2 and Wacom mice; they're both multiplexed into
> # /dev/mice by the kernel input event handling.
> Section "InputDevice"
>   Driver       "mouse"
>   Identifier   "Mouse[1]"
>   Option       "ButtonNumber" "5"
>   Option       "Device" "/dev/input/mice"
>   Option       "Name" "Autodetection"
>   Option       "Protocol" "imps/2"
>   Option       "Vendor" "Random"
>   Option       "ZAxisMapping" "4 5"
> EndSection
>
> Goodness knows if I need half those options set up; it's a
> much-hacked-about-with old file that was originally set up by the SuSE SaX2
> configuration tool, about three years ago!  But I tend to live by "if it
> ain't broke, don't fix it."  I guess the important thing I did to get it
> working under 2.6.0 was just to drop all the event interface crap and just
> run it off /dev/input/mice, which is where the kernel happily feeds all the
> wacom input through into.
>
> Section "ServerLayout"
> 	... other stuff deleted ...
>   InputDevice  "Mouse[1]" "CorePointer"
> EndSection
>
> That's all I needed to get the mouse and pen working.  Of course, to go the
> whole hog and get the pressure sensitive stuff and the pointer vs. eraser
> functionality etc. you'd need to use the X11 wacom driver, but I've never
> actually felt the need.
>
> Cheers,
>
> Matt


