Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263705AbUDUVGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263705AbUDUVGN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 17:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263708AbUDUVGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 17:06:12 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:59147 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263705AbUDUVFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 17:05:43 -0400
Date: Wed, 21 Apr 2004 22:05:41 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Andrew Zabolotny <zap@homelink.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: drivers/input/tsdev.c patch
In-Reply-To: <20040417221638.5d035e04.zap@homelink.ru>
Message-ID: <Pine.LNX.4.44.0404212205330.10680-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Its being pushed forward.


On Sat, 17 Apr 2004, Andrew Zabolotny wrote:

> Hello!
> 
> I've tried to use the tsdev.c driver to emulate the old-style Compaq
> touchscreen protocol on a newer kernel (I'm working on kernel 2.6.3-hh2,
> handhelds.org' branch). But I've observed that the driver is half-complete,
> contains some very bad bugs and lacks features to make it useable.
> 
> To avoid clobbering this high-volume list, I've posted my patch at
> http://zap.eltrast.ru/data/tsdev.diff (~12K). Here's what it tries to achieve:
> 
> - Not only emulates the protocol of the old /dev/h3600_ts device (via
> /dev/input/ts[0-7]), but also creates an additional device node
> /dev/input/tsraw[0-7] which emulates the protocol of the old h3600_tsraw
> device. Some old applications needs one, some another, some both.
> 
> - Support the ioctls for setting the calibration parameters. The default
> calibration matrix is computed from the xres,yres parameters (the old
> behaviour), however this is not enough for a good translation from touchscreen
> space to screen space.
> 
> - Fixed a old bug in tsdev that made the driver basically unusable for any
> serious work. The bug was that if old coordinates were X1,Y1 and new
> coordinates are X2,Y2, the driver would output to user space a series of
> three events with coordinates: X1,Y1 X2,Y1 X2,Y2. This happened not only
> with coordinates, but with pressure too. Thus the output of the device was
> pretty much unusable. I doubt someone was able to use the old tsdev device
> successfuly, if someone did, tell me how.
> 
> --
> Greetings,
>    Andrew
> 
> P.S. Please cc: to me while replying since I'm not subscribed to this list due
> to its high volume. If a discussion would start on this topic, I'll subscribe
> but I don't think so due to limited useability of the old driver.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

