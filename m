Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265661AbSJSTVH>; Sat, 19 Oct 2002 15:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265667AbSJSTVH>; Sat, 19 Oct 2002 15:21:07 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:35847 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265661AbSJSTVG>; Sat, 19 Oct 2002 15:21:06 -0400
Date: Sat, 19 Oct 2002 15:26:14 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Mark Gross <mark@thegnar.org>
cc: NPT library mailing list <phil-list@redhat.com>,
       Daniel Jacobowitz <dan@debian.org>, Mark Kettenis <kettenis@gnu.org>,
       mgross <mgross@unix-os.sc.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] thread-aware coredumps, 2.5.43-C3
In-Reply-To: <200210180657.38291.mark@thegnar.org>
Message-ID: <Pine.LNX.3.96.1021019152330.29078J-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2002, Mark Gross wrote:

> I think I fixed it to set namesz to 5, with the +1 it was making it 6.  My 
> patch is supposed to remove the +1.
> 
> The value for men-name for the extended registers case is "LINUX".

But the terminating '\0' is required in ELF, no? Or are you going to drop
the name to "LINU" and put the required character in?

In modern size machines I think the limit is way too low, but it is a
standard. I'm sure some code will rely on the NUL and run off the end of
the Earth looking for it, so you can't just leave it off.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

