Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285612AbRLRGUb>; Tue, 18 Dec 2001 01:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285617AbRLRGUV>; Tue, 18 Dec 2001 01:20:21 -0500
Received: from adsl-63-207-97-74.dsl.snfc21.pacbell.net ([63.207.97.74]:11250
	"EHLO nova.botz.org") by vger.kernel.org with ESMTP
	id <S285612AbRLRGUJ> convert rfc822-to-8bit; Tue, 18 Dec 2001 01:20:09 -0500
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4
To: Ross Vandegrift <ross@willow.seitz.com>
cc: Diego Calleja <grundig@teleline.es>, linux-kernel@vger.kernel.org,
        Jurgen Botz <jurgen@botz.org>
Subject: Re: Reiserfs corruption on 2.4.17-rc1! 
In-Reply-To: Message from Ross Vandegrift <ross@willow.seitz.com> 
   of "Tue, 18 Dec 2001 00:01:45 EST." <20011218000145.A15150@willow.seitz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Mon, 17 Dec 2001 22:19:28 -0800
Message-ID: <19261.1008656368@nova.botz.org>
From: Jurgen Botz <jurgen@botz.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Vandegrift wrote:
> > This is my opinion:
> > 	-Something (reiserfs, anything) has caused fs corruption
> > 	-It should be repaired by reiserfsck, but it's broken :-((
> > 	-This corruption should NOT have happened, reiserfsck shouldn't
> > have to be used.
> > 	-I'm not a kernel hacker, so I can't try anything...what I know is
> > that
> > 		/etc in hc5 doesn't work. /usr, /var....works correctly.
> > 
> > Well, I'd like to know what's happened in my drive. Can somebody try to
> > give an explanation?
> 
> I've seen this happen when being careless about partitioning my drive.  If
> you changed your partition table and created the filesystem without a reboot
> you could be in for this problem.  If fdisk was unable to update the
> partition table after writing it out and you ran mkreiserfs, you just made a
> filesystem on the *old* partition, according to the *old* partition table.
> Upon rebooting, the disk will be synced to the new partition table.  If you
> happened to shrink the parition a bit, the filsystem is suddenly longer than
> the partition.

But that doesn't account for badblocks trying to read past the end of the
device (which Diego reported in his previous post) unlesss... unless that
was still the same session (boot) during which he changed partitions...
Diego?

:j


-- 
Jürgen Botz                       | While differing widely in the various
jurgen@botz.org                   | little bits we know, in our infinite
                                  | ignorance we are all equal. -Karl Popper


