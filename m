Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313904AbSDJWH0>; Wed, 10 Apr 2002 18:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313909AbSDJWHZ>; Wed, 10 Apr 2002 18:07:25 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:25839
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S313904AbSDJWHZ>; Wed, 10 Apr 2002 18:07:25 -0400
Date: Wed, 10 Apr 2002 15:09:39 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: RAID superblock confusion
Message-ID: <20020410220939.GF23513@matchmail.com>
Mail-Followup-To: Richard Gooch <rgooch@ras.ucalgary.ca>,
	Andreas Dilger <adilger@clusterfs.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200204101533.g3AFXwS09100@vindaloo.ras.ucalgary.ca> <20020410184010.GC3509@turbolinux.com> <200204101924.g3AJOp113305@vindaloo.ras.ucalgary.ca> <20020410193812.GE3509@turbolinux.com> <200204102037.g3AKbmT14222@vindaloo.ras.ucalgary.ca> <20020410213645.GE23513@matchmail.com> <200204102139.g3ALd9m15133@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2002 at 03:39:09PM -0600, Richard Gooch wrote:
> Mike Fedyk writes:
> > On Wed, Apr 10, 2002 at 02:37:48PM -0600, Richard Gooch wrote:
> > > 
> > > The device is set up (i.e. SCSI host driver is loaded) long before I
> > > do raidstart /dev/md/0
> > 
> > But kernel auto-detection doesn't depend on the raidstart command.  If
> > things are setup correctly, you can remove that from your init scripts.
> 
> I'm not (explicitely) using auto-detection. When I insmod the raid0
> module, there are no messages about finding devices. All I get is:
> md: raid0 personality registered as nr 2
> 
> Only when I run raidstart do I get kernel messages about the devices.
> 
> In any case, I should be able to move my devices around (especially
> if /etc/raidtab is still correct), whether or not autostart is
> running. The behaviour I'm observing is a bug (I assume it's not a
> mis-feature, since the raidstart man page tells me that moving devices
> around should be safe).

Ehh, I ran into this a while ago.  When you compile raid as modules it
doesn't use the raid superblocks for anything except for verification.  I
took a quick glance at the source and the auto-detect code is ifdefed out if
you compiled as a module.

Ever since I have had raid compiled into my kernels.

Mike
