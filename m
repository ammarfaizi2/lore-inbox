Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273748AbRI0R4P>; Thu, 27 Sep 2001 13:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273749AbRI0R4G>; Thu, 27 Sep 2001 13:56:06 -0400
Received: from www.transvirtual.com ([206.14.214.140]:6160 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S273748AbRI0Rzv>; Thu, 27 Sep 2001 13:55:51 -0400
Date: Thu, 27 Sep 2001 10:56:07 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Jason McMullan <jmcmullan@linuxcare.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Why is Device3Dfx driver (voodoo1/2) not in the kernel?
In-Reply-To: <20010927115710.A23248@jmcmullan.evillabs.net>
Message-ID: <Pine.LNX.4.10.10109271040150.20787-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 	Mode changing - Now there I can get into an argument. I
> still (after all these years) feel that the Kernel is the best
> place to put video mode control. That way 'killall -9 X' isn't
> nearly as nasty... The kernel could at least get you back to
> a text console.

Can we say framebuffer devices. As graphics cards are placed into more 
and more different types of systems we need to have a way to make these
cards workable on different platforms. This requires us to write
drivers that can initialize a mode without firmware. I have reworked the
console layer to deal with this and with allowing different modes on
different VCs. The current system allows it too but it is more of a later
add on hack. I have a much cleaner implementation which does what you ask 
of the above.         
 
> 	And now that XFree86 4 has a vm86 system to 'run the
> Video BIOS' for certain cards, it shouldn't be to hard to 
> emulate the old OS/2 system - in a vm86 session, use the BIOS
> to switch to all the supported modes, and record (via vm86
> io traps) everything the BIOS does. Then, in the driver,
> just 'play back' the scripts... Worked beatifully for OS/2
> back in the day for 2D framebuffers...

Really. I have my own personal compain to make all the graphics drivers
firmware independent. I even like to see the VGA console driver also
firmware independent.

