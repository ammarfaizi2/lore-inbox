Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265670AbSKTDkv>; Tue, 19 Nov 2002 22:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265677AbSKTDkv>; Tue, 19 Nov 2002 22:40:51 -0500
Received: from ip68-4-86-174.oc.oc.cox.net ([68.4.86.174]:41711 "EHLO
	ip68-4-86-174.oc.oc.cox.net") by vger.kernel.org with ESMTP
	id <S265670AbSKTDkt>; Tue, 19 Nov 2002 22:40:49 -0500
Date: Tue, 19 Nov 2002 19:47:53 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Manish Lachwani <manish@Zambeel.com>
Cc: "'Steven Timm'" <timm@fnal.gov>, linux-kernel@vger.kernel.org
Subject: Re: AMD 760MPX dma_intr: error=0x40 { UncorrectableError }
Message-ID: <20021120034753.GA22370@ip68-4-86-174.oc.oc.cox.net>
References: <233C89823A37714D95B1A891DE3BCE5202AB1952@xch-a.win.zambeel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <233C89823A37714D95B1A891DE3BCE5202AB1952@xch-a.win.zambeel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 04:08:22PM -0800, Manish Lachwani wrote:
> I have seen this errors on Seagate ST380021A 80 GB drive on a large scale in
> our storage systems that make use of 3ware controllers. Seagate claims the
> following reasons:
> 
> 1. Weak Power supply
> 2. tempeature and heat
> 3. vibration

You might want to pay particular attention to #2. See below.

> Although, the maxtor 160 GB drives do not show such problems at all. Such
> problems can be eliminated though. From the SMART data, get the bad sectors
> and remap them by writing to the raw device. Those pending sectors will get
> remapped. However, the problems will persist with these drives. In our
> boxes, the operating temperature is abt 55 C ...

Unless they're really really new, the 160GB Maxtor drives are 5400RPM
so they put out far less heat. (The fact that the Maxtors are ball-bearing,
vs. the Seagates' fluid bearings, also helps in this regard --
fluid-bearing drives tend to dissipate more heat.)

55 C is technically within the Seagate specs, but it's arguably a bit on
the high side. If possible, it might be interesting to bring it the
temperature down several degrees and see if the reliability improves.

-Barry K. Nathan <bnathan@math.uci.edu>
