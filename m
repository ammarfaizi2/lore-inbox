Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315693AbSEZEMq>; Sun, 26 May 2002 00:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315695AbSEZEMp>; Sun, 26 May 2002 00:12:45 -0400
Received: from dsl-213-023-040-043.arcor-ip.net ([213.23.40.43]:24020 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315693AbSEZEMm>;
	Sun, 26 May 2002 00:12:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Date: Sun, 26 May 2002 06:11:12 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Robert Schwebel <robert@schwebel.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0205251025010.6515-100000@home.transmeta.com> <E17BiBY-0003nt-00@starship> <1022381475.11811.72.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17BpNE-0003qU-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 May 2002 04:51, Alan Cox wrote:
> On Sat, 2002-05-25 at 21:30, Daniel Phillips wrote:
> > A short time ago I made my living by programming large factory machines
> > that can kill people in an instant.  I would have loved to use Linux, but 
> > it was not ready at the time.  As long as core developers continue to 
> > ignore the need for realtime capability in the kernel itself - as opposed 
> > to waving hands
> 
> This has nothing to do with real time. The capacity of computer science
> to formally validate a system (and if it can kill people it should be
> formally proven in something like Z) is not sufficient for a system so
> complex. Such a device needs a tiny verifiable kernel core.

The Linux core *is* tiny, and for that reason attractive for this purpose.  
I agree that it is still too complex to verify formally, and we've suffered 
because of that, i.e., when will we see the last truncate race?  When will we 
see a VM that doesn't fall over in corner cases?  I don't accept 'never' as 
an anwswer to this.  Much of our current work - removal of the buffer cache, 
elimination of buffer heads in most roles, coalescing of the ide and scsi 
block flavors, introduction of reverse-mapping in the vm - moves the kernel 
in the direction of less complexity, in the sense that state transitions and 
subsystem interactions become easier to audit.

The day of the tiny, single purpose OS-let in industrial applications is 
pretty much over.  To illustrate, among the requirements we had was to 
support modern hardware such as accelerated video cards, and high level 
functions such as tcp stacks.  We even had to run a database on the machine, 
and a GUI.  Don't even think of asking the hardware engineers to design a 
two-processor system so that one of them can run a simplified OS.  They won't 
do it, because then they know perfectly well that one processor will do the 
job, and it did, is doing it today.  Reliably, and on what OS?  Dos.

Surely if DoS can do it, then Linux can do it better.  But not if we admit 
defeat before starting.

-- 
Daniel
