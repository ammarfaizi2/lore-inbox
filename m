Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318231AbSHSJEm>; Mon, 19 Aug 2002 05:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318240AbSHSJEm>; Mon, 19 Aug 2002 05:04:42 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:36622 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S318231AbSHSJEl>; Mon, 19 Aug 2002 05:04:41 -0400
Message-ID: <3D60B628.CC5BB5E3@aitel.hist.no>
Date: Mon, 19 Aug 2002 11:11:04 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.31 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Scott Bronson <bronson@rinspin.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE?  IDE-TNG driver
References: <Pine.LNX.4.44.0208172353330.3111-100000@sharra.ivimey.org> <1029630519.1541.11.camel@emma>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott Bronson wrote:
> 
> On Sat, 2002-08-17 at 15:57, Ruth Ivimey-Cook wrote:
> >  a) some people want basically module-less kernels
> 
> Everyone I've heard advocating a moduleless kernel uses an argument that
> boils down to "it's slightly more secure."  Does anybody have a GOOD
> reason for not using modules?  

1. "No need".  Doesn't apply to everybody of course, but
   many have enough memory and don't plug in much new stuff.
   Recompiling & booting for the rare occation where you
   bought a new usb device is ok.  

2. A simpler setup.  No /etc/modules.conf to worry about.
   Compiling ALSA into the kernel surely made life easier.
   even more so when also using devfs...

3. Performance.  Compiled-in stuff is always there, and
   on x86 it exists in the kernel's 4M page so no
   TLB loading overhead either.

> Someone replied off-list saying that initrds are too hard to create.
Actually, that isn't an argument for linking everything in.
All you need is the drivers for your root fs and root device.
The rest may still be modular, loaded from /lib/modules on
that root fs.


Helge Hafting
