Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265292AbTLRTeW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 14:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265294AbTLRTeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 14:34:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:36270 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265292AbTLRTeQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 14:34:16 -0500
Date: Thu, 18 Dec 2003 20:34:14 +0100
From: Jens Axboe <axboe@suse.de>
To: Milos Prudek <milos.prudek@tiscali.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Mount Rainier in 2.6
Message-ID: <20031218193414.GJ2069@suse.de>
References: <3FE16489.9060006@tiscali.cz> <20031218083530.GP2495@suse.de> <20031218114000.GB2069@suse.de> <3FE200CA.2080705@tiscali.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FE200CA.2080705@tiscali.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 18 2003, Milos Prudek wrote:
> 
> >Here's a patch, it's received a little testing. Let me know if it works
> >for you. I'm also attaching a slightly updated cdmrw tool.
> 
> Patch applied successfully. Compilation failed. This is with the default 
> kernel config (2.6.0 config as shipped). The only change was changing 
> reiserfs from Module to built-in, and removing all other filesystems 
> except ext2 and reiserfs.
> 
> Here's the error:
> 
>   CC [M]  drivers/scsi/sr.o
> drivers/scsi/sr.c:112: error: `CDC_MRW_R' undeclared here (not in a 
> function)
> drivers/scsi/sr.c:112: error: initializer element is not constant
> drivers/scsi/sr.c:112: error: (near initialization for `sr_dops.capability')
> drivers/scsi/sr.c: In function `get_capabilities':
> drivers/scsi/sr.c:770: error: `scsi_CDs' undeclared (first use in this 
> function)
> drivers/scsi/sr.c:770: error: (Each undeclared identifier is reported 
> only once
> drivers/scsi/sr.c:770: error: for each function it appears in.)
> drivers/scsi/sr.c:770: error: `i' undeclared (first use in this function)
> drivers/scsi/sr.c:770: error: `mrw_write' undeclared (first use in this 
> function)
> drivers/scsi/sr.c:696: warning: unused variable `mwr_write'
> make[2]: *** [drivers/scsi/sr.o] Error 1
> make[1]: *** [drivers/scsi] Error 2
> make: *** [drivers] Error 2

Rats, I forgot to test sr. You probably don't have a SCSI mt rainier
drive (I doubt one was ever made), so just disable SCSI CD-ROM support.
I'll be sure to fix this up, thanks.

-- 
Jens Axboe

