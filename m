Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144068AbRA1T4w>; Sun, 28 Jan 2001 14:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143978AbRA1T4n>; Sun, 28 Jan 2001 14:56:43 -0500
Received: from [205.240.230.3] ([205.240.230.3]:28228 "EHLO
	Stimpy.netroedge.com") by vger.kernel.org with ESMTP
	id <S143901AbRA1T4N>; Sun, 28 Jan 2001 14:56:13 -0500
Date: Sun, 28 Jan 2001 11:56:55 -0800
From: phil@stimpy.netroedge.com
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, tmolina@home.com,
        sensors@stimpy.netroedge.com
Subject: Re: time in the future during make for 2.4.0
Message-ID: <20010128115655.C4234@Stimpy.netroedge.com>
In-Reply-To: <200101281949.UAA11123@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <200101281949.UAA11123@harpo.it.uu.se>; from mikpe@csd.uu.se on Sun, Jan 28, 2001 at 08:49:38PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I had this problem when I was upgrading my kernel, and happened to do
it during the daylight savings time roll-back.  Confused the heck out
of me for a while.  Anyways, you can try 'touching' all your files,
and do a 'make clean' then try again.  If it doesn't complain about a
long arg list, you can try 'touch `find . -type f`'.


Phil

On Sun, Jan 28, 2001 at 08:49:38PM +0100, Mikael Pettersson wrote:
> On Sun, 28 Jan 2001 12:27:46 -0600 (CST), Thomas Molina wrote:
> 
> >I seem to recall a discussion on faster processors causing timing
> >problems during a kernel make, but I'm unable to find it in the kernel
> >archives.  I've now upgraded to an Athlon 900 MHz processor and an ASUS
> >A7V motherboard and have started seeing this.  It shows up as the
> >following messages during a make bzImage:
> >
> >make[3]: *** Warning:  Clock skew detected.  Your build may be
> >incomplete.
> >make[3]: *** Warning: File
> >`/mnt/hd/local/kernel/linux.24.new/include/linux/sched.h' has
> >modification time in the future (2001-01-28 17:41:05 > 2001-01-28
> >10:07:02)
> 
> No, this doesn't look like the "fast CPU" problem you are alluding to
> (look for subject MODVERSIONS in the archives). We fixed that one.
> 
> Your problem is that your kernel source dir (unpacked tarball?)
> contains files with time stamps several hours in the future;
> 'make' doesn't take kindly to this.
> 
> I've seen this happen once: during an upgrade (RH-style, i.e. not
> fresh install) from RH6.2 to RH7.0, my /etc/localtime had become
> overwritten and my machine in an instant moved from CET to some US
> time zone 6 or 8 hrs back. Then when I unpacked my kernel tarball to
> build a real kernel, I got exactly the problems you listed above.
> 
> Check your clock & time zone settings.
> 
> /Mikael

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
