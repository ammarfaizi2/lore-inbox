Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289482AbSAVWPB>; Tue, 22 Jan 2002 17:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289484AbSAVWOn>; Tue, 22 Jan 2002 17:14:43 -0500
Received: from gumby.it.wmich.edu ([141.218.23.21]:19638 "EHLO
	gumby.it.wmich.edu") by vger.kernel.org with ESMTP
	id <S289482AbSAVWOg>; Tue, 22 Jan 2002 17:14:36 -0500
Subject: Re: Athlon PSE/AGP Bug
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: Florian Weimer <Weimer@CERT.Uni-Stuttgart.DE>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87k7uakutl.fsf@CERT.Uni-Stuttgart.DE>
In-Reply-To: <1011610422.13864.24.camel@zeus>
	<20020121.053724.124970557.davem@redhat.com>
	<20020121.053724.124970557.davem@redhat.com>
	<20020121175410.G8292@athlon.random> <3C4C5B26.3A8512EF@zip.com.au>
	<o7cp4ukpr9ehftpos1hg807a9hfor7s55e@4ax.com>
	<hbep4uka8q6t1tfv6694sjtvfrulipg3a4@4ax.com> 
	<87k7uakutl.fsf@CERT.Uni-Stuttgart.DE>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 22 Jan 2002 17:14:27 -0500
Message-Id: <1011737673.10474.12.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On the same note.  Anyone trying to run their ram faster than it should
go from the bios would eventually see these kind of things happen. I
used to get errors from anything really memory intensive, games and such
from having ram set at cas 2 instead of cas 3 and removing certain
delays when i shouldn't.  People should really make sure their tuned up
systems aren't just overtuned before forking up segfaults to the Athlon
bug that apparently all the kernel guru's have decided doesn't affect
linux just as it doesn't affect the bsd people.   

It seems to me that the bug "could" be in your chip, it doesn't mean
it's in every athlon...  otherwise we'd be seeing some commonalities and
so far i've seen none.  

Since all the people having problems in linux with the athlon bug are
heavy graphics/game users ...I'd suspect overtuning as the problem
before anything else first and make sure they run memtest86,  even if
disabling pentium ops fixes things. 

On Tue, 2002-01-22 at 15:13, Florian Weimer wrote:
> Steve Brueggeman <brewgyman@mediaone.net> writes:
> 
> > Forgot to mention, I got the segfaults compiling kernels while running
> > linux-2.4.17, I was in console, and did not have Frame Buffer, or drm drivers
> > loaded.  I did have the SiS AGP compiled into the kernel though.
> 
> On my new system at home, I got similar segfaults.  Running memtest86
> revealed that one of the RAM modules had a problem--and if I swapped
> them, the BIOS startup code wouldn't even expand the actual BIOS code
> every other system boot.  After removing the offending RAM module (and
> later replacing it) the problems were completely gone and haven't
> returned yet...
> 
> Fortunately, I didn't know of the PSE/AGP bug back then.  This made
> debugging much, much easier. ;-)
> 
> -- 
> Florian Weimer 	                  Weimer@CERT.Uni-Stuttgart.DE
> University of Stuttgart           http://CERT.Uni-Stuttgart.DE/people/fw/
> RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


