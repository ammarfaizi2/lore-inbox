Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287491AbRLaMIk>; Mon, 31 Dec 2001 07:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287492AbRLaMIa>; Mon, 31 Dec 2001 07:08:30 -0500
Received: from mail.sonytel.be ([193.74.243.200]:38326 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S287491AbRLaMIV>;
	Mon, 31 Dec 2001 07:08:21 -0500
Date: Mon, 31 Dec 2001 13:07:10 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@zip.com.au>
cc: James Simmons <jsimmons@transvirtual.com>,
        Timothy Covell <timothy.covell@ashavan.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Re: Framebuffer...Why oh Why???
In-Reply-To: <3C2FD24A.19EAC82A@zip.com.au>
Message-ID: <Pine.GSO.4.21.0112311300580.1086-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Dec 2001, Andrew Morton wrote:
> James Simmons wrote:
> > Usually the problem with X11 and framebuffer is people forget they need to
> > use the UseFBDev option for XFree86. You need to tell the X server please
> > use the fbdev layer to restore the video mode. Otherwise X will try to
> > reset the card back to the VGA state.
> 
> Couldn't the X server query the kernel for this info when it starts up?

Yes, it's perfectly possible for the X server to do that.

The main problem is that the X server shouldn't touch things that are
controlled by a fbdev driver.

It's a bit weird... No one thinks about implementing SCSI or Ethernet drivers
in user space, but for graphics that's all OK. Worse, for graphics it's even
considered normal that the user space driver plays with the hardware behind the
kernel driver's back...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

