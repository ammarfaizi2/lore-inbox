Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263073AbTCLHUW>; Wed, 12 Mar 2003 02:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263075AbTCLHUW>; Wed, 12 Mar 2003 02:20:22 -0500
Received: from 101.24.177.216.inaddr.g4.Net ([216.177.24.101]:59777 "EHLO
	sparrow.stearns.org") by vger.kernel.org with ESMTP
	id <S263073AbTCLHUV>; Wed, 12 Mar 2003 02:20:21 -0500
Date: Wed, 12 Mar 2003 02:30:53 -0500 (EST)
From: William Stearns <wstearns@pobox.com>
X-X-Sender: wstearns@sparrow
Reply-To: William Stearns <wstearns@pobox.com>
To: "M. Soltysiak" <msoltysiak@hotmail.com>
cc: ML-linux-kernel <linux-kernel@vger.kernel.org>,
       William Stearns <wstearns@pobox.com>
Subject: Re: Linux BUG: Memory Leak
In-Reply-To: <F44Bre5NuYqYYDleNlx00025ecc@hotmail.com>
Message-ID: <Pine.LNX.4.44.0303120213370.3104-100000@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day, Matt,

On Wed, 12 Mar 2003, M. Soltysiak wrote:

> I sent this here because i don't know which author screwed up.

	Please don't start the post with a negative tone; focus on a 
problem in software rather than on insulting the people from whom you want 
help.
	Please take a look at /usr/src/linux/REPORTING-BUGS.  At an
absolute minimum, the people on this list can't do anything at all until
you tell us what kernel version you're using, what modules are loaded,
etc. - all things that that file is designed to uncover.  You might also
want to mention what Linux distribution you're using.  Did you compile the
kernel yourself, or are you using a vendor-supplied kernel?  If it's from
your vendor, have you updated it to the most current for your
distribution?  If you compiled it yourself, what compile options did you
use?  Did you apply any patches to the source?

> Basically, it's a massive kernel memory leak or a VM problem.
> 
> System specs:
> 1 GBytes RAM
> duel CPU system; 1 Ghz each.
> IDE disk system, 133 Mhz bus speed, DMA.
> USB mouse.
> PS/2 Keyboard.
> Creative Labs emu10k1-based sound card.  (LIVE!)
> Asus Motherboard.

	Does the system pass a night's worth of memtest86 successfully?  
If we can rule out hardware, that narrows the problem space down some.

> Problem:
> 
> When I boot the system, run X11 with KDE--totalling 100 M at most--things 
> are fine.
> 
> When I run applications that use quite a bit of memory -- those that use 500 
> Megs of RAM -- Linux keeps on allocating memory until it's full.  When full, 
> system acts dead, as expected from the bad VM design.  But why does the 

	Again, it sounds like you're taking an insulting tone.  :-)

> system allocate memory until the RAM is full?  User applications are NOT 
> leaking memory.

	"Acts dead" - what does that mean?  Sluggish?  Pauses for a few 
seconds, then returns to normal?  Swapping madly?  For how long?  Hard 
lockup, no keys do anything?  Does the caps lock key change the state of 
the caps lock led?  Do the caps/scroll/numlock lights flash on and off 
without keypresses?  Does anything show up in the logs on next boot?  Can 
you kill X11 with Ctrl-Alt-Backspace?  Can you reboot the box with 
Ctrl-Alt-Del?  Does Sysrq-S force disk activity?  Can you ssh in from 
another box when it "acts dead"?

> Example: Installing Unreal Tournament 2003 -- from the CD drive, IDE -- for 
> example, playing mp3 files and browsing the web with Mozilla, and the system 
> will eventually allocate memory until the system freezes.  All of RAM is 
> allocated, and the system is frozen.

	What are the last few lines from "vmstat 1" when the system 
freezes?  Does top show any memory amounts=0?  What does top claim is the 
biggest memory user, both in the header area and down in application 
space?
	Can you make the problem occur with fewer programs, say, just with 
Mozilla, or just with Unreal?  How long does it take for the problem to 
show up?  Minutes, hours, days?

> Possible problem: VM algorithm is not too good, and should take a lesson to 
> BSD; or the kernel is leaking memory -- unknown location.  I'll look into 
> the problem in a few weeks when i'm free; but now, i got work.
> 
> I'm sure many people are getting this problem...

	As I mentioned above... ;-)

> I can fix the problem, but i got engineering projects to worry about.

	If you'd prefer, feel free.  You do remember that the people from 
whom you're asking help have day jobs too, right?  *grin*
	http://www.stearns.org/doc/howtoask.current.html
	Cheers,
	- Bill

---------------------------------------------------------------------------
	"A raccoon tangled with a 23,000 volt line today.  The results
blacked out 1400 homes and, of course, one raccoon."
	-- Steel City News
(Courtesy of G.W. Wettstein <greg@wind.enjellic.com>)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
Linux articles at:                         http://www.opensourcedigest.com
--------------------------------------------------------------------------

