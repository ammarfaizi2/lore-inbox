Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264694AbTIJIeq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 04:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264721AbTIJIeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 04:34:46 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:65435 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264694AbTIJId4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 04:33:56 -0400
Date: Wed, 10 Sep 2003 10:33:51 +0200
From: Jens Axboe <axboe@suse.de>
To: Markus Plail <linux-kernel@gitteundmarkus.de>
Cc: linux-kernel@vger.kernel.org, ed.sweetman@wmich.edu
Subject: Re: atapi write support? No
Message-ID: <20030910083351.GK20800@suse.de>
References: <3F5E2BA4.60704@wmich.edu> <20030909195428.GQ4755@suse.de> <3F5E338F.2000007@wmich.edu> <87brttemlk.fsf@gitteundmarkus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87brttemlk.fsf@gitteundmarkus.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09 2003, Markus Plail wrote:
> On Tue, 09 Sep 2003, Ed Sweetman wrote:
> 
> >Jens Axboe wrote: 
> >> On Tue, Sep 09 2003, Ed Sweetman wrote:
> > There is no other information needed.
> 
> There is...
> 
> > By use atapi write support i mean Get it to do anything besides error
> > out reporting that it cant access the drive. If you can query the
> > drive much less actually write anything to it using the ATAPI
> > interface than that's more than i've been able to do.
> > 
> > for example   cdrecord dev=ATAPI:1,0,0 checkdisk
> 
> ATAPI: is most likely wrong for what you want to do. It's meant for
> notebooks (PCATA or something).
> If you just want to get rid of ide-scsi, you have to use dev=/dev/hdX in
> cdrecord.

That ATAPI support is slow and unreliable, Joerg was a fool to merge it.
It shold _not_ be used! Using dev=/dev/hdX is required for SG_IO in 2.6
right now, other methods should be usable in the future. So Markus is
dead right.

> PS: A little change in attitude towards people who are willing to help
> you wouldn't be the worst idea. IMHO of course.

Indeed, and doing just a little work before showing up with an attitude
would be even better. It's amazing how people asking for help think they
can define the rules as well.

-- 
Jens Axboe

