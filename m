Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbTDZOjI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 10:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbTDZOjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 10:39:07 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:57493 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261312AbTDZOjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 10:39:05 -0400
Date: Sat, 26 Apr 2003 10:34:45 -0400
From: Ben Collins <bcollins@debian.org>
To: Stelian Pop <stelian.pop@fr.alcove.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The IEEE-1394 saga continued... [ was: IEEE-1394 problem on init ]
Message-ID: <20030426143445.GC2774@phunnypharm.org>
References: <20030423142131.GK820@hottah.alcove-fr> <20030423142353.GL354@phunnypharm.org> <20030423145122.GL820@hottah.alcove-fr> <20030423144857.GN354@phunnypharm.org> <20030423152914.GM820@hottah.alcove-fr> <Pine.LNX.4.53L.0304231609230.5536@freak.distro.conectiva> <20030423202002.GA10567@vitel.alcove-fr> <20030423202453.GA354@phunnypharm.org> <20030423204258.GB10567@vitel.alcove-fr> <20030426082956.GB18917@vitel.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030426082956.GB18917@vitel.alcove-fr>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 26, 2003 at 10:29:57AM +0200, Stelian Pop wrote:
> On Wed, Apr 23, 2003 at 10:42:58PM +0200, Stelian Pop wrote:
> 
> > > I haven't been able to figure out how to get the scsi
> > > subsystem to remove devices in this condition:
> > 
> > Well, hopefully someone here will direct you towards the 
> > correct solution before 2.4.21 gets final... Firewire devices
> > tend to be plugged / unplugged quite often.
> 
> This was three days ago. Today, without *any* notice (like posting
> a patch on lkml for example, as I already suggested it), I saw a
> new IEEE1394 patch was checked in into Marcelo's tree.
> 
> As usual, the patch was quite big, in Ben's own words "virtualy
> bloated [...] by format changes". Why he continues to submit patches
> like that one in -rc stage is beyond my understanding.
> 
> And guess what ? The new patch broke (again) my setup. When I plug
> in my iPod, the scsi layer does not see it anymore.

Good lord would you calm down.

Run the rescan-scan-scsi.sh script floating around. Out own website
describes having to use this for 2.4 kernels. It was either leave sbp2
oopsing, or rewrite the load logic so that there was no way for left
over scsi cruft. The side affect is that the only hot-plug situation
ieee1394 had in 2.4 is gone.

Before, loading sbp2 before loading ohci1394 gave the same affect. Now,
loading sbp2 before ohci1394 also requires running rescan-scan-scsi.sh.
Blame the scsi layer, not me.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
