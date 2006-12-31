Return-Path: <linux-kernel-owner+w=401wt.eu-S933131AbWLaPlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933131AbWLaPlL (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 10:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933151AbWLaPlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 10:41:11 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:33835 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933131AbWLaPlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 10:41:09 -0500
Date: Sun, 31 Dec 2006 15:41:03 +0000
From: Christoph Hellwig <hch@infradead.org>
To: David Miller <davem@davemloft.net>
Cc: dmk@flex.com, wmb@firmworks.com, devel@laptop.org,
       linux-kernel@vger.kernel.org, jg@laptop.org
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
Message-ID: <20061231154103.GA7409@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Miller <davem@davemloft.net>, dmk@flex.com, wmb@firmworks.com,
	devel@laptop.org, linux-kernel@vger.kernel.org, jg@laptop.org
References: <20061230.211941.74748799.davem@davemloft.net> <459784AD.1010308@firmworks.com> <45978CE9.7090700@flex.com> <20061231.024917.59652177.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061231.024917.59652177.davem@davemloft.net>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 31, 2006 at 02:49:17AM -0800, David Miller wrote:
> From: David Kahn <dmk@flex.com>
> Date: Sun, 31 Dec 2006 02:11:53 -0800
> 
> > All we've done is created a trivial implementation for exporting
> > the device tree to userland that isn't burdened by the powerpc
> > and sparc legacy code that's in there now.
> 
> So now we'll have _3_ different implementations of exporting
> the OFW device tree via procfs.  Your's, the proc_devtree
> of powerpc, and sparc's /proc/openprom
> 
> That doesn't make any sense to me, having 3 ways of doing the same
> exact thing and making no attempt to share code at all.
> 
> If you want to do something new that consolidates everything, with the
> goal of deprecating the existing stuff, that's great!  But with they
> way you're doing this, all the sparc and powerpc implementations
> really can't take advantage of it.
> 
> Am I the only person who sees something very wrong with this?

No, I completely agree with you on this.

If firmworks really wants to have a spearate filesystem that's fine.
But please start with the ppc or sparc code and massage it into a
a separate filesystem before adding support for a new platform.

The last thing we need is more duplication.

In case anyone wants to start this based on ppc I'd gladfully help
to test this on pmac (32 and 64bit) and cell (64 bit).
