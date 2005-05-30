Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbVE3GNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbVE3GNT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 02:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVE3GNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 02:13:18 -0400
Received: from brick.kernel.dk ([62.242.22.158]:55427 "EHLO
	nelson.home.kernel.dk") by vger.kernel.org with ESMTP
	id S261526AbVE3GGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 02:06:47 -0400
Date: Mon, 30 May 2005 08:07:50 +0200
From: Jens Axboe <axboe@suse.de>
To: Michael Thonke <iogl64nx@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Playing with SATA NCQ
Message-ID: <20050530060749.GD7054@suse.de>
References: <20050526140058.GR1419@suse.de> <429793C8.8090007@gmail.com> <42979C4F.8020007@pobox.com> <42979FA3.1010106@gmail.com> <20050528121258.GA17869@suse.de> <4299BD23.6010004@gmail.com> <20050529190259.GA29770@suse.de> <429A2238.8010604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429A2238.8010604@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29 2005, Michael Thonke wrote:
> >Nothing, unfortunately NCQ doesn't provided any way of doing ordered
> >tags. The only tunable is the queue_depth, you can set that anywhere
> >between 1 and 30.
> >
> >  
> >
> So way my drive got default 30 as queue_depth on AHCI as you mentoined
> in the next mail
> 2-4 should be suitable and enough/normal?

Yes, 30 will be default for basically anyone as ahci now advertises a
max depth of 30 and the drives typically all support a depth of 32. The
minimum value of those two is used.

Whether 2-4 is 'enough' depends on your workload. But usually 2-4 is
enough to get a nice speedup on heavier io, while still getting you good
latencies on the individual io.

-- 
Jens Axboe

