Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbTLWQkP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 11:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbTLWQkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 11:40:15 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:14994 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262139AbTLWQjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 11:39:13 -0500
Date: Tue, 23 Dec 2003 17:39:13 +0100
From: Jens Axboe <axboe@suse.de>
To: Pascal Schmidt <der.eremit@email.de>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-mm1
Message-ID: <20031223163913.GC23184@suse.de>
References: <Pine.LNX.4.44.0312231732001.926-100000@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312231732001.926-100000@neptune.local>
X-OS: Linux 2.4.23aa1-axboe i686
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23 2003, Pascal Schmidt wrote:
> 
> On Tue, 23 Dec 2003 06:20:14 +0100, you wrote in linux.kernel:
> 
> >> +atapi-mo-support.patch
> >> 
> >>  Fix support for ATAPI MO drives (needs updating to reflect the changes 
> >>  in mt-ranier-support.patch).
> > Since the atapi-mo patch is mine, is there something I need to do?
> 
> I figured it out. ;) This small additional patch on top of mm1 is
> needed to get MO write support to work.
> 
> 
> --- linux-2.6.0-mm1/drivers/cdrom/cdrom.c	Tue Dec 23 17:26:27 2003
> +++ linux-2.6.0-mm1-mo/drivers/cdrom/cdrom.c	Tue Dec 23 17:11:50 2003
> @@ -708,6 +708,8 @@ static int cdrom_open_write(struct cdrom
>  		ret = cdrom_mrw_open_write(cdi);
>  	else if (CDROM_CAN(CDC_DVD_RAM))
>  		ret = cdrom_dvdram_open_write(cdi);
> +	else if (CDROM_CAN(CDC_MO_DRIVE))
> +		ret = 0;

Still needs cleanups, as mentioned in the other mail. Let me dig out
the laptop and fix it up for posting.

Jens

