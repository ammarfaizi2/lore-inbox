Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266754AbSKHELP>; Thu, 7 Nov 2002 23:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266755AbSKHELP>; Thu, 7 Nov 2002 23:11:15 -0500
Received: from unthought.net ([212.97.129.24]:27590 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S266754AbSKHELO>;
	Thu, 7 Nov 2002 23:11:14 -0500
Date: Fri, 8 Nov 2002 05:17:55 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Jeff Dike <jdike@karaya.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-rc1 - hang with processes stuck in D
Message-ID: <20021108041755.GD1729@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Jeff Dike <jdike@karaya.com>, Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org
References: <3DC8645B.A0E99A99@digeo.com> <200211060308.gA638Ui08714@karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200211060308.gA638Ui08714@karaya.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2002 at 10:08:30PM -0500, Jeff Dike wrote:
> akpm@digeo.com said:
> > Kernel is waiting for IO completion on a read.  I would be suspecting
> > your IO system, or interrupt system. 
> 
> Yup.  The disk access light is stuck on continuously at this point, FWIW.
> 
> 
> > Reverting your ide/scsi/whatever drivers to the last-known-to-work
> > version would be interesting. 
> 
> IDE - this didn't happen on 2.4.18.  It seems to happen on all more recent
> kernels.  UML seems to trigger it, especially on UML servers.

Maybe not related, but I see 5 second "pauses" on a RAID-0+1 (software
RAID, Seagate 80G disks, Promise Ultra66+Ultra133 controllers, dual x86)
file server here.

I suspected NFS problems (looks like someone re-wrote NFS between 2.4.18
and 2.4.20-rc1) - but this is *not* the case.  The pauses happen on
locally running processes as well.

It seems to correlate well with a remote host delivering a mail (using
maildir over NFS) - but this is not the only situation in which it
happens.

Everything using disk, both on NFS clients and locally running
processes, just pause. Five seconds after everything is like it never
happened.

Nothing in dmesg.

Didn't happen in 2.4.18, happens in 2.4.20-rc1.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
