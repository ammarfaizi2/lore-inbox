Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310637AbSDMUpL>; Sat, 13 Apr 2002 16:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310654AbSDMUpK>; Sat, 13 Apr 2002 16:45:10 -0400
Received: from acolyte.thorsen.se ([193.14.93.247]:33798 "HELO
	acolyte.hack.org") by vger.kernel.org with SMTP id <S310637AbSDMUpK>;
	Sat, 13 Apr 2002 16:45:10 -0400
From: Christer Weinigel <wingel@acolyte.hack.org>
To: jfbeam@bluetronic.net
Cc: zwane@linux.realnet.co.sz, pwaechtler@loewe-komp.de,
        alan@lxorguk.ukuu.org.uk, pierre.ficheux@openwide.fr,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.33.0204111246400.29312-100000@sweetums.bluetronic.net>
	(message from Ricky Beam on Thu, 11 Apr 2002 12:51:29 -0400 (EDT))
Subject: Re: 2.4.18 AND Geode GX1/200Mhz problem
Message-Id: <20020413204504.6B104F5B@acolyte.hack.org>
Date: Sat, 13 Apr 2002 22:45:04 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ricky Beam <jfbeam@bluetronic.net> wrote:
> On a side note, has anyone seen dd scrolling behavior with video chipse
> using shared memory?  On the geode board I'm playing with, the screen
> never scrolls correctly.  It's probablly something stupid in the 5530's
> setup that's at fault. (I have ever intention of turning the VGA port
> off entirely.)

The VSA CGA/EGA/VGA text emulation seems to be rather awful and has
lots of bugs.  Compile in the VESA framebuffer support in your Linux
kernel and add vga=785 (see linux/Documentation/fb/vesafb.txt) to
your kernel command line.  It's a choice of:

    Linux kernel frobs the text console -> buggy VSA emulation -> framebuffer

or

    Linux kernel frobs the framebuffer directly

Guess which works better?  *grin*

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"
