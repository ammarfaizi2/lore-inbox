Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263865AbUDTSvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263865AbUDTSvU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 14:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263555AbUDTSvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 14:51:20 -0400
Received: from colin2.muc.de ([193.149.48.15]:8 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263865AbUDTSvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 14:51:18 -0400
Date: 20 Apr 2004 20:51:12 +0200
Date: Tue, 20 Apr 2004 20:51:12 +0200
From: Andi Kleen <ak@muc.de>
To: Terence Ripperda <tripperda@nvidia.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, eich@suse.de
Subject: Re: PAT support
Message-ID: <20040420185112.GB76023@colin2.muc.de>
References: <20040417004217.GC72227@colin2.muc.de> <20040419225456.GM632@hygelac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040419225456.GM632@hygelac>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2004 at 05:54:57PM -0500, Terence Ripperda wrote:
> > I think I prefer the do/undo model instead of push/pop.
> > That can work with cmaps too. PAGE_KERNEL means no cmap,
> > PAGE_KERNEL_WC and PAGE_KERNEL_NOCACHE get a cmap.
> 
> but then what is the point of cmap? I would expect a mix of WC and UC mappings to be much less dangerous than a mix of WC/UC and WB. perhaps my mindset is wrong, but it seems allowing ioremap to request a cached mapping is important, and that if that mapping was followed by ioremap_nocached or ioremap_wrcomb, that these subsequent calls should fail.

Hmm, you're right. push/pop is probably better for io-mappings, otherwise
we cannot catch existing mappings.  This will be needed for user mmap
too.

Ignore my previous suggestion on that then please. Sorry for the noise.


-Andi
