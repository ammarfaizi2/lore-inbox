Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262184AbSKCQ4C>; Sun, 3 Nov 2002 11:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262190AbSKCQ4C>; Sun, 3 Nov 2002 11:56:02 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:40857 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S262184AbSKCQ4B>;
	Sun, 3 Nov 2002 11:56:01 -0500
Date: Sun, 3 Nov 2002 09:56:12 -0700
From: yodaiken@fsmlabs.com
To: Alexander Viro <viro@math.psu.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, davej@suse.de
Subject: Re: Filesystem Capabilities in 2.6?
Message-ID: <20021103095612.A436@hq.fsmlabs.com>
References: <1036342259.29642.51.camel@irongate.swansea.linux.org.uk> <Pine.GSO.4.21.0211031151590.28485-100000@steklov.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0211031151590.28485-100000@steklov.math.psu.edu>; from viro@math.psu.edu on Sun, Nov 03, 2002 at 11:56:22AM -0500
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2002 at 11:56:22AM -0500, Alexander Viro wrote:
> 
> 
> On 3 Nov 2002, Alan Cox wrote:
> 
> > On Sun, 2002-11-03 at 14:51, Alexander Viro wrote:
> > > No messing with chroot needed - just a way to irrevertibly turn off the
> > > ability (for anybody) to do mounts/umounts in a given namespace and ability
> > > to clone that namespace.  Then give them ramfs for root and bind whatever
> > > you need in there.  No breaking out of that, since there is nothing below
> > > their root where they could break out to...
> > 
> > mkdir foo
> > chroot foo
> > cd ../../../..
> > chroot .
> 
> ... will give him nothing, since he is not in chroot jail to start with.
> He has a namespace of his own with his own root filesystem.  Which has
> several empty directories and nothing else - everything else is bound on
> these.  He is at his absolute root and can't break out of it - there is
> nowhere to break out.  So his /foo will be a subdirectory of root of his
> root filesystem.  OK, he chroots there.  His cwd is still at absolute root
> and he can follow .. until he's blue in the face - he will stay where he
> started.

Plan 9 !


-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
www.fsmlabs.com  www.rtlinux.com
1+ 505 838 9109

