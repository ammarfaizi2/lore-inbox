Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270759AbTGVAJN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 20:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270762AbTGVAJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 20:09:13 -0400
Received: from rrcs-west-24-24-160-174.biz.rr.com ([24.24.160.174]:31979 "EHLO
	pacserv.unco.de") by vger.kernel.org with ESMTP id S270759AbTGVAJL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 20:09:11 -0400
Date: Mon, 21 Jul 2003 17:24:12 -0700
From: Hielke Christian Braun <hcb@unco.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 cryptoloop & aes & xfs
Message-ID: <20030722002412.GA13788@pacserv>
References: <20030720005726.GA735@jolla> <20030720103852.A11298@pclin040.win.tue.nl> <20030720213803.GA777@jolla> <200307211312.40068.jeffpc@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307211312.40068.jeffpc@optonline.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Jul 21, 2003 at 01:12:32PM -0400, Jeff Sipek wrote:
> >
> > So the new cryptoloop in 2.6.0 is incompatible to the one in the
> > international crypto patch?
> >
> > I could not access my old data. So i created a new one. But when
> > i copy some data onto it, i get:
> >
> > XFS mounting filesystem loop5
> > Ending clean XFS mount for filesystem: loop5
> > xfs_force_shutdown(loop5,0x8) called from line 1070 of file
> > fs/xfs/xfs_trans.c. Return address = 0xc02071ab Filesystem "loop5":
> > Corruption of in-memory data detected. Shutting down filesystem: loop5
> > Please umount the filesystem, and rectify the problem(s)
> >
> > To setup, i did this:
> >
> > losetup -e aes /dev/loop5 /dev/hda4
> > mkfs.xfs /dev/hda4
> 
> No, you should use
> 
> mkfs.xfs /dev/loop5
> 
> you want to create a fs on the loop device.
> 

You are right. But i did use the /dev/loop5 device. I just wrote
it wrong in the email. 

I retried today on a different spare machine with the same result.
Then i tried with formating the loopback device with ext2
filesystem. After filling the the device with about 1GB of data, i
umounted it and did a file check. A lot of errors where reported.
Something is not good there too. 


Is anybody using the cryptoloop successful in 2.6.0?

Best regards,
 Christian.
