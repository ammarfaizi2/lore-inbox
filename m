Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273440AbRI0P7q>; Thu, 27 Sep 2001 11:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273622AbRI0P70>; Thu, 27 Sep 2001 11:59:26 -0400
Received: from [141.158.127.119] ([141.158.127.119]:27123 "HELO jmcmullan")
	by vger.kernel.org with SMTP id <S273440AbRI0P7P>;
	Thu, 27 Sep 2001 11:59:15 -0400
Date: Thu, 27 Sep 2001 11:57:10 -0400
From: Jason McMullan <jmcmullan@linuxcare.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jason McMullan <jmcmullan@linuxcare.com>, linux-kernel@vger.kernel.org
Subject: Re: Why is Device3Dfx driver (voodoo1/2) not in the kernel?
Message-ID: <20010927115710.A23248@jmcmullan.evillabs.net>
In-Reply-To: <9ou9u4$ee6$1@localhost.localdomain> <E15mZqU-0003kx-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <E15mZqU-0003kx-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Sep 27, 2001 at 01:00:50PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2001 at 01:00:50PM +0100, Alan Cox wrote:
> There are actually distinct similarities between some DRI drivers and what
> Linus suggested the KGI people needed to be doing. Certain hardware isnt 
> totally user safe (not on the extremes of the voodoo1 here) and the drivers
> do small amounts of work to stop abuse. All mode changes, rendering
> primitives and the like are however in userspace.

	Rendering - definitely agree. Userspace.

	Mode changing - Now there I can get into an argument. I
still (after all these years) feel that the Kernel is the best
place to put video mode control. That way 'killall -9 X' isn't
nearly as nasty... The kernel could at least get you back to
a text console.

	And now that XFree86 4 has a vm86 system to 'run the
Video BIOS' for certain cards, it shouldn't be to hard to 
emulate the old OS/2 system - in a vm86 session, use the BIOS
to switch to all the supported modes, and record (via vm86
io traps) everything the BIOS does. Then, in the driver,
just 'play back' the scripts... Worked beatifully for OS/2
back in the day for 2D framebuffers...

	Anyway, I'll just let sleeping dogs lie and leave it
at that.

> I firmly believe you can do X11 with 3D in windows, including partial 
> occlusion of 3d windows on a 3dfx voodoo1 or voodoo2 card. 

	As do I, but I lack three things: The time, The Specs, and
The Hardware. :(

-- 
Jason McMullan, Senior Linux Consultant
Linuxcare, Inc. 412.432.6457 tel, 412.656.3519 cell
jmcmullan@linuxcare.com, http://www.linuxcare.com/
Linuxcare. Putting open source to work.
