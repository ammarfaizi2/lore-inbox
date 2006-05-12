Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWELVU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWELVU5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 17:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWELVU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 17:20:57 -0400
Received: from cantor.suse.de ([195.135.220.2]:2993 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751196AbWELVU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 17:20:56 -0400
Date: Fri, 12 May 2006 14:18:53 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Erik Mouw <erik@harddisk-recovery.com>,
       Or Gerlitz <or.gerlitz@gmail.com>, linux-scsi@vger.kernel.org,
       axboe@suse.de, Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2.6.17-git] kmem_cache_create: duplicate cache scsi_cmd_cache
Message-ID: <20060512211853.GB26708@suse.de>
References: <20060511151456.GD3755@harddisk-recovery.com> <15ddcffd0605112153q57f139a1k7068e204a3eeaf1f@mail.gmail.com> <20060512171632.GA29077@harddisk-recovery.com> <Pine.LNX.4.64.0605121024310.3866@g5.osdl.org> <1147456038.3769.39.camel@mulgrave.il.steeleye.com> <1147460325.3769.46.camel@mulgrave.il.steeleye.com> <Pine.LNX.4.64.0605121209020.3866@g5.osdl.org> <20060512203850.GC17120@flint.arm.linux.org.uk> <Pine.LNX.4.64.0605121346060.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605121346060.3866@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2006 at 01:50:46PM -0700, Linus Torvalds wrote:
> On Fri, 12 May 2006, Russell King wrote:
> > Can we revert the patch which broke the MMC/SD layer - the one which
> > added the mount/unmount hotplug events as well then.
> > 
> > That way we get back to a working MMC/SD layer as well as a working
> > SCSI layer.
> 
> That's certainly the logical fix - push the pain up the chain to the 
> person who introduced it. Which commit is that, do you know?
> 
> Really, the added ref-count should be gotten by whoever holds on to the 
> thing, and it sounds like it's the hotplug event that caused this and 
> should have held on to its hotplug reference.
> 
> Greg added to the Cc: list in case he already knows off-hand which commit 
> it is..

No, I don't know, that's why I just asked :)

And this bug doesn't have anything to do with why my mmc/sd cards are
suddenly not showing up at all anymore in my laptop, right?  I need to
track that regression from 2.6.17-rc1 down...

thanks,

greg k-h
