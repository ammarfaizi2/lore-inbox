Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265554AbRFVWlA>; Fri, 22 Jun 2001 18:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265555AbRFVWkv>; Fri, 22 Jun 2001 18:40:51 -0400
Received: from femail3.sdc1.sfba.home.com ([24.0.95.83]:27582 "EHLO
	femail3.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S265554AbRFVWks>; Fri, 22 Jun 2001 18:40:48 -0400
Date: Fri, 22 Jun 2001 18:40:40 -0400
From: Tom Vier <tmv5@home.com>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.5-ac17
Message-ID: <20010622184040.A765@zero>
In-Reply-To: <20010621222557.A553@zero> <Pine.LNX.4.33.0106220722450.535-100000@mikeg.weiden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0106220722450.535-100000@mikeg.weiden.de>; from mikeg@wen-online.de on Fri, Jun 22, 2001 at 09:06:42AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2001 at 09:06:42AM +0200, Mike Galbraith wrote:
> It's not actually swapping unless you see IO (si/so).  It's allocating
> swap space, but won't send pages out to disk unless there's demand. One

if it's pre-allocation, why does it show up as "used"? "reserved" would be a
better fit.

> benefit of this early allocation is that idle pages will be identified
> prior to demand, and will be moved out of the way sooner.  Watch as

how long can swap allocation possibly take? certainly no where near as long
as a write to disk takes. my box has a half gig of ram, pre-allocation is a
waste of cpu. i never hit swap.

> memory demand rises, and you should see these pages migrating to disk
> and staying there.. buys you more working space.

-- 
Tom Vier <tmv5@home.com>
DSA Key id 0x27371A2C
