Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131710AbRCTEXr>; Mon, 19 Mar 2001 23:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131711AbRCTEXh>; Mon, 19 Mar 2001 23:23:37 -0500
Received: from mpdr0.chicago.il.ameritech.net ([206.141.239.142]:35472 "EHLO
	mailhost.chi.ameritech.net") by vger.kernel.org with ESMTP
	id <S131710AbRCTEX1>; Mon, 19 Mar 2001 23:23:27 -0500
Message-ID: <3AB6DAFB.1E8F14DB@ameritech.net>
Date: Mon, 19 Mar 2001 22:22:19 -0600
From: watermodem <aquamodem@ameritech.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matti Aarnio <matti.aarnio@zmailer.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Jiffy question and sound.
In-Reply-To: <3AB5A53F.F8B0373B@ameritech.net> <20010319114615.E23336@mea-ext.zmailer.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio wrote:
> 
> On Mon, Mar 19, 2001 at 12:20:47AM -0600, watermodem wrote:
> > With the 2.4.0 kernel the loops_per_sec field was replaced (for i386)
> > with current_cpu_data.loops_per_jiffy.
> ...
> > #define LOOPS_PER_SEC current_cpu_data.loops_per_jiffy * 100
> 
>   The intention was to accomodate systems with faster than 2 GHz clock
>   at which the LOOPS_PER_SEC counter spins around a bit too fast..
>   ('signed long' at i386 handles 0..2G just fine, then it thinks the sign
>    got inverted..  'unsigned long' works fine until 4 GHz processors.)
> 

My sound card uses ALSA and ALSA wasn't available yet for
the new kernel.  So.. Noting that LOOPS_PER_SEC was what 
failed in the kernel I modified it and compiled.  I am
not associated in anyway with the ALSA folks just wanted
too listen to music while working away.  I have no idea
why it needs it or if it is busy-looping... (I hope not).


>   Why does the ALSA need  LOOPS_PER_SEC ?
>   Is it doing timing by busy-looping ?
> 
> > Now compiling the same  ALSA modules with 2.4.2 this problem happens
> > much quicker and you don't need any other activity.  In fact it is hard
> > to play more than half a song.  (MP3)
> > It doesn't matter if what set of music players or tools I use the
> > problem is quite visible.
> >
> > When I boot back to the original 2.2.x kernel everything is perfect.
> >
> > So I guess I have a few questions here.
> >  1)   Is a jiffy 100th of a second or is it smaller  (so my loop count
> > is starving things.) (10ms) ?
> 
>         "HZ" is the answer.  E.g. Alpha has HZ=1024, while i386 has HZ=100
>         Nearly all architectures have different values based on what some
>         other UNIX uses at given system.
> 
> >  2)   Why is it so much worse in 2.4.2 than 2.4.0?
> >  3)   Any other "gotch's" that are important to watch for when moving
> > 2.2.x drivers to 2.4.x?
> 
>         The FAQ may have some pointers to "porting drivers to 2.4" documents.
> 
> > Thanks....
> > Watermodem
> > -
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> /Matti Aarnio
