Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268971AbRG0VHV>; Fri, 27 Jul 2001 17:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268968AbRG0VHL>; Fri, 27 Jul 2001 17:07:11 -0400
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:49846 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S268971AbRG0VGz>;
	Fri, 27 Jul 2001 17:06:55 -0400
Date: Fri, 27 Jul 2001 22:46:49 +0200
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Hans Reiser <reiser@namesys.com>,
        Joshua Schmidlkofer <menion@srci.iwpsd.org>,
        kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
Message-ID: <20010727224649.B6357@fuji.laendle>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Hans Reiser <reiser@namesys.com>,
	Joshua Schmidlkofer <menion@srci.iwpsd.org>,
	kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <no.id> <E15Q9Bw-0005q5-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E15Q9Bw-0005q5-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Jul 27, 2001 at 04:06:16PM +0100
X-Operating-System: Linux version 2.4.5-pre4 (root@cerebro) (gcc version 2.95.2.1 19991024 (release)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, Jul 27, 2001 at 04:06:16PM +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > Don't use RedHat with ReiserFS, they screw things up so many ways.....
> > For instance, they compile it with the wrong options set, their boot scripts are wrong, they just
> > shovel software onto the CD.
> 
> Sorry Hans you can rant all you like but you know you are wrong on most
> of that. RH did weeks of stress testing on multiple systems up to 8Gb 8 way
> and didn't ship until we stopped seeing corruption problems with the mm/fs
> code. 

You might be well advised looking at reality (visit a few other projects)
and you'll see that redhat, indeed, has a very bad reputation. Wether it's
gimp, gtk, perl, wine, dosemu or any other project, the basic reaction is:
oh, you have gt problems under redhat? you compile it yourself and most
probably your problems will go away (gtk+ even had this message in their
install script).

> That test suite caught bugs in kernel revisions other vendors shipped
> blindly to their customers without fixing.

they might have a very good testsuite, but that means nothing: redhat
so frequently takes snapshots of undebugged alpha versions of software
(higher version numbers) that no matter of testing will suffice to ever
make this work.

the might be doing well for the kernel, but that only gets you so far.

> That is hardly shovelling software onto the CD.

Right, that's shovelling the latest alpha versions of software onto CD.

> > Actually, I am curious as to exactly how they manage to make ReiserFS boot longer than ext2.  Do
> > they run fsck or what?
> No. The only thing I can think of that might slow it is that we build with
> the reiserfs paranoia/sanity checks on.

That's a pretty dumb thing. Maybe one should have asked the develoers
before doing this (they never do). Redhat somehow manages pretty well to
show reiserfs in a bad light ;)

However, ext2 is much faster on mount time with -onocheck (instantaneous);
and for all current harddisk sizes ext2 is somewhat to much slower on
mount. And yes, the redhat init system (just like suse's or most others,
of course) is sooo slow that improving the init system will have a much
larger effect than the ext2/reiserfs differences.

(So trying to improve this in the kernel would be the wrong place to
start).

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
