Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264953AbSKERHt>; Tue, 5 Nov 2002 12:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264955AbSKERHs>; Tue, 5 Nov 2002 12:07:48 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:24469 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264953AbSKERHh>;
	Tue, 5 Nov 2002 12:07:37 -0500
Date: Tue, 5 Nov 2002 18:14:09 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 vi .config ; make oldconfig not working
Message-ID: <20021105171409.GA1137@suse.de>
References: <20021105165024.GJ13587@suse.de> <3DC7FB11.10209@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC7FB11.10209@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05 2002, Jeff Garzik wrote:
> Jens Axboe wrote:
> 
> >Hi,
> >
> >Can it really be that one cannot edit a config file and run make
> >oldconfig anymore? I'm used to editing an entry in .config and running
> >oldconfig to fix things up, now it just reenables the option. That's
> >clearly a major regression.
> > 
> >
> 
> 
> It works fine for me :)
> 
> I don't think I could survive without the tried and true "vi .config ; 

Well me neither!

> make oldconfig" kernel configurator :)

Hmmm:

axboe@burns:[.]linux-2.5-deadline-rbtree $ grep CONFIG_NFSD_V4 < .config
641:CONFIG_NFSD_V4=y
axboe@burns:[.]linux-2.5-deadline-rbtree $ vi .config
axboe@burns:[.]linux-2.5-deadline-rbtree $ grep CONFIG_NFSD_V4 < .config
641:CONFIG_NFSD_V4=n
axboe@burns:[.]linux-2.5-deadline-rbtree $ make oldconfig
axboe@burns:[.]linux-2.5-deadline-rbtree $ grep CONFIG_NFSD_V4 < .config
641:CONFIG_NFSD_V4=y

-- 
Jens Axboe

