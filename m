Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262888AbTC0Goz>; Thu, 27 Mar 2003 01:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262890AbTC0Goz>; Thu, 27 Mar 2003 01:44:55 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:63662 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262888AbTC0Goy>;
	Thu, 27 Mar 2003 01:44:54 -0500
Date: Thu, 27 Mar 2003 07:54:17 +0100
From: Jens Axboe <axboe@suse.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reduce stack in cdrom/optcd.c
Message-ID: <20030327065417.GM30908@suse.de>
References: <20030326121250.56b4d62a.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030326121250.56b4d62a.rddunlap@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26 2003, Randy.Dunlap wrote:
> 
> (resend; was lost last night)
> 
> 
> > From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> > 
> > On Sat, 2003-03-22 at 06:51, Randy.Dunlap wrote:
> > > Hi,
> > > 
> > > This reduces stack usage in drivers/cdrom/optcd.c by
> > > dynamically allocating a large (> 2 KB) buffer.
> > > 
> > > Patch is to 2.5.65.  Please apply.
> > 
> > This loosk broken. You are using GFP_KERNEL memory allocations on the
> > read path of a block device. What happens if the allocation fails 
> > because we need memory
> > 
> > Surely that buffer needs to be allocated once at open and freed on close
> > ?
> > --
> 
> 
> Alan, Jens, anybody else-
> 
> Does this pass?

Yes, looks much better.

-- 
Jens Axboe

