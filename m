Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbTKITFy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 14:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbTKITFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 14:05:54 -0500
Received: from witte.sonytel.be ([80.88.33.193]:33516 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262774AbTKITFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 14:05:45 -0500
Date: Sun, 9 Nov 2003 20:05:26 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Bob McElrath <bob+linux-kernel@mcelrath.org>
cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: /dev/rtc on alpha
In-Reply-To: <20031109174436.GA24812@mcelrath.org>
Message-ID: <Pine.GSO.4.21.0311092004590.2000-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Nov 2003, Bob McElrath wrote:
> Ivan Kokshaysky [ink@jurassic.park.msu.ru] wrote:
> > On Sat, Nov 08, 2003 at 01:33:57PM -0800, Bob McElrath wrote:
> > > Why is the alpha kernel code grabbing the rtc interrupt?  Is it possible
> > > it share its use with a user program?  Would reprogramming the interrupt
> > > rate by a user program do violence to some internel kernel timing?
> > 
> > On most Alphas RTC is the system timer (running at 1024 Hz).
> > So changing the interrupt rate from user space wouldn't be a good idea.
> 
> Then I propose CONFIG_RTC be set to "n" in the arch/alpha files, and the
> /dev/rtc driver be disabled on alpha.  There seems to be confusion on
> this point in the config files.  CONFIG_RTC is for the /dev/rtc driver.

As an alternative, you can try using genrtc instead.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

