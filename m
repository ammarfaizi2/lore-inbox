Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289603AbSAPWAc>; Wed, 16 Jan 2002 17:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289568AbSAPWAL>; Wed, 16 Jan 2002 17:00:11 -0500
Received: from quark.didntduck.org ([216.43.55.190]:18445 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S289458AbSAPWAH>; Wed, 16 Jan 2002 17:00:07 -0500
Message-ID: <3C45F7B6.1BCB4519@didntduck.org>
Date: Wed, 16 Jan 2002 16:59:18 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Christian Thalinger <e9625286@student.tuwien.ac.at>,
        Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        linux-kernel <linux-kernel@vger.kernel.org>, davej@suse.de
Subject: Re: floating point exception
In-Reply-To: <Pine.LNX.3.95.1020116161110.15035A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On 16 Jan 2002, Christian Thalinger wrote:
> 
> > On Wed, 2002-01-16 at 15:32, Zwane Mwaikambo wrote:
> > > Can you also reproduce _without_ loading NVdriver, just to make everybody
> > > happy.
> > >
> > > Thanks,
> > >     Zwane Mwaikambo
> > >
> >
> > Sure, same breakdown. Maybe it's really an dual athlon xp issue as dave
> > jones mentioned. But shouldn't this also occur when i trigger a floating
> > point exception myself? Is there a way to check which floating point
> > exception was raised by the seti client?
> >
> > Regards.
> >
> 
> Maybe you can run it off from gdb? Or `strace` it to a file? Usually
> these things are caused by invalid 'C' runtime libraries, either
> corrupt, "installed by just making a sim-link to something that
> was presumed to be close to what the application was compiled with",
> or an error in mem-mapping.
> 
> Another very-real possibility is that somebody used floating-point
> within the kernel thus corrupting  the `seti` FPU state. You can
> check this out by making a program that does lots of FP calculations,
> perhaps the sine of a large number of values. You put the results
> into one array. Then you do the exact same thing with the results
> put into another array.  Then just `memcmp` the arrays! You run
> this in a loop for an hour. If the kernel is mucking with your FPU,
> it will certainly show.

Hmm, that's an interesting idea... An Athlon optimised kernel does use
the MMX/FPU registers to do mem copies.  Try running a kernel compiled
for just a Pentium and see if the problem persists.

--

				Brian Gerst
