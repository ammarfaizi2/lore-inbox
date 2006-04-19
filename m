Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWDSNTB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWDSNTB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 09:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWDSNTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 09:19:01 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29507 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750736AbWDSNTA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 09:19:00 -0400
Date: Wed, 19 Apr 2006 15:19:16 +0200
From: Jens Axboe <axboe@suse.de>
To: erich <erich@areca.com.tw>
Cc: dax@gurulabs.com, billion.wu@areca.com.tw, Al Viro <viro@ftp.linux.org.uk>,
       Andrew Morton <akpm@osdl.org>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>,
       Chris Caputo <ccaputo@alt.net>
Subject: Re: new Areca driver in 2.6.16-rc6-mm2 appears to be broken
Message-ID: <20060419131916.GH614@suse.de>
References: <Pine.LNX.4.64.0603212310070.20655@nacho.alt.net> <007701c653d7$8b8ee670$b100a8c0@erich2003> <Pine.LNX.4.64.0603301542590.19680@nacho.alt.net> <004a01c65470$412daaa0$b100a8c0@erich2003> <20060330192057.4bd8c568.akpm@osdl.org> <20060331074237.GH14022@suse.de> <002901c65e33$ceac9e00$b100a8c0@erich2003> <20060419104009.GB614@suse.de> <003301c663b3$6bfcc020$b100a8c0@erich2003>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003301c663b3$6bfcc020$b100a8c0@erich2003>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19 2006, erich wrote:
> Dear Jens Axboe,
> 
> About your request :
> 
> ******************************************
> ** boot with driver MAX_XFER_SECTORS 4096
> ******************************************
> #mkfs.ext2 /dev/sda1
> #mount /dev/sda1 /mnt/sda1
> #cp /root/aa /mnt/sda1/
> #reboot
> ******************************************
> ** boot with driver MAX_XFER_SECTORS 512
> ******************************************
> #fsck /dev/sda1
> /dev/sda1:clean,.............

fsck -fy /dev/sda1

You need to force a full check, the partition should be clean when you
do this so fsck wont do anything.


-- 
Jens Axboe

