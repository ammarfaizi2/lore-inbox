Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129324AbQK0Sp1>; Mon, 27 Nov 2000 13:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129826AbQK0SpR>; Mon, 27 Nov 2000 13:45:17 -0500
Received: from mailf.telia.com ([194.22.194.25]:55312 "EHLO mailf.telia.com")
        by vger.kernel.org with ESMTP id <S129324AbQK0SpK>;
        Mon, 27 Nov 2000 13:45:10 -0500
From: Roger Larsson <roger.larsson@norran.net>
Date: Mon, 27 Nov 2000 19:12:07 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="US-ASCII"
Cc: Andrew Morton <andrewm@uow.edu.au>, "Mr. Big" <mrbig@sneaker.sch.bme.hu>,
        linux-kernel@vger.kernel.org
To: Rik van Riel <riel@conectiva.com.br>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.4.21.0011261623200.23375-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0011261623200.23375-100000@duckman.distro.conectiva>
Subject: Re: readonly /proc/sys/vm/freepages (was: Re: PROBLEM: crashing kernels)
MIME-Version: 1.0
Message-Id: <00112719120702.01110@dox>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 November 2000 19:36, Rik van Riel wrote:
> On Sun, 26 Nov 2000, Ingo Oeser wrote:
> > On Sun, Nov 26, 2000 at 10:49:50AM +1100, Andrew Morton wrote:
> > > You may also get some benefit from running:
> > >
> > > # echo "512 1024 1536" > /proc/sys/vm/freepages
> > >
> > > after booting.
> >
> > ... which is a NOOP on recent 2.4.0-testX-kernels. So please
> > complain at Rik for this (CC'ed him) ;-)
>
> I wasn't aware I studied at tu-chemnitz ;)
>
> > It's simply not that easy to set in the new VM since we count
> > the inactive_clean and/or inactive_dirty pages like free pages
> > in some cases.
>
> And also, because HIGHMEM pages are not at all usable for kernel
> things, so simply reserving 20MB for network bursts isn't going
> to help you when it's all in highmem pages ...

Should the
echo "512 1024 1536" > /proc/sys/vm/freepages
apply only to DMA pages?
(It would work correctly with <16 M machines, and probably ok with others)

Sidenote:
 Can you build a clean x86 computer that do not especially care about
 DMA able pages? (no ISA cards, no memory limited PCI cards, etc...)
 Would it then be nice to be able to remove that zone completely?
 (like we can with the HIGHMEM today)

>
> > > The default values are a little too low for
> > > applications which are very network intensive.
> >
> > Especially for low memory machines, which are dedicated only for
> > this purpose. Many people use (embedded) Linux and a (embedded)
> > PC to cheaply fill functionality gaps in industrial
> > environments.
>
> Indeed, I agree that we want this tunable back...
>

/RogerL

-- 
Home page:
  http://www.norran.net/nra02596/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
