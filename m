Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263673AbRFGXYJ>; Thu, 7 Jun 2001 19:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263675AbRFGXYA>; Thu, 7 Jun 2001 19:24:00 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:24337 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S262076AbRFGXXw>; Thu, 7 Jun 2001 19:23:52 -0400
Date: Thu, 7 Jun 2001 18:48:17 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Paul Buder <paulb@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Large ramdisk crashes system
In-Reply-To: <Pine.LNX.4.33.0106071607180.3940-100000@shell1.aracnet.com>
Message-ID: <Pine.LNX.4.21.0106071847040.1156-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Jun 2001, Paul Buder wrote:

> I am trying to create a system which boots off of a cd and has no hard
> disks.  So it needs ramdisks.  But I haven't had much luck creating
> large ones.
> 
> I tried on two different boxes.  In both cases the kernel is 2.4.5 with
> 'Simple RAM-based file system support' turned on.
> 
> One box is a dual Pentium 750 with a gig of ram in it.  I had the
> kernel 'Default RAM disk size' set to 800000 for this box.  I issued
> the following commands.
> 
> mkfs /dev/ram0 400000
> mount /dev/ram0 /mnt
> dd if=/dev/zero of=/mnt/junk bs=1024 count=500000
> 
> This is fine, dd creates a 400 meg file, reports there isn't enough
> space and exits.  But if I change the first line to
> 
> mkfs /dev/ram0 500000
> 
> I'm essentially crashed.  I can ping the box and switch between virtual
> terminals but that's it.  Any program that was running on the other
> virtual terminals is frozen (as in top, tail, login).  The dd is frozen
> and can't be control-c'd.  so I can't do anything other than powercycle.
> I should have at least 400 megs of ram left for the system so I don't
> get it.
> 
> I tried the same thing on a 128 meg box.  The results were similar.  A 40
> meg ram disk worked.  A 60 meg ram disk crashed the box.  The numbers
> seem a little odd since in both cases the magic threshold seems to be
> roughly 40% of ram.
> 
> I get no messages in the system logfiles nor an oops on the screen.
> 
> Any ideas?

Can you get the (traced by ksymoops) backtrace of dd and kswapd
everything is locked? 

You can do that with sysrq. 

