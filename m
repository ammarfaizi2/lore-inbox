Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272824AbRIGSwq>; Fri, 7 Sep 2001 14:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272823AbRIGSwg>; Fri, 7 Sep 2001 14:52:36 -0400
Received: from duba06h06-0.dplanet.ch ([212.35.36.67]:30984 "EHLO
	duba06h06-0.dplanet.ch") by vger.kernel.org with ESMTP
	id <S272824AbRIGSwV>; Fri, 7 Sep 2001 14:52:21 -0400
Message-ID: <3B993207.787B0D5@dplanet.ch>
Date: Fri, 07 Sep 2001 22:45:59 +0200
From: "Giacomo A. Catenazzi" <cate@dplanet.ch>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: OOPS[devfs]: reproducible in vfs_follow_link 2.4.9,2.4.10-pre4
In-Reply-To: <3B97744E.7020007@dplanet.ch>
		<Pine.GSO.4.21.0109061454480.7097-100000@weyl.math.psu.edu> <200109061941.f86Jfak01921@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> 
> Alexander Viro writes:
> >
> >
> > On Thu, 6 Sep 2001, Giacomo Catenazzi wrote:
> >
> > > Hello.
> > >
> > > Since yesterdey, every time I run a 2.4.9 or 2.4.10pre-4 without the
> > > "devfs=nomount" I
> > > have two oops + /usr, /home /boot not mounted (all (also /): ext2).
> >
> >       Don't use devfs. One of the known bugs - devfs passes a string
> > to vfs_follow_link() and doesn't care to preserve it until
> > vfs_follow_link() is done.
> 

> 
> If people could test the latest devfs patch, that would be really
> helpful. Linus isn't applying it because he's concerned that the many
> SD support may break something. Even if you don't have many SD's,
> please apply the patch and send a message to the list (and Cc: me)
> stating whether or not your system still works.
> 

No, your patch  didn't work.
I have still the oops.

I investigates, and the oops come in the mountall script (in init.d),
when running: mount -avt nonfs,nosmbfs.
(I noticed thet at this point kernel load floppy modules, but when I
removed also the floppy module, the oops reappers.)

Note: only the first time I run the script  the kernel oops, thus
on normal boot sequence debian would not mount my partitions :-(.

	giacomo
