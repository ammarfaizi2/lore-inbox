Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRDQLyM>; Tue, 17 Apr 2001 07:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129164AbRDQLyC>; Tue, 17 Apr 2001 07:54:02 -0400
Received: from hades.dds.nl ([194.109.10.13]:61824 "HELO humilis.ookhoi.dds.nl")
	by vger.kernel.org with SMTP id <S129143AbRDQLxp>;
	Tue, 17 Apr 2001 07:53:45 -0400
Date: Tue, 17 Apr 2001 13:53:38 +0200
From: Ookhoi <ookhoi@dds.nl>
To: Linas Vepstas <linas@backlot.linas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fsck, raid reconstruction & bad bad 2.4.3
Message-ID: <20010417135338.E1546@humilis>
Reply-To: ookhoi@dds.nl
In-Reply-To: <20010415181825.40FBB1BA03@backlot.linas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010415181825.40FBB1BA03@backlot.linas.org>; from linas@backlot.linas.org on Sun, Apr 15, 2001 at 01:18:25PM -0500
X-Uptime: 09:36:16 up 9 min,  4 users,  load average: 0.24, 0.65, 0.37
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linas Vepstas,

(nice name ;-)

> First problem:  In kernel-2.4.2 and earlier, if the machine is not cleanly
> shut down, then upon reboot, RAID reconstruction is automatically started.
> (For RAID-1, this more-or-less ammounts to copying the entire contents
> of one disk partition on one disk to another).   The reconstruction
> code seems to be clever: it will try to use the full bandwidth when
> the system is idle, and it will throttle back when busy.  It will
> only throttle back so far: it tries to maintain at least a minimum amount
> of work going, in order to gaurentee forward progress even on a busy system.
> 
> The problem:  this dramatically slows fsck after an unclean shut-down.
> You can hear the drives machine-gunning.  I haven't stop-watch timed it,
> but its on the order of 5x slower to fsck a raid partition when there's
> reconstruction going on, then when the raid thinks its clean.  This
> makes unclean reboots quite painful.
> 
> (There is no config file to disable/alter this .. no work-around that I
> know of ..)

One possible 'work-around' is to use a journaling filesystem (like
reiserfs) which eliminates the fsck after a unclean shutdown. It's very
nice to have a crashed system back online fast. The raid sync makes the
system a bit slow, but as you said, it syncs at full speed when idle,
and is nice when less idle. :-)

	Ookhoi
