Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278131AbRJLUwu>; Fri, 12 Oct 2001 16:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278128AbRJLUwk>; Fri, 12 Oct 2001 16:52:40 -0400
Received: from D8FA50AA.ptr.dia.nextlink.net ([216.250.80.170]:26035 "EHLO
	tetsuo.applianceware.com") by vger.kernel.org with ESMTP
	id <S278131AbRJLUwa>; Fri, 12 Oct 2001 16:52:30 -0400
Date: Fri, 12 Oct 2001 13:28:02 -0700
From: Mike Panetta <mpanetta@applianceware.com>
To: linux-kernel@vger.kernel.org
Cc: andre@linux-ide.org
Subject: Re: IDE Hot-Swap, does it work?, Conspiracy is afoot!
Message-ID: <20011012132802.B6355@tetsuo.applianceware.com>
Mail-Followup-To: Mike Panetta <mpanetta@applianceware.com>,
	linux-kernel@vger.kernel.org, andre@linux-ide.org
In-Reply-To: <20011011131042.A2780@tetsuo.applianceware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011011131042.A2780@tetsuo.applianceware.com>; from mpanetta@applianceware.com on Thu, Oct 11, 2001 at 01:10:42PM -0700
Organization: ApplianceWare
X-Mailer: mutt (ruff!  ruff!)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I have played with this a bit since I have recieved no
real respose other than one other person having the same
question, here is what I have found out...

I have a piece of hardware that does have hot-swap IDE
chassis on it, so atleast the IDE bus xcvers should be
able to handle the swapping, as the connection to the
drive is disabled before the can comes all the way out
of the slot.

 - I can remove a drive while the system is on and I have
   a software raid 5 on the 4 drives, everything is ok
   after about 2 minutes the system recovers and the software
   raid fails the drive I removed.  This makes sense.
 - After a few minutes I replace the drive I had just failed
   by removing it, and I try to readd it to the system via
   raidhotadd.  One of 2 things happens in this instance,
   depending on what kernel I have loaded.  
    - If I have kernel 2.4.2-2 loaded (a stock redhat 7.1
      kernel), the drive reappears, and can be added back
      to the raid (and is added back).
    - If I am running kernel 2.4.10 or any later (AC or non)
      the machine fails to ever be able to read from the disk
      again.  I cannot readd the disk to the arry, nor can I
      fdisk it (or access it in any other way).
 - None of this solves the adding of a drive to the system
   where there was none before boot...  I tried the hdparm -R
   stuff but its useless and hangs my box no matter what I give
   it as paramaters.  This of course may be because I do not
   know how to use it very well...

If anyone can help it would be greatly appreciated.  I am
really beginning to believe that IDE will never be as capable
as SCSI in this reguard, atleast not in linux, espically as
any (even if it was broken) support that used to be in the
kernel has disappeared. Please someone convince me otherwise!
Atleast point me in the correct direction as to what in the
kernel would have to be changed to make this work...

Thanks,
Mike

-- 
