Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315213AbSFELFy>; Wed, 5 Jun 2002 07:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315276AbSFELFx>; Wed, 5 Jun 2002 07:05:53 -0400
Received: from mail.zmailer.org ([62.240.94.4]:13263 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S315213AbSFELFw>;
	Wed, 5 Jun 2002 07:05:52 -0400
Date: Wed, 5 Jun 2002 14:05:52 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] "laptop mode"
Message-ID: <20020605140552.U18899@mea-ext.zmailer.org>
In-Reply-To: <200206051340.47261.root@johnny> <Pine.GSO.4.05.10206051157190.8783-100000@mausmaki.cosy.sbg.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2002 at 12:02:07PM +0200, Thomas 'Dent' Mirlacher wrote:
> --snip/snip
 [snip/snip the Cc: list too..]
> > What parts of the filesystem needs to be accessed very often? I think, that placing var on a ramdisk, that is mirrored on the hd and is synced every 30 minutes, would be a good solution.
> > I think, that we should add a sysrq key to save the ramdisk to the disk. Is there a similar project, that loads an image into a ramdisk at mount, and writes it back at unmount?
> 
> a nice thing for that would be to have unionfs (al viro seems to work 
> on that?), and mount a ramdisk ontop of your var directory (or shichever
> directory is a hotspot. - or mount it over your whole harddrive, doing 
> COW on the ramdisk. and once the disk reaches a critical high-water-mark
> sync the whole set to the underlaying "real" filesystem.
> 
> any comments?

   Things like logfile appending...
   (Do I need to say more ?)

   I myself mount laptop filesystem with  noatime  option.
   Also killing cron/at helps somewhat.

> 	tm

/Matti Aarnio
