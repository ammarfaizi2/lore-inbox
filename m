Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129664AbQLACvZ>; Thu, 30 Nov 2000 21:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129345AbQLACvP>; Thu, 30 Nov 2000 21:51:15 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:28685 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129514AbQLACvC>; Thu, 30 Nov 2000 21:51:02 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Florian Heinz <sky@dereference.de>
Date: Fri, 1 Dec 2000 13:11:45 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14887.2273.174231.960990@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: Some problems with the raid-stuff in 2.4.0-test12pre3
In-Reply-To: message from Florian Heinz on Thursday November 30
In-Reply-To: <20001130123322.A672@inode.real-linux.de>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday November 30, sky@dereference.de wrote:
> Hello people,
> 
> I have some trouble with the raid-stuff.
> My machine is a Pentium-III, 256 MB ram and 7 scsi-disks (IBM DNES-318350W
> 17B). I'm using raid5 for 6 of these disks (chunk-size 8).
> Machine boots, I do mkraid /dev/md0 and then mke2fs /dev/md0 and that's
> where the problems start. mkfs tries to write 684 inode-tables and after the
> first 30 it gets very slow. ps ax (with wchan) tells me it hangs in
> wakeup_bdflush.
> I'm rather sure it's related to the raidcode, because without raid the disks
> work as expected.
> I'm using an Adaptec 7892A with the aic7xxx-driver, I have disabled the TCQ
> and the extra checks for the new queueing code, but I have tried with both
> activated, too.
> No related messages from the kernel in the syslog.
> It worked fine with 2.2.x.

Is it just "very slow", but it eventually finishes, it is it so slow,
that it actually stops and doesn't make any progress at all?

raid5 in 2.4 is definately slower than in 2.2.  Could that be all that
you are seeing?

NeilBrown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
