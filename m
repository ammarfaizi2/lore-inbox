Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318047AbSIONuB>; Sun, 15 Sep 2002 09:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318058AbSIONuB>; Sun, 15 Sep 2002 09:50:01 -0400
Received: from users.linvision.com ([62.58.92.114]:11899 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S318047AbSIONuA>; Sun, 15 Sep 2002 09:50:00 -0400
Date: Sun, 15 Sep 2002 15:54:08 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Brownell <david-b@pacbell.net>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
Message-ID: <20020915155408.C11949@bitwizard.nl>
References: <1031683480.31787.107.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0209101156510.7106-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209101156510.7106-100000@home.transmeta.com>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2002 at 12:03:00PM -0700, Linus Torvalds wrote:
> In other words, if a user is faced with a dead machine with no other way
> to even know what BUG() triggered than to try to set up a cross debugger,
> just how useful is that BUG()? I claim it is pretty useless - simply
> because 99+% of all people won't even make a bug report in that case,
> they'll just push the reset button and consider Linux unreliable.


I just had an idea: There are the periodic discussions about 
dumping the oops-report somewhere where you can log it on the next 
boot, right?

Disk drivers may be unreliable etc etc. 

Main memory is probably cleared on boot, right? (would have been too
obvious). 

I'm pretty sure that my system has 16M of non-cleared memory: The
video RAM. The state of my screen  before the crash always shows up 
while X is starting.... (I was running a foolishly old 2.4.3-ac3 until
a couple of weeks ago)

Is my system special in that it doesn't clear video RAM? Can we 
grab a pointer to video memory when we boot, check a magic 
value, if OK, print the oops report from last crash, put in a new
magic value ("No oops report"), and when we crash write in the 
crash report with the special magic value? 



			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currenly in such an       * 
* excursion: The stable situation does not include humans. ***************
