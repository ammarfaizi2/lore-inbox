Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263432AbTJBSGu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 14:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbTJBSGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 14:06:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61316 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263426AbTJBSGt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 14:06:49 -0400
Date: Thu, 2 Oct 2003 19:06:45 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-hfsplus-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] new HFS(+) driver
Message-ID: <20031002180645.GG7665@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0310021029110.17548-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310021029110.17548-100000@serv>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 02, 2003 at 10:37:32AM +0200, Roman Zippel wrote:
> The HFS+ driver has a number of improvements and fixes:
> - blocks are now preallocated.
> - allocation file is now in the page cache too
> - better extent caching
> - btrees are now able to grow arbitrarily
> - allocation block size can now be larger than a page
> - actual fs block size is adjusted to avoid alignment problems
> - cdrom session/partition support (note that this is a crutch and has 
>   problems)
> 
> This is basically the version I'd liked to get merged into 2.6 (minus lots 
> of ifdefs and some debug prints). You can find the driver at
> http://www.ardistech.com/hfsplus/

What the devil are you doing with get_gendisk() in there?  Neither 2.4
nor 2.6 should be messing with it.
