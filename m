Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbTCTCBs>; Wed, 19 Mar 2003 21:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261292AbTCTCBs>; Wed, 19 Mar 2003 21:01:48 -0500
Received: from taka.swcp.com ([198.59.115.12]:57611 "EHLO taka.swcp.com")
	by vger.kernel.org with ESMTP id <S261290AbTCTCBr>;
	Wed, 19 Mar 2003 21:01:47 -0500
Date: Wed, 19 Mar 2003 19:12:00 -0700
From: Trammell Hudson <hudson@osresearch.net>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: initramfs fails for medium sized cpio archives
Message-ID: <20030320021200.GB6688@osbox.osresearch.net>
References: <20030319011116.GK8263@osbox.osresearch.net> <20030318180350.2acdfcc7.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030318180350.2acdfcc7.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 18, 2003 at 06:03:50PM -0800, Andrew Morton wrote:
> Trammell Hudson <hudson@osresearch.net> wrote:
> > I've added a sanity check in get_dirty_limits() that initialized
> > total_pages if it is still zero and things seem to work, but
> > should some of the memory management modules be initialized first?
> 
> This is fixed in 2.5.65, with the below patch.

Thanks.  I had missed it in the 2.5.65 change log since it didn't
mention initramfs, but now see the "Early page_writeback initialization"
entry.  The patch does fix the divide by zero error.

> [...] Neat.  Nice to see it working.

I'm working on a custom system that can only send a single file to
the nodes (over a custom interconnect) when they boot, so neither
tftping a ramdisk or a PXE boot loader would work for me.  Having
the initramfs image be bundled into the kernel is a real life saver.

Trammell
-- 
  -----|----- hudson@osresearch.net                   W 240-283-1700
*>=====[]L\   hudson@rotomotion.com                   M 505-463-1896
'     -'-`-   http://www.swcp.com/~hudson/                    KC5RNF

