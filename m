Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbUKOXRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbUKOXRa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 18:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbUKOXRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 18:17:30 -0500
Received: from fep19.inet.fi ([194.251.242.244]:36793 "EHLO fep19.inet.fi")
	by vger.kernel.org with ESMTP id S261601AbUKOXRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 18:17:09 -0500
Date: Tue, 16 Nov 2004 01:17:05 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: vm-pageout-throttling.patch: hanging in throttle_vm_writeout/blk_congestion_wait
Message-ID: <20041115231705.GE6654@m.safari.iki.fi>
Mail-Followup-To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20041115012620.GA5750@m.safari.iki.fi> <Pine.LNX.4.44.0411152140030.4171-100000@localhost.localdomain> <20041115223709.GD6654@m.safari.iki.fi> <200411151451.21671.ryan@spitfire.gotdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411151451.21671.ryan@spitfire.gotdns.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2004 at 02:51:19PM -0800, Ryan Cumming wrote:
> On Monday 15 November 2004 14:37, Sami Farin wrote:
> > I know it's a "nicer" idea to use some partition for the swap
> > instead of a file on reiserfs, but I created too small swap partitions
> > originally and I can't(/bother?) resize the other partitions.
> > And sometimes some memhog forces me to add even more swap.
> 
> He's not suggesting you use a swap partition; he's suggesting you swapon the 
> file directly without using the loopback device, ie:
> 
> swapon /path/to/file/on/reiserfs
> 
> This allows the kernel to perform certain optimizations and removes the 
> overhead of the loopback device.

It also removes encryption, which I wish to have.

-- 
