Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313384AbSDESYm>; Fri, 5 Apr 2002 13:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313385AbSDESYc>; Fri, 5 Apr 2002 13:24:32 -0500
Received: from mailhost.mipsys.com ([62.161.177.33]:43968 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S313384AbSDESYY>; Fri, 5 Apr 2002 13:24:24 -0500
From: <benh@kernel.crashing.org>
To: Peter Horton <pdh@berserk.demon.co.uk>, <linux-kernel@vger.kernel.org>
Cc: <alan@redhat.com>
Subject: Re: [PATCH] radeonfb 2.4.19-pre2
Date: Fri, 5 Apr 2002 20:24:41 +0200
Message-Id: <20020405182441.5366@mailhost.mipsys.com>
In-Reply-To: <20020404214358.GA1811@berserk.demon.co.uk>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Spurred on by a little positive feedback, I've added more stuff to my
>patch for the ATI Radeon frame buffer driver.

Could you CC the driver maintainer ? (ajoshi@unixbox.com) and me
on further updates please ? radeonfb is an important driver on PPC
boxes and some parts of it has to be handled with care ;)

>* Reinitialise accelerator on console switch. This ensures the
>accelerator is in a known state after X exits.

Sounds fine

>* Added acceleration functions for 15/16/32 bit modes.

Good ;)

>* Removed 24 bit support. It didn't work and the X source hints that
>Radeon might not support 24 bit modes. If you ask for a 24 bit mode, the
>driver will switch to a 32 bit one.

Yah, that never worked

>* Minor fix to video mode switch code which means 'fbset' now works
>correctly. This also means the 'UseFBDev' option in X works. Commented out
>a hack that looks like it was a failed attempt to work around this bug
>previously.

What was wrong ? I'm not sure what you mean, we have been using fbset
and UseFBDev for ages on PPC

>* Hacked wildly at the colour support to get it to work. Removed use of
>the palette for 15/16 bit modes (I can't fathom why it was there in the
>first place). The palette is now initialised to an identity mapping for
>15/16/32 bit modes. The consoles now work fine at all colour depths, and
>the Tux logo is displayed correctly at all depths too :-)

I don't agree here ! The palette _do_ make sense in 15/16/32, in which
case it's called gamma table. Don't break that, some apps do use it
(like MacOnLinux).

>* Added an untested fix for acceleration on flat panels. "Stuffed Crust"
>reported garbled display when acceleration was enabled, this might fix it.

I'll give it a try and let you know.

>* Other minor cleanups.

Can't harm ;)

Ben.


