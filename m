Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267380AbUJNTR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267380AbUJNTR1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 15:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267368AbUJNTIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 15:08:50 -0400
Received: from chaos.analogic.com ([204.178.40.224]:9088 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267365AbUJNTFj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 15:05:39 -0400
Date: Thu, 14 Oct 2004 15:03:51 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Dave Jones <davej@redhat.com>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       David Howells <dhowells@redhat.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       "Rusty Russell (IBM)" <rusty@au1.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>, Greg KH <greg@kroah.com>,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: signed kernel modules?
In-Reply-To: <20041014184635.GD18321@redhat.com>
Message-ID: <Pine.LNX.4.61.0410141455330.5232@chaos.analogic.com>
References: <16349.1097752!349@redhat.com> <17271.1097756056@redhat.com>
 <Pine.LNX.4.53.0410140824490.363@chaos.analogic.com>
 <Pine.GSO.4.61.0410141617100.21062@waterleaf.sonytel.be>
 <Pine.LNX.4.53.0410141022180.1018@chaos.analogic.com>
 <Pine.LNX.4.53.0410141131190.7061@chaos.analogic.com> <20041014155030.GD26025@redhat.com>
 <Pine.LNX.4.61.0410141352590.8479@chaos.analogic.com> <20041014182052.GA18321@redhat.com>
 <Pine.LNX.4.61.0410141422530.1765@chaos.analogic.com> <20041014184635.GD18321@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2004, Dave Jones wrote:

> On Thu, Oct 14, 2004 at 02:30:08PM -0400, Richard B. Johnson wrote:
>
> > No. I didn't time `make modules`, only `make bzImage`.
> > `make modules` takes too long to time (really) I don't
> > want to use any CPU resources which will screw up the
> > timing and I need to use the computer.
>
> You still have to calculate dependancies and such for
> anything built modular. Also a bunch of code built into
> the bzImage changes if things are built modular.
>
> the two comparisons aren't equal.  Additionally,
> you haven't factored in the fact that 'make dep'
> is no longer needed. This accounts for a big chunk
> of time on 2.4 kernel builds.
>
> > A wall-clock guess is that `make modules` takes about
> > an hour on the new system while it takes about 4 minutes
> > on the old. The new kernel build procedure is truly
> > horrible for the wall-clock time that is used.
> >
> > For oranges vs oranges, if I compile Version 2.4.26
> > on a version 2.6.8 OS computer, the compile-time
> > is within tens of seconds. I'm not complaining about
> > the resulting kernel code performance, only the
> > abortion^M^M^M^M^M^Mjunk used to create a new kernel.
> > It 'make' won't do it, we have a problem and make
> > needs to be fixed.
>
> oranges to oranges means _exactly_ the same options
> (where they haven't changed from 2.4 -> 2.6) are
> set/unset. Anything else is totally bogus.
>
> If you find things are still taking phenomenally
> long times to build, then something is wrong somewhere.
> Don't you find it strange you're the only person
> to have complained about this ? If it was as big
> a problem as you're suggesting, those of us who
> do nothing but build kernels all day would be up in arms.
>
> 		Dave
>

I think you guys probably got used to it. Also, you
seldom build the whole thing, anymore, because the
dependencies are handled differently. I was used to
building stuff on 2.4.x. When I went to build stuff using
the new build procedure I was shocked. It was like the
old days with 66MHz '486s (fast) and 33MHz i386's. Of
course there weren't modules, then so 2hrs,30min
was normal. Now, with a CPU that's 80 times faster and
a front-side bus that's 12 time faster, and SCSI
disks that are 40 times faster, there just has to
be something wrong when a complete build of the kernel
takes an hour.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.8 on an i686 machine (5537.79 BogoMips).
             Note 96.31% of all statistics are fiction.

