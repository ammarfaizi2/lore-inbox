Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289852AbSAKDYX>; Thu, 10 Jan 2002 22:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289851AbSAKDYE>; Thu, 10 Jan 2002 22:24:04 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:13317 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S289850AbSAKDYB>; Thu, 10 Jan 2002 22:24:01 -0500
Message-ID: <3C3E597F.BDFD49C9@zip.com.au>
Date: Thu, 10 Jan 2002 19:18:23 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: nigel@nrg.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rob Landley <landley@trommello.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16OkSV-0005EZ-00@the-village.bc.nu> <Pine.LNX.4.40.0201101840470.5213-100000@cosmic.nrg.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Gamble wrote:
> 
> On Thu, 10 Jan 2002, Alan Cox wrote:
> > The fun below 1mS comes from
> >
> >       1.      APM bios calls where the bios decides to take >1mS to have
> >               a chat with your batteries
> >       2.      Video cards pulling borderline legal PCI tricks to get
> >               better benchmarketing by stalling the entire bus
> 
> Don't forget the embedded space, where the hardware vendor can ensure
> that their hardware is well-behaved.  Even on a PC, it is possible for
> someone who cares about realtime to spec a reasonable system.
> 
> On good hardware, we can easily do much better than 1ms latency with a
> preemptible kernel and a spinlock cleanup.  I don't think the
> limitations of some PC hardware should limit our goals for Linux.
> 

On 700MHz x86 running Cerberus we can do 50 microseconds average
and 1300 microseconds worst-case today.  

Below 1000 uSec, the required changes get exponentially larger
and more complex.  I doubt that it's sane to try to go below
a millisecond on a desktop-class machine with desktop-class
workload, disk, memory and swap capacities.

On a more constrained system, which is what I expect you're
referring to, 250 microseconds should be achievable.  Whether
or not that is achieved via preemptability is pretty irrelevant.

-
