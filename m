Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSHGVPR>; Wed, 7 Aug 2002 17:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312558AbSHGVPR>; Wed, 7 Aug 2002 17:15:17 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:21936 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S293203AbSHGVPR>;
	Wed, 7 Aug 2002 17:15:17 -0400
Date: Wed, 7 Aug 2002 23:18:56 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Kurt Garloff <kurt@garloff.de>, Christoph Hellwig <hch@lst.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] conditionally re-enable per-disk stats, convert to seq_file
Message-ID: <20020807211856.GB322@win.tue.nl>
References: <20020806160848.A2413@lst.de> <20020807210225.GD31622@nbkurt.etpnet.phys.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020807210225.GD31622@nbkurt.etpnet.phys.tue.nl>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Tue, Aug 06, 2002 at 04:08:48PM +0200, Christoph Hellwig wrote:
> > This patch against 2.4.20-pre1 converts /proc/partitions to the seq_file
> > interface as in 2.5, makes it report the sard-style extended disk
> > statistics condititional on CONFIG_BLK_STATS and disables the gathering
> > of those totally otherwise to not waste memory and processing power.

But why in /proc/partitions ?
Maybe /proc/partitions can go away eventually with all info available
under driverfs or so. But for the time being, /proc/partitions is used,
and some changes are planned to make identification of the devices
involved easier.
It is really ugly to stuff a lot of garbage into a file just because
it happens to exist already. If you want disk statistics, why not
put it in /proc/diskstatistics?

Andries
