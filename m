Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313622AbSDEVda>; Fri, 5 Apr 2002 16:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313627AbSDEVdT>; Fri, 5 Apr 2002 16:33:19 -0500
Received: from to-velocet.redhat.com ([216.138.202.10]:1014 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S313622AbSDEVdE>; Fri, 5 Apr 2002 16:33:04 -0500
Date: Fri, 5 Apr 2002 16:33:01 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: faster boots?
Message-ID: <20020405163301.B15540@redhat.com>
In-Reply-To: <20020404220022.F24914@redhat.com> <Pine.LNX.3.96.1020405075636.7802B-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2002 at 08:04:28AM -0500, Bill Davidsen wrote:
> On Thu, 4 Apr 2002, Benjamin LaHaise wrote:
> 
> > I find that on heavily scsi systems: one machine spins each of 13 disks 
> > up sequentially.  This makes the initial boot take 3-5 minutes before 
> > init even gets its foot in the door.  If someone made a patch to spin 
> > up scsi disks on the first access, I'd gladly give it a test. ;-)
> 
>   Look at the specs for startup current. Multiply by 13. That's why they
> spin up one at a time, many drives draw far more current getting up to
> speed, and doing all of them at once can be an issue.

Really?  I didn't know that.  :-P

Seriously, only 2 of the disks need to be spun up to start the system, 
so I'd rather be able to login and have only processes which need to 
access the disks that aren't ready yet wait.  Hence the comment about 
spinning disks up on first access...

Also, the system has a ~1200W power supply, so I think it can spin more 
than 1 disk up at a time.  Again, defaulting to 1 is right and good, but 
making it tunable would be better.

		-ben
-- 
"A man with a bass just walked in,
 and he's putting it down
 on the floor."
