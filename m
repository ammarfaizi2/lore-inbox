Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315415AbSILLsg>; Thu, 12 Sep 2002 07:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315416AbSILLsg>; Thu, 12 Sep 2002 07:48:36 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:61352 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S315415AbSILLsf>;
	Thu, 12 Sep 2002 07:48:35 -0400
Date: Thu, 12 Sep 2002 13:52:22 +0200
From: Jens Axboe <axboe@suse.de>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: andre@linux-ide.org, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.5.34/drivers/ide/ide.c was building list of drives in reverse order
Message-ID: <20020912115222.GA30234@suse.de>
References: <20020912044851.A382@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020912044851.A382@baldur.yggdrasil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12 2002, Adam J. Richter wrote:
> 	ata_attach in linux-2.5.34/drivers/ide/ide.c builds a list of
> IDE drives that do not yet have a device driver bound to them, in case
> ide-disk, ide-scsi, or whatever driver you want to use is not loaded
> yet.
> 
> 	The problem was that ata_attach was adding to the head of
> the list, so the list was being built in reverse order.  So, if
> you had two IDE disks, and ide-disk was a loadable module, the
> devfs entries for the disks would be numbered in reverse (the
> first disk would be /dev/discs/disc1, and the second would be
> /dev/discs/disc0).
> 
> 	The follow patch fixes the problem by changing the relevant
> list_add to list_add_tail.  Incidentally, the generic code
> in drivers/base/ already does it this way.

Patch looks right (its obviously the right thing to do), thanks

-- 
Jens Axboe

