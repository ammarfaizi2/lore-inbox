Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262955AbRE1Dug>; Sun, 27 May 2001 23:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262954AbRE1Du0>; Sun, 27 May 2001 23:50:26 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:37881 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S262955AbRE1DuQ>; Sun, 27 May 2001 23:50:16 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105280349.f4S3nrff021434@webber.adilger.int>
Subject: Re: Console display in portrait mode with unusual dpi resolution
In-Reply-To: <3B1150DB.ADF2178A@bluewin.ch> "from Otto Wyss at May 27, 2001 09:09:16
 pm"
To: otto.wyss@bluewin.ch
Date: Sun, 27 May 2001 21:49:53 -0600 (MDT)
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

O Wyss writes:
> [Running flatscreen in portrait mode]
>
> The portrait mode software starts working just about before the logon
> screen is shown. All the BIOS and system messages are shown in landscape
> mode. From the nature of a software solution I guess this can't be
> changed neither of Windows NT4 nor Linux.

Probably the place to hack this is in the framebuffer console code.  This
will not help with BIOS messages, but you _should_ be able to get all
Linux output in the portrait rotated mode with the FB console.

> 3. Obstacle
> The EIZO L675 has a pixel pitch of 0.28x0.28 which is equivalent to
> about 90dpi. Since Windows (any version) uses a default value on 96dpi,
> everything is enlarged by about 5%. So even with an 18" display an A4
> page can't be normally viewed in Word. Current status from Microsoft
> "problem is recognized, we are working on it". While there is no
> solution for Windows (probably until SP1 for XP) what's the status of
> Linux? 

X does not have a standard DPI, so it doesn't really matter.  On CRT
screens, you could adjust your DPI via XFree86 modelines.  On LCD
screens DPI is fixed so you have to work with that.  If the screen
supports DDC (it should if it is new), it will tell the X server what
the DPI is, so you don't need to set it manually.  Running "xdpyinfo"
under X will tell you what the resolution is (my current screen happens
to report 109x112 DPI = 1600x1200 on a 19" screen).  I think GIMP can
work with the DPI info reported from the X server.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
