Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266297AbSKUCfQ>; Wed, 20 Nov 2002 21:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266307AbSKUCfQ>; Wed, 20 Nov 2002 21:35:16 -0500
Received: from packet.digeo.com ([12.110.80.53]:40364 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266297AbSKUCfQ>;
	Wed, 20 Nov 2002 21:35:16 -0500
Message-ID: <3DDC4807.D1349FC7@digeo.com>
Date: Wed, 20 Nov 2002 18:42:15 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Atwood <mra@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to invalidate the filesystem buffer cache?
References: <200211210220.15856.rizsanyi@myrealbox.com> <m365urfzat.fsf@marka.linux.digeo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Nov 2002 02:42:16.0065 (UTC) FILETIME=[9A611F10:01C29107]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Atwood wrote:
> 
> Like the question says, is there a way to invalidate the whole buffer
> cache at once?
> 

"There is no buffer cache".

There's a pagecache, which caches the contents of files and block devices.
You can invalidate the block device pagecache with `blockdev --flushbufs' but
there is no interface for invalidating the pagecache of regular files.

Allocating and then freeing a ton of anonymous memory, then running a
swapoff/swapon cycle might suit.
