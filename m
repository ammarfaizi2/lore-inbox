Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312570AbSDENHO>; Fri, 5 Apr 2002 08:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312573AbSDENHD>; Fri, 5 Apr 2002 08:07:03 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:48388 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S312570AbSDENGx>; Fri, 5 Apr 2002 08:06:53 -0500
Date: Fri, 5 Apr 2002 08:04:28 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: faster boots?
In-Reply-To: <20020404220022.F24914@redhat.com>
Message-ID: <Pine.LNX.3.96.1020405075636.7802B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2002, Benjamin LaHaise wrote:

> I find that on heavily scsi systems: one machine spins each of 13 disks 
> up sequentially.  This makes the initial boot take 3-5 minutes before 
> init even gets its foot in the door.  If someone made a patch to spin 
> up scsi disks on the first access, I'd gladly give it a test. ;-)

  Look at the specs for startup current. Multiply by 13. That's why they
spin up one at a time, many drives draw far more current getting up to
speed, and doing all of them at once can be an issue.

  The initial spin is usually done by the BIOS, if you use RAID and have
the drives spin down when idle (assuming they are ever idle), they can
start all at once. I have seen that pop the little breaker in a power
supply, although it was poorly configured (a manager told me 200w was
fine, 350 was overkill). Four SCSI in a tower, get a query and reset.

  That said, I believe you can tune that in some controllers, but I don't
have a model or example handy. Most of my larger machines don't boot very
often, so it's not an issue for me.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

