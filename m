Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266932AbRGMUhI>; Fri, 13 Jul 2001 16:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267009AbRGMUg6>; Fri, 13 Jul 2001 16:36:58 -0400
Received: from [194.213.32.142] ([194.213.32.142]:11012 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S266932AbRGMUgk>;
	Fri, 13 Jul 2001 16:36:40 -0400
Message-ID: <20010713012105.B122@bug.ucw.cz>
Date: Fri, 13 Jul 2001 01:21:05 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>, root@mauve.demon.co.uk,
        linux-kernel@vger.kernel.org
Subject: swsusp [was Re: Switching Kernels without Rebooting?]
In-Reply-To: <200107121211.NAA10270@mauve.demon.co.uk> <200107121254.HAA89768@tomcat.admin.navo.hpc.mil> <20010712101513.A439@alcove.wittsend.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010712101513.A439@alcove.wittsend.com>; from Michael H. Warfield on Thu, Jul 12, 2001 at 10:15:13AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > That sounds more like a memory dump to disk, and reload after power restored.
> > Either that or possibly a separate power supply for RAM (something like a
> > trickle discharge capacitor; I've read that some capacitors can hold a charge
> > for about 3 days. Whether that would work for a large RAM or not, I have no
> > idea).
> 
> 	It's a suspend to disk.  Lots of Laptops can do it and my Toshiba
> Tecra 8100 can do it from the BIOS if I have a magic Windows partition with
> an appropriate suspend file in it (which would be unencrypted, which would
> be unacceptable - so I had to look for a Linux solution for the suspend
> to disk problem).
> 
> 	Check out the swsusp project up at Source Forge
> <http://sourceforge.net/projects/swsusp/>.  It allows me to suspend
> into the swap space by hitting Alt-SysRQ-D.  Great for changing
> batteries on laptops (and, no, normal suspend does not survive a battery
> change) but also REALLY GREAT for forensic security analysis of compromised
> systems.  I hit the console of a compromised system and hit Alt-SysRq-D
> and it flushs the dirty buffers, dumps memory to swap (preserving all
> my "volatiles") and the shuts down.  I can snapshot the hard drive and
> then restart the system where it left off for live running analysis.  If
> that gets screwed up, I can restore the image again and restart again from
> the same spot again.  I've also got all the memory and CPU state in that
> disk image for "in-vitro" analysis by tools like Weitse's "The Coroner's
> Toolkit".
> 
> 	But that doesn't solve ANY of the problems with changing the kernel
> itself.  Suspending and restoring the system is the easy part (and swsusp
> still has some problems restoring X Windows).  Restoring a system to
> a different kernel is orders of magnitude worse, if not down right
> impossible for all the reasons given over internal structures and
> interfaces.
> 
> 	I would LOVE to have something like swsusp in the main line kernel,
> however, just so I didn't have to convince IT departments to apply this
> custom kernel patch to their production systems BEFORE they get their butts
> kicked by some snott nosed script kiddie.  :-/

Patience. swsusp is needed for ACPI S4 support. And I guess ACPI S4 is
good enough reason to push it to Linus.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
