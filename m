Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263125AbVCDUcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbVCDUcg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 15:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbVCDUWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 15:22:53 -0500
Received: from waste.org ([216.27.176.166]:20631 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263100AbVCDUMR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:12:17 -0500
Date: Fri, 4 Mar 2005 12:11:53 -0800
From: Matt Mackall <mpm@selenic.com>
To: Richard Fuchs <richard.fuchs@inode.info>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: slab corruption in skb allocs
Message-ID: <20050304201153.GR3163@waste.org>
References: <42283093.7040405@inode.info> <20050304035309.1da7774e.akpm@osdl.org> <42285354.5090900@inode.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42285354.5090900@inode.info>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 01:23:48PM +0100, Richard Fuchs wrote:
> Andrew Morton wrote:
> 
> >I guess it could be hardware.  But given that disabling DMA _causes_ the
> >problem, rather than fixes it, it seems unlikely.
> >
> >Could you enable CONFIG_DEBUG_PAGEALLOC in .config and see it that triggers
> >an oops?
> 
> by now, i could reproduce this on two different machines with quite 
> different hardware, while a third doesn't seem to show those symptoms. 
> on the second machine, i got the corruption errors from the slab 
> debugger mostly from the disk access alone, the network traffic was only 
> minimal (but still present). i was doing write operations on the hdd in 
> this test.
> 
> kernel 2.6.7 doesn't show this behavior, while all kernels from 2.6.9 
> and up do. (i didn't test 2.6.8.x).
> 
> as for DEBUG_PAGEALLOC... when i enable this option, the errors from 
> DEBUG_SLAB magically disappear. however, my ssh session got disconnected 
> once while doing the disk access with the message:
> 
> Received disconnect from 195.58.172.154: 2: Bad packet length 4239103034.

Send the output of ethtool, please. This tends to be checksum
offloading not working as it should or the like. Can you repeat this
with bulk ssh traffic?

-- 
Mathematics is the supreme nostalgia of our time.
