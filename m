Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269943AbRHJQ3s>; Fri, 10 Aug 2001 12:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269945AbRHJQ3i>; Fri, 10 Aug 2001 12:29:38 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:17258 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S269943AbRHJQ33>; Fri, 10 Aug 2001 12:29:29 -0400
To: jury gerold <geroldj@grips.com>
Cc: Thodoris Pitikaris <thodoris@cs.teiher.gr>, linux-kernel@vger.kernel.org
Subject: Re: is this a bug?
In-Reply-To: <3B6FD644.7020409@cs.teiher.gr> <3B716E0A.8030005@grips.com>
	<m1g0b0th21.fsf@frodo.biederman.org> <3B73D1E9.9020800@grips.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 10 Aug 2001 10:22:47 -0600
In-Reply-To: <3B73D1E9.9020800@grips.com>
Message-ID: <m1wv4bsx48.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jury gerold <geroldj@grips.com> writes:

> Hi Eric
> 
> The CPU is a 1.1GHz tbird 200MHz FSB and i am running it this way.
> The motherboard can do 100 and 133 MHz but i run
> the SDRAM at 100MHz from the beginning, since i have seen lot's
> of boards with memory problems and i wanted to be on the good side.
> Both, the old 128MB and the new 256MB SDRAM where sold as PC133.
> It is a single DIMM in both cases.
> 
> When i started to sue the SDRAM for the trouble i checked the SPD and found
> the 128MB-PC133 was actually a PC100 with a few steps towards PC66 (major
> brand).
> 
> So i tried a new one that, at least from the SPD, is a real PC133 and suddenly
> ...
> 
> I have tried to kill it
> 
> kernel 2.4.7-xfs from cvs at the moment
> athlon optimisations
> UDMA on ide0 and ide1
> 2 harddrives, 1 cdrom, 1 cd/rw
> 
> since then, but it works, works, works.
> 
> 
> This weekend does not see me at home.
> I will send the timings on sunday/monday.
> 
> What do you expect to get out of this ?

Mostly I am curious about what is going on.  I work on linuxBIOS so
(a) I might just have to figure out if there are software work arounds
    if/when I port to this platform. 
(b) I have written enough memory setup code that does SPD on the fly,
    to compute the DIMM timings, that understanding DIMMS and memory
    controllers is one of my areas of competence.

If the ram was really PC100 mislabeled, as PC133 and it was being run
at 133Mhz I can see the problem.  If it was only being run as PC100
I have a problem seeing, why you would have a problem.

Eric
