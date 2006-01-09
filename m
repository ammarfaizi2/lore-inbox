Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbWAIOSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWAIOSr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 09:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWAIOSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 09:18:47 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:2878 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932257AbWAIOSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 09:18:46 -0500
Date: Mon, 9 Jan 2006 15:20:36 +0100
From: Jens Axboe <axboe@suse.de>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15 cfq oops
Message-ID: <20060109142036.GW3389@suse.de>
References: <20060106201928.GI4595@redhat.com> <20060109105800.GT3389@suse.de> <20060109171550.6e59c30c.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060109171550.6e59c30c.vsu@altlinux.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09 2006, Sergey Vlasov wrote:
> On Mon, 9 Jan 2006 11:58:01 +0100 Jens Axboe wrote:
> 
> [skip]
> > I've merged this up for 2.6.16-rc inclusion, probably should go to
> > stabel as well.
> > 
> > ---
> > 
> > [PATCH] Kill blk_attempt_remerge()
> > 
> > It's a bad interface, and it's always done too late. Remove it.
> > 
> > Signed-off-by: Jens Axboe <axboe@suse.de>
> > 
> [skip]
> > diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> > index 1539603..2e44d81 100644
> > --- a/drivers/cdrom/cdrom.c
> > +++ b/drivers/cdrom/cdrom.c
> > @@ -426,7 +426,7 @@ int register_cdrom(struct cdrom_device_i
> >  		cdi->exit = cdrom_mrw_exit;
> >  
> >  	if (cdi->disk)
> > -		cdi->cdda_method = CDDA_BPC_FULL;
> > +		cdi->cdda_method = CDDA_BPC_SINGLE;
> >  	else
> >  		cdi->cdda_method = CDDA_OLD;
> 
> Does not seem to be related to the rest of patch...

Indeed, dirty git tree...

-- 
Jens Axboe

