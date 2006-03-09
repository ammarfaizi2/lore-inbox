Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbWCIOZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbWCIOZW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 09:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751915AbWCIOZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 09:25:21 -0500
Received: from canuck.infradead.org ([205.233.218.70]:26053 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1750974AbWCIOZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 09:25:21 -0500
Message-ID: <44103A52.3090509@torque.net>
Date: Thu, 09 Mar 2006 09:23:14 -0500
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Justin Piszcz <jpiszcz@lucidpixels.com>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Linux SCSI Error Question with SG Driver
References: <Pine.LNX.4.64.0603090706370.15616@p34>
In-Reply-To: <Pine.LNX.4.64.0603090706370.15616@p34>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz wrote:
> I have a tape library connected to a Linux box here and every once and a
> while I see these in dmesg:
> 
> sg_low_free: bad mem_src=0, buff=0xdb6a8000, rqSz=32768
> sg_low_free: bad mem_src=0, buff=0xdb6b0000, rqSz=28672
> sg_low_free: bad mem_src=0, buff=0xdb738000, rqSz=32768
> sg_low_free: bad mem_src=0, buff=0xdb718000, rqSz=28672
> sg_low_free: bad mem_src=0, buff=0xdb680000, rqSz=32768
> sg_low_free: bad mem_src=0, buff=0xdb678000, rqSz=28672
> sg_low_free: bad mem_src=0, buff=0xdb670000, rqSz=32768
> sg_low_free: bad mem_src=0, buff=0xdb668000, rqSz=28672
> sg_low_free: bad mem_src=0, buff=0xdb660000, rqSz=32768
> sg_low_free: bad mem_src=0, buff=0xdb658000, rqSz=28672
> sg_low_free: bad mem_src=0, buff=0xdb650000, rqSz=32768
> sg_low_free: bad mem_src=0, buff=0xdb648000, rqSz=28672
> 
> Does anyone know what they refer to?

Justin,
That looks like the sg driver in the lk 2.4 series.
When it comes to free up some memory in sg_low_free()
it checks where the memory was sourced from. A
mem_src of 0 is not defined hence the error message.

Hard to say why this happens as the buff addresses
and rqSz values look reasonable.

Doug Gilbert

