Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262712AbSJOGfp>; Tue, 15 Oct 2002 02:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262722AbSJOGfp>; Tue, 15 Oct 2002 02:35:45 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:30112 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S262712AbSJOGfo>; Tue, 15 Oct 2002 02:35:44 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: David Mansfield <lkml@dm.cobite.com>
Date: Tue, 15 Oct 2002 16:41:08 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15787.47236.823202.578662@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] raw over raid5: BUG at drivers/block/ll_rw_blk.c:1967
In-Reply-To: message from David Mansfield on Monday October 14
References: <Pine.LNX.4.44.0210141627360.2876-100000@admin>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday October 14, lkml@dm.cobite.com wrote:
> 
> Hi everyone,
> 
> I haven't been able to run raw over raid5 since 2.5.30 or so, but every
> time I'm about to report it, a new kernel comes out and the problem
> changes completely :-( Now I'm finally going to start getting out the info
> it the hopes someone can fix it.  The oops was triggered by attempting to 
> read from /dev/raw/raw1 (bound to /dev/md0) using dd.  System info 
> follows oops:
> 
> ------------[ cut here ]------------
> kernel BUG at drivers/block/ll_rw_blk.c:1967!
> invalid operand: 0000
>  

You are not alone in reporting this BUG...

I blame the Scsi/bio  layer.
Jens Axboe blames raid5.
:-)

Hopefully we will find it one place or the other. 
The other report didn't use raw to get the bug, but if using raw makes
it reproducable, I will try that and see if I can reproduce it easily.

NeilBrown
