Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287676AbSAXM34>; Thu, 24 Jan 2002 07:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287684AbSAXM3r>; Thu, 24 Jan 2002 07:29:47 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:51726 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S287676AbSAXM31>; Thu, 24 Jan 2002 07:29:27 -0500
Date: Thu, 24 Jan 2002 13:29:19 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: Pavel Machek <pavel@suse.cz>, Jakob ?stergaard <jakob@unthought.net>,
        Ville Herva <vherva@twilight.cs.hut.fi>, linux-kernel@vger.kernel.org
Subject: force umount [was Re: [STATUS 2.5]  January 18, 2002]
Message-ID: <20020124122919.GA2135@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020123113122.GC965@elf.ucw.cz> <Pine.GSO.4.21.0201231751470.19120-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0201231751470.19120-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Can I kill the processes accessing busy
> > filesystems? [That was big point of force umount, I believe.]
> 
> Huh?  If process is killable - it's killable.  What does it have to
> --force?

Following situation used to be common and "not a bug":

process a tries to read /nfs/foo, but nfs server dies.

kill -9 a does not kill a.

It used to be "not a bug" before. Can we declare it a bug after umount
/nfs --force?
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
