Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbVGRUj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbVGRUj5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 16:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbVGRUj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 16:39:57 -0400
Received: from imap.gmx.net ([213.165.64.20]:60631 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261867AbVGRUj4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 16:39:56 -0400
X-Authenticated: #20559227
Date: Mon, 18 Jul 2005 22:39:05 +0200
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: debian-powerpc@lists.debian.org, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: [shorty: Re: 2.6.12 debian powerpc kernels and ppc64 ...]
Message-ID: <20050718203905.GC2949@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spoken-Languages: en, de
X-URL: http://www.wolfgangpfeiffer.com
User-Agent: Mutt/1.5.9i
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The first try to send the message below didn't work. Hoping it does
now ... :)

Regards
Wolfgang

----- Forwarded message from Wolfgang Pfeiifer -----

To: Sven Luther <sven.luther@wanadoo.fr>
Cc: debian-powerpc@lists.debian.org, debian-kernel@lists.debian.org,
	linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 debian powerpc kernels and ppc64 ...
Date: Mon, 18 Jul 2005 22:17:37 +0200
User-Agent: Mutt/1.5.9i
X-URL: http://www.wolfgangpfeiffer.com

On Mon, Jul 18, 2005 at 07:23:05AM +0200, Sven Luther wrote:
> On Sun, Jul 17, 2005 at 07:52:30PM +0200, Wolfgang Pfeiffer wrote:
> > Hi Sven
> > 
> > On Fri, Jul 15, 2005 at 11:04:17PM +0200, Sven Luther wrote:
> > > Hello,
> > > 
> > > I would like testers who want to test new powerpc kernels on ppc64 machines :
> > > 
> > > These i have uploaded here :
> > > 
> > >   http://people.debian.org/~luther/ppc64/kernel-image-2.6.12-sven_1_powerpc.deb
> > 
> > At least the latter one works here. Or at least it boots here without any probs,
> > as it seems .. :
> > 
> > $ uname -a
> > Linux debby 2.6.12-sven #1 Fri Jul 15 13:44:26 UTC 2005 ppc GNU/Linux
> > 
> > $ cat /proc/cpuinfo 
> > processor       : 0
> > cpu             : 7455, altivec supported
> > clock           : 867MHz
> > revision        : 0.2 (pvr 8001 0302)
> > bogomips        : 865.18
> > machine         : PowerBook3,5
> > motherboard     : PowerBook3,5 MacRISC2 MacRISC Power Macintosh
> > detected as     : 80 (PowerBook Titanium IV)
> > pmac flags      : 0000001b
> > L2 cache        : 256K unified
> > memory          : 768MB
> > pmac-generation : NewWorld
> 
> As was expectet, the 64bit is the one i am not sure about.
> 
> > But how come this kernel still does not have the necessary patches
> > applied to run kismet: 
> 
> Please provide a bug report with this info, 

No. Please see:
http://lkml.org/lkml/2004/8/27/303

As you can see I sent them a bug report once. It won't happen again in
the foreseeable future.

And as you also can see from the thread info on the left-hand bar of
that page nobody seemed to be interested in the problem. IIRC I could
not compile for weeks or perhaps even months a new 2.4 kernel version
because of the mentioned errors.

> i will apply as soon as i am back
> in 2 weeks, if someone from the kernel team doesn't beat me to it.

The site for the patch I used, IIRC:
<http://www.kismetwireless.net/download.shtml#orinoco2611>

wget http://www.kismetwireless.net/code/orinoco-2.6.12-rfmon-dragorn-1.diff

The md5sum for the latter that I have here is 
41fb7cec09f4de93cd2432eb1aceba92

So if yours will be different you can let me know.

And I applied the patch to 2.6.12. Or better: I probably patched a
2.6.11 (tarball) source with patch-2.6.12.bz2, and then applied the
above orinoco patch. (Uncertainty because it's already a few weeks ago
I compiled this kernel ... ) 

And just in case it might help someone else:
The following snippet might serve as an example of how to compile this
more or less wifi ready patched source [Please check for yourself in
case I made any mistakes ... :) ... ]:

------------------------
tar xzvf linux-2.6.11.tar.gz
cd linux-2.6.11/
bzip2 -cd  /path/to/patch-2.6.12.bz2 | patch -p1

[then applying the orinoco patch from above]

cp /boot/someconfig .
make oldconfig
fakeroot make-kpkg clean

time MAKEFLAGS="CC=gcc-4.0"  fakeroot make-kpkg --append-to-version=-somename --revision +anothername kernel_image

or

 time MAKEFLAGS="CC=gcc-4.0"  fakeroot make-kpkg --append-to-version=+orinoco-patched --revision +050703 kernel_image
------------------------

HTH

Thanks for responding, Sven ... and yes: for your work, too :)

And sorry for refusing to play nice if things run ugly ..

Best Regards
Wolfgang

-- 
Wolfgang Pfeiffer
http://profiles.yahoo.com/wolfgangpfeiffer

----- End forwarded message -----

-- 
Wolfgang Pfeiffer
http://profiles.yahoo.com/wolfgangpfeiffer
