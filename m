Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271324AbTHRIHQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 04:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271329AbTHRIHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 04:07:16 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:64777 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271324AbTHRIHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 04:07:15 -0400
Date: Mon, 18 Aug 2003 09:07:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org, Pete Zaitcev <zaitcev@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] RFC: kills consistent_dma_mask
Message-ID: <20030818090712.A1652@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org,
	Pete Zaitcev <zaitcev@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <m3oeynykuu.fsf@defiant.pm.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m3oeynykuu.fsf@defiant.pm.waw.pl>; from khc@pm.waw.pl on Mon, Aug 18, 2003 at 12:34:17AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 12:34:17AM +0200, Krzysztof Halasa wrote:
> Hi,
> 
> What do you think about this patch? It kills all references to
> consistent_dma_mask in 2.6.0-test3 tree.
> 
> The consistent_dma_mask (and set_... function) is presumably a hack
> which is currently not used by anything (at least in the official tree).
> It's unneeded (it can be easily done in a driver, should a need arrive,
> without polluting the PCI subsystem) and is not supported by "DMA" API.
> It isn't even implemented on most platforms - only x86_64 and ia64 have
> support for it, while on the remaining archs using it according to the
> docs (with non-default value) could mean Oops or something like that.

So better fix the support.  This code was recently included after DaveM
as pci dma maintainer ACKed it.

