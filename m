Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751477AbWCDLfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbWCDLfq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 06:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbWCDLfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 06:35:46 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:17613 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751186AbWCDLfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 06:35:45 -0500
Date: Sat, 4 Mar 2006 14:35:33 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: chris.leech@gmail.com
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH 0/8] Intel I/O Acceleration Technology (I/OAT)
Message-ID: <20060304113533.GA14248@2ka.mipt.ru>
References: <20060303214036.11908.10499.stgit@gitlost.site> <4408C2CA.5010909@garzik.org> <41b516cb0603031439n13e4df4cg8e5b21b606d2b4b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41b516cb0603031439n13e4df4cg8e5b21b606d2b4b8@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sat, 04 Mar 2006 14:35:34 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 02:39:22PM -0800, Chris Leech (christopher.leech@intel.com) wrote:
> > Patch #2 didn't make it.  Too big for the list?
> 
> Could be, it's the largest of the series.  I've attached the gziped
> patch.  I can try and split this up for the future.

How can owner of cb_chan->common.device_node be removed?
It looks like that channels are only allocated (without proper error path) 
and queued into device->common.channels list in
enumerate_dma_channels() in PCI probe callback and no removing at all, only lockless access.
PCI remove callback only calls dma_async_device_unregister() where only
channel's clients are removed.

> - Chris



-- 
	Evgeniy Polyakov
