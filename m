Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261558AbRFFK0J>; Wed, 6 Jun 2001 06:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261561AbRFFKZ7>; Wed, 6 Jun 2001 06:25:59 -0400
Received: from sportingbet.gw.dircon.net ([195.157.147.30]:65032 "HELO
	sysadmin.sportingbet.com") by vger.kernel.org with SMTP
	id <S261558AbRFFKZm>; Wed, 6 Jun 2001 06:25:42 -0400
Date: Wed, 6 Jun 2001 11:22:07 +0100
From: Sean Hunter <sean@dev.sportingbet.com>
To: "Dr S.M. Huen" <smh1008@cus.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
Message-ID: <20010606112207.H15199@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>,
	"Dr S.M. Huen" <smh1008@cus.cam.ac.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010606095431.C15199@dev.sportingbet.com> <Pine.SOL.3.96.1010606103559.20297A-100000@draco.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SOL.3.96.1010606103559.20297A-100000@draco.cus.cam.ac.uk>; from smh1008@cus.cam.ac.uk on Wed, Jun 06, 2001 at 10:57:57AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2001 at 10:57:57AM +0100, Dr S.M. Huen wrote:
> On Wed, 6 Jun 2001, Sean Hunter wrote:
> 
> > 
> > For large memory boxes, this is ridiculous.  Should I have 8GB of swap?
> > 
> 
> Do I understand you correctly?
> ECC grade SDRAM for your 8GB server costs £335 per GB as 512MB sticks even
> at today's silly prices (Crucial). Ultra160 SCSI costs £8.93/GB as 73GB
> drives.
> 
> It will cost you 19x as much to put the RAM in as to put the
> developer's recommended amount of swap space to back up that RAM.  The
> developers gave their reasons for this design some time ago and if the
> ONLY problem was that it required you to allocate more swap, why should
> it be a priority item to fix it for those that refuse to do so?   By all
> means fix it urgently where it doesn't work when used as advised but
> demanding priority to fixing a problem encountered when a user refuses to
> use it in the manner specified seems very unreasonable.  If you can afford
> 4GB RAM, you certainly can afford 8GB swap.
> 

This is completely bogus. I am not saying that I can't afford the swap.
What I am saying is that it is completely broken to require this amount
of swap given the boundaries of efficient use. 

This is only one of several things which make the 2.4 VM suck for large,
small or medium machines at the moment. Until we have a working VM 2.4
can't possibly go into production on my site on these machines.

A working VM would have several differences from what we have in my
opinion, among which are:
        - It wouldn't require 8GB of swap on my large boxes
        - It wouldn't suffer from the "bounce buffer" bug on my
          large boxes
        - It wouldn't cause the disk drive on my laptop to be
          _constantly_ in use even when all I have done is spawned a
          shell session and have no large apps or daemons running.
        - It wouldn't kill things saying it was OOM unless it was OOM.

Furthermore, I am not demanding anything, much less "priority fixing"
for this bug. Its my personal opinion that this is the most critical bug
in the 2.4 series, and if I had the time and skill, this is what I would
be working on. Because I don't have the time and skill, I am perfectly
happy to wait until those that do fix the problem. To say it isn't a
problem because I can buy more disk is nonsense, and its that sort of
thinking that leads to constant need to upgrade hardware in the
proprietary OS world.

Sean
