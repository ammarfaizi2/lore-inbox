Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312590AbSDQIAX>; Wed, 17 Apr 2002 04:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313826AbSDQIAX>; Wed, 17 Apr 2002 04:00:23 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:53261 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S312590AbSDQIAV>;
	Wed, 17 Apr 2002 04:00:21 -0400
Date: Wed, 17 Apr 2002 10:00:11 +0200
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Gerard Beekmans <gerard@linuxfromscratch.org>,
        linux-kernel@vger.kernel.org,
        Martin Dalecki <dalecki@evision-ventures.com>
Subject: Re: make xconfig fails in 2.5.8 kernel, trivial change to fix it
Message-ID: <20020417080011.GW1097@suse.de>
In-Reply-To: <20020416224524.GA5651@gwaihir.linuxfromscratch.org> <Pine.LNX.4.10.10204161902220.11230-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16 2002, Andre Hedrick wrote:
> > Hi,
> > 
> > There is a very trivial problem in line 52 of the drivers/ide/Config.in
> > file. It reads:
> > 	if [ $CONFIG_BLK_DEV_IDE_TCQ_DEFAULT != "n" ]; then
> > 
> > 'make xconfig' fails on this saying that it is a bad if condition:
> > 
> > 	cat header.tk >> ./kconfig.tk
> > 	./tkparse < ../arch/i386/config.in >> kconfig.tk
> > 	drivers/ide/Config.in: 52: bad if condition
> > 
> > It is easily fixed by enclosing $CONFIG_BLK_DEV_IDE_TCQ_DEFAULT in double
> > quotes. There are other if conditions in this same file that do have those
> > quotes and Tk doesn't complain about them.
> > 
> > Does anybody use xconfig these days anyways since nobody apprarently has
> > noticed it before? I saw this broken a few 2.5 releases ago too but never
> > got around looking into it.

The problem is new to 2.5.8, since that very option did not exist in
earlier releases. And it's fixed in the latest ide patch sets.

-- 
Jens Axboe

