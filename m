Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266901AbUJNSe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266901AbUJNSe4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 14:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267303AbUJNSec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 14:34:32 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:1798 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266905AbUJNSAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 14:00:09 -0400
Date: Thu, 14 Oct 2004 19:00:06 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH] Introduce PCI <-> CPU address conversion [1/2]
Message-ID: <20041014180005.GA11954@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>,
	linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
	linux-ia64@vger.kernel.org
References: <20041014124737.GM16153@parcelfarce.linux.theplanet.co.uk> <20041014125348.GA9633@infradead.org> <20041014135323.GO16153@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041014135323.GO16153@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 02:53:23PM +0100, Matthew Wilcox wrote:
> On Thu, Oct 14, 2004 at 01:53:48PM +0100, Christoph Hellwig wrote:
> > I'd rather have this declared in every architectures asm/ header, so it's
> > more explicit that it's an per-arch thing.  Also make it a static inline
> > so we get typechecking.
> 
> I actually don't want typechecking.  Sometimes you have a device and
> sometimes you have a bus.  You can get everything you want (sysdata)
> from either, so there's no point in doing dev->bus when all you needed
> was right there.

For some architectures the sysdata is different for bus vs device, so
yes, we do want strict typechecking.

