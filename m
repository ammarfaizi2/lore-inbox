Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129552AbQLAU1v>; Fri, 1 Dec 2000 15:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130247AbQLAU1m>; Fri, 1 Dec 2000 15:27:42 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:34313 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129552AbQLAU11>; Fri, 1 Dec 2000 15:27:27 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Florian Heinz <sky@sysv.de>
Date: Sat, 2 Dec 2000 06:56:43 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14888.635.655989.944747@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: Some problems with the raid-stuff in 2.4.0-test12pre3
In-Reply-To: message from Florian Heinz on Friday December 1
In-Reply-To: <20001130123322.A672@inode.real-linux.de>
	<14887.2273.174231.960990@notabene.cse.unsw.edu.au>
	<20001201105233.D672@inode.real-linux.de>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday December 1, sky@sysv.de wrote:
> On Fri, Dec 01, 2000 at 01:11:45PM +1100, Neil Brown wrote:
> > On Thursday November 30, sky@dereference.de wrote:
> > > Hello people,
> > > 
> > > I have some trouble with the raid-stuff.
...
> > 
> > Is it just "very slow", but it eventually finishes, it is it so slow,
> > that it actually stops and doesn't make any progress at all?
> > 
> > raid5 in 2.4 is definately slower than in 2.2.  Could that be all that
> > you are seeing?
> 
> It's so slow that it's unusable. Especially writing. open() and
> close()-calls often hang for 20 seconds or more.
> write-calls hang for 3-4 seconds. This has to be a bug.
> But yes, after a long time, it finishes ;)

Well, that does sound slower than I would expect....

1/ Could you try:

   http://cgi.cse.unsw.edu.au/~neilb/patches/linux/2.4.0-test12-pre3/patch-E-raid5

   and tell me how much that helps.


2/ Try a larger chunk size.  My testing suggests 64K is a good
   starting point.

NeilBrown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
