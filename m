Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265508AbSLCTOW>; Tue, 3 Dec 2002 14:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265516AbSLCTOV>; Tue, 3 Dec 2002 14:14:21 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:40709 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265508AbSLCTOU>; Tue, 3 Dec 2002 14:14:20 -0500
Date: Tue, 3 Dec 2002 14:20:30 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Khalid Aziz <khalid_aziz@hp.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5] Extract configuration from kernel
In-Reply-To: <3DECE29D.10BBEBA6@hp.com>
Message-ID: <Pine.LNX.3.96.1021203140846.6679B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Dec 2002, Khalid Aziz wrote:

> bill davidsen wrote:
> > 
> > | 2. Include configuration in kernel image file but not in the running
> > | kernel. This adds to the kernel image file size but not the footprint of
> > | running kernel. Configuration can be extracted from kernel image file
> > | using scripts/extract-ikconfig. This script is in principle the same as
> > | what Randy had written originally. I have made it little more robust and
> > | structured it to accomodate more than just x86 architecture.
> >
> > I would suggest that making (2) available as a module would be useful,
> > assuming that at some point 2.5 will have working module capability
> > again. With a bit of tweaking you could make the kernel loader pull it
> > in if a process accessed the file, I guess.
> 
> It is trivial to make (2) available as a module but it has been debated
> that having configuration information available as module does not make
> the job of keeping a reliable source of kernel configuration any easier
> than just keeping a copy of config file in, say, /lib/modules directory.
> If you can ensure you always have the right module file available for
> the running kernel, you can also ensure you always have the right config
> file available for the kernel. 

All true, I just find having the config in the same location for all
kernels (in say /proc/config) is more convenient than having to resolve
the kernel name from another file or do /lib/modules/$(uname -r)/config
from a script. The kernel knows who it is, all others have to ask. It's
just one less step a program would have to take, not a major problem.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

