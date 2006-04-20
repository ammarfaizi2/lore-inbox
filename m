Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWDTJis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWDTJis (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 05:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWDTJis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 05:38:48 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:45325 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750731AbWDTJir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 05:38:47 -0400
Date: Thu, 20 Apr 2006 11:39:10 +0200
From: Jens Axboe <axboe@suse.de>
To: erich <erich@areca.com.tw>
Cc: dax@gurulabs.com, billion.wu@areca.com.tw, Al Viro <viro@ftp.linux.org.uk>,
       Andrew Morton <akpm@osdl.org>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>,
       Chris Caputo <ccaputo@alt.net>
Subject: Re: new Areca driver in 2.6.16-rc6-mm2 appears to be broken
Message-ID: <20060420093909.GA13279@suse.de>
References: <20060331074237.GH14022@suse.de> <002901c65e33$ceac9e00$b100a8c0@erich2003> <20060419104009.GB614@suse.de> <003301c663b3$6bfcc020$b100a8c0@erich2003> <20060419131916.GH614@suse.de> <001401c6641d$586bd950$b100a8c0@erich2003> <20060420064249.GO614@suse.de> <001e01c66451$f9a470f0$b100a8c0@erich2003> <20060420082357.GU614@suse.de> <001101c6645d$5c3e9820$b100a8c0@erich2003>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001101c6645d$5c3e9820$b100a8c0@erich2003>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Erich, please stop top posting! I've asked you several times now.

On Thu, Apr 20 2006, erich wrote:
> Dear Dear Jens Axboe,
> 
> I will try debench on the fs with larger xfer size when I enter my Lab. 
> next time.
> In the previous testing I do iometer and bonnie++ bench with ext3 riserfs 
> file system.
> I have test the transfer size from 2K to 5M with random/sequence read/write 
> each term 2 hours.
> When those three testing platforms all have completion.
> There were not any one message appear as this.
> I have done same testing with ext2 512 sectors and all done well.
> I will find the difference of each LBA value , request length between 512 
> sectors and 4096 sectors.

Since you are a hardware vendor, you probably have access to various
hardware analyzers that you can hook up. It seems to be easily
reproducible for you with ext2, why don't you see if you bus traffic
corresponds to what you expect with 4096 xfer size?

Again, I don't think I can help you with this. We have larger
max_sectors drivers out there and experience no problems. I'm fairly
confident that this is a bug in your driver/hardware that you need to
work out.

-- 
Jens Axboe

