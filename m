Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311419AbSCMWhz>; Wed, 13 Mar 2002 17:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311418AbSCMWhq>; Wed, 13 Mar 2002 17:37:46 -0500
Received: from mailb.telia.com ([194.22.194.6]:6670 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id <S311417AbSCMWhb>;
	Wed, 13 Mar 2002 17:37:31 -0500
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
In-Reply-To: <200202281536.g1SFaqF02079@localhost.localdomain>
	<E16heCm-0000Q5-00@starship.berlin>
	<10203032021.ZM443706@classic.engr.sgi.com>
	<E16hl4R-0000Zx-00@starship.berlin> <phillips@bonn-fries.net>
	<10203032209.ZM424559@classic.engr.sgi.com>
	<20020304165216.A1444@redhat.com> <3C8AEDFC.502CAD04@torque.net>
	<20020311121300.G2346@nbkurt.etpnet.phys.tue.nl>
	<20020312065806.GX704@suse.de>
From: Peter Osterlund <petero2@telia.com>
Date: 13 Mar 2002 23:37:24 +0100
In-Reply-To: <20020312065806.GX704@suse.de>
Message-ID: <m2wuwg2ixn.fsf@ppro.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

> On Mon, Mar 11 2002, Kurt Garloff wrote:
> > disks (DASDs), Write-Once and Optical Memory devices. (Funny enough, the
> > SCSI spec also lists SYNCHRONIZE_CACHE for CD-Rom devices
> 
> Hey, I use SYNCHRONIZE_CACHE in the packet writing stuff for CD-ROM's
> all the time :-). Not all are read-only. In fact, Peter Osterlund
> discovered that if you have pending writes on the CD-ROM it's a really
> good idea to sync the cache prior to starting reads or they have a nasty
> tendency to time out.

Not only time out, some drives give up immediately with SK/ASC/ASCQ
05/2c/00 "command sequence error" unless you flush the cache first.
After some googling, I found a plausible explanation for that
behaviour here:

http://www.rahul.net/endl/cdaccess/t10/email/mmc/1997/m9703031.txt

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
