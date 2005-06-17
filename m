Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbVFQSvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbVFQSvy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 14:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbVFQSvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 14:51:47 -0400
Received: from verein.lst.de ([213.95.11.210]:45961 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262057AbVFQSvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 14:51:15 -0400
Date: Fri, 17 Jun 2005 20:51:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Greg KH <gregkh@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: don't override drv->shutdown unconditionally
Message-ID: <20050617185104.GA21256@lst.de>
References: <20050617183057.GA20966@lst.de> <20050617184914.GA22107@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050617184914.GA22107@suse.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2005 at 11:49:14AM -0700, Greg KH wrote:
> On Fri, Jun 17, 2005 at 08:30:57PM +0200, Christoph Hellwig wrote:
> > There are many drivers that have been setting the generic driver
> > model­level shutdown callback, and pci thus must not override it.
> > 
> > Without this patch we can have really bad data loss on various
> > raid controllers.
> 
> Without the kexec patch?

On shutdown.  I don't know why you're talking about kexec here.

> So, why are these drivers setting the shutdown function in the first
> place if they don't want it to be called? 

They _do_ want it called.  They set the driver-model level one because
there hasn't been a pci-level one until a few years ago.

