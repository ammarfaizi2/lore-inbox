Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131210AbRCGV4R>; Wed, 7 Mar 2001 16:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131217AbRCGV4I>; Wed, 7 Mar 2001 16:56:08 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:37134 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S131211AbRCGVzy>; Wed, 7 Mar 2001 16:55:54 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "otto meier" <gf435@gmx.net>
Date: Thu, 8 Mar 2001 08:55:28 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15014.44624.26763.798524@notabene.cse.unsw.edu.au>
Cc: "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Kernel crash during resync of raid5 on SMP
In-Reply-To: message from Otto Meier on Wednesday March 7
In-Reply-To: <14955.19182.663691.194031@notabene.cse.unsw.edu.au>
	<200103072130.f27LU0B05886@gate2.private.net>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday March 7, gf435@gmx.net wrote:
> I run a Dual prozessor SMP system on 2.4.2-ac12 for a while
> in degraded mode. Today I put in a new disk to switch to
> full raid5 mode. Shortly after the command raidhotadd  the 
> system crashed with the message lost interrupt on cpu1.

Was there an Oops? Can we see? decoded with ksymoops of course.
Are you happy to retry? (i.e. raidsetfaulty; raidhotremove,
raidhotadd).  If so, Could you try with 2.4.2?

Where abouts in the sync-process did it die?  Start? end? middle?
various?

NeilBrown


> 
> This continued after reboot. I finaly managed to get it running again
> by booting with kernel parameter maxcpus=1. In this one CPU mode
> it finished resycing. 
> 
> During this process I was never able to resync with two CPU's.
> 
> After finishing rescyncing the system run now fine in SMP Dual mode again.
> 
> Perhaps there might be an issue with spinlocks during resyncing.
> 
> Bye Otto
> 
> 
> 
> 
> 
> 
