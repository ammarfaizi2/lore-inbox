Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276092AbRI1Ox2>; Fri, 28 Sep 2001 10:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276090AbRI1OxV>; Fri, 28 Sep 2001 10:53:21 -0400
Received: from snowball.fnal.gov ([131.225.81.94]:42514 "EHLO
	snowball.fnal.gov") by vger.kernel.org with ESMTP
	id <S276092AbRI1OxB>; Fri, 28 Sep 2001 10:53:01 -0400
Date: Fri, 28 Sep 2001 09:53:21 -0500 (CDT)
From: Steven Timm <timm@fnal.gov>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: DMA problem (?) w/2.4.6-xfs and ServerWorks OSB4 Chipset
In-Reply-To: <E15mk45-0005Li-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.31.0109280929030.30363-100000@snowball.fnal.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Alan for your reply to this,...just a couple clarifications
needed...


On Thu, 27 Sep 2001, Alan Cox wrote:

> > 2.4.7-ac2 patch level and not having any lock-ups with ultraDMA.
> > My question--there was a new file "serverworks.c" inserted in the
> > 2.4.6 ac patches.  Does anyone know if that made it into the kernel
> > and supposedly fixed the problem?  (My guess is that it has *not*
>
> Short answer is "it should"
>
OK--"it should" fix the bug--my question is, how far has the
serverworks.c which was in the 2.4.6-ac series now propagated
into Linus' tree (and eventually into the RedHat tree?)  Also,
are the later 2.4.7 and higher -ac patches significantly
different from that which was found in the 2.4.6-ac patches?

> Long answer "I have been chasing a specific problem with OSB4, seagate
> drives and UDMA corruption. We can reliably reproduce it and see it on one
> set of machines. Serverworks cannot reproduce it elsewhere"
>
Too bad we didn't know this a month ago... we had 136 of these machines
and were seeing it all the time, could have given you a perfect test
bed...we found the quickest way
to reproduce it was just to do ls -R /usr | grep Input/output error
and managed to make 80 of the 136 machines misbehave within a couple
of days time.  As a result of that the vendor swapped all the drives
to western digital and left us with a bug that has only happened on
10 machines over the course of 2 months--where the DMA timeouts
will hang the machine but not corrupt the data.

> So unless your box when running current -ac starts spewing messages about
> DMA completions seeming broken - it should work. I only mention this
> because you write:
>
> > We have seen quite a difference on systems that are otherwise
> > the same (Supermicro 370DLE w/serverworks OSB4 LE chipset) by swapping
> > different models of hard disk drives.  With some types of drive
> > (Seagate) we
> > observe massive corruption of the file system but nothing reported
> > in /var/log/messages or on the console.  Currently we see hda
> > timeouts (but only on about 10 systems over the course of 2 months)
> > which hang the machine but after a reboot things are fine (Western
> > Digital).
>
> I would thus be very interested if the current -ac "hardware just did
> something impossibly stupid" trap is hit.
>
> Alan
>
Just tell me what you think your latest and greatest patch is that
you would want to see tested and I'll be glad to give it a test on this
cluster.

Thanks

Steve Timm


