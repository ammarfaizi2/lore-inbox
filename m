Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262375AbULOQMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbULOQMd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 11:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbULOQMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 11:12:33 -0500
Received: from mail.suse.de ([195.135.220.2]:1694 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262375AbULOQMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 11:12:19 -0500
Date: Wed, 15 Dec 2004 17:12:18 +0100
From: Andi Kleen <ak@suse.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, pavel@suse.cz, discuss@x86-64.org,
       gordon.jin@intel.com
Subject: Re: unregister_ioctl32_conversion and modules. ioctl32 revisited.
Message-ID: <20041215161218.GA26772@wotan.suse.de>
References: <20041215065650.GM27225@wotan.suse.de> <20041215082917.GW27225@wotan.suse.de> <20041215114246.GB12187@mellanox.co.il> <200412151446.01913.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412151446.01913.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't really understand how this should deal with drivers that have
> both generic and private ioctl conversion handlers. E.g. 
> drivers/s390/block/dasd*.c want to go through the handlers in 
> fs/compat_ioctl.c for stuff like BLKGETSIZE, while it also allows
> third party modules to dynamically register additional ioctls.
> See drivers/s390/block/dasd_cmb.c for an example, I think EMC are
> doing something similar to support their drives.
> 
> If the dasd driver now implements an ioctl_compat() method, who will
> call the standard conversion handlers?

How about just calling back to a special function from these
special ioctl handlers?

-Andi

