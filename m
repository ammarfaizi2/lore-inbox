Return-Path: <linux-kernel-owner+w=401wt.eu-S932580AbWLMAIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580AbWLMAIx (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 19:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbWLMAIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 19:08:53 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4968 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932580AbWLMAIx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 19:08:53 -0500
Date: Wed, 13 Dec 2006 01:09:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove the broken SCSI_SEAGATE driver
Message-ID: <20061213000902.GD28443@stusta.de>
References: <20061212162238.GR28443@stusta.de> <1165966274.5903.56.camel@mulgrave.il.steeleye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165966274.5903.56.camel@mulgrave.il.steeleye.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2006 at 05:31:14PM -0600, James Bottomley wrote:
> On Tue, 2006-12-12 at 17:22 +0100, Adrian Bunk wrote:
> > The SCSI_SEAGATE driver has:
> > - already been marked as BROKEN in 2.6.0 three years ago and
> > - is still marked as BROKEN.
> > 
> > Drivers that had been marked as BROKEN for such a long time seem to be
> > unlikely to be revived in the forseeable future.
> > 
> > But if anyone wants to ever revive this driver, the code is still
> > present in the older kernel releases.
> 
> Would you care to explain the rationale for this, please.  If the driver
> had been riddled with errors and compilation problems, I might have
> acquiesced, but now I come to look it over, it seems structurally
> reasonably OK (we certainly have non-BROKEN worse ones) plus it compiles
> fine.  So I'm wondering why it's marked broken in the first place.
> 
> Since it was your original patch:
> 
> Author: Adrian Bunk <bunk@fs.tum.de>
> Date:   Mon Sep 1 19:22:52 2003 -0700
> 
>     [PATCH] Mark more drivers BROKEN{,ON_SMP}
>     
>     - let more drivers that don't compile depend on BROKEN
>     - MTD_BLKMTD is fixed, remove the dependency on BROKEN
>     - let all drivers that don't compile on SMP (due to cli/sti usage)
>       depend on a BROKEN_ON_SMP that is only defined if !SMP || BROKEN
>     - #include interrupt.h for dummy cli/sti/... in two files to fix the
>       UP compilation of these files
>     
>     I marked only drivers that are broken for a long time and where I don't
>     know about existing fixes with BROKEN or BROKEN_ON_SMP.
> 
> I'd like to know why it was marked BROKEN in the first place.


There must have been a compile error that has since been fixed, but I 
don't remember the details of this specific driver and I don't have 
such old compile logs anymore.


> Thanks,
> 
> James

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

