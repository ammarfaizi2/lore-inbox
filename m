Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268095AbTBRXqa>; Tue, 18 Feb 2003 18:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268098AbTBRXqa>; Tue, 18 Feb 2003 18:46:30 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:8882 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S268095AbTBRXq3>; Tue, 18 Feb 2003 18:46:29 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Rob Emanuele" <rje@cyan.com>
Date: Wed, 19 Feb 2003 10:56:11 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15954.51227.385648.487733@notabene.cse.unsw.edu.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Fixing a non-redundant raid
In-Reply-To: message from Rob Emanuele on Tuesday February 18
References: <002d01c2d7a2$2071adf0$a301a8c0@rje1xp>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday February 18, rje@cyan.com wrote:
> I've got a raid that I was running w/o a spare disk.  One of the drives
> was being flakey and I restarted the machine and I was wondering if I
> can recover the data on the raid.  It did not have a spare disk.  There
> are 12 drives in the stripe set.  According the the logs one drive isn't
> listed as a raid drive (sdi1) and the other's (sdb1) event counter is
> behind.  Is there anything I can do or is it a loss and I should rebuild
> the array with a hot spare :)?
> 
> I attached the logs.
> 
> Thanks for any help,
> 
> Rob

Get mdadm, assemble with --force.
e.g.

 mdadm --assemble --force /dev/md0 /dev/sd[abcdefghijkl]1

NeilBrown

http://www.kernel.org/pub/linux/utils/raid/mdadm/
