Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271692AbTHRMo7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 08:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271707AbTHRMo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 08:44:59 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:38873 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S271692AbTHRMo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 08:44:58 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] RFC: kills consistent_dma_mask
References: <m3oeynykuu.fsf@defiant.pm.waw.pl>
	<20030817233705.0bea9736.davem@redhat.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 18 Aug 2003 14:44:19 +0200
In-Reply-To: <20030817233705.0bea9736.davem@redhat.com>
Message-ID: <m3r83jyw2k.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> ia64 does in fact need consistent_dma_mask.

For what?
Perhaps a file name?

> > It isn't even implemented on most platforms - only x86_64 and ia64 have
> > support for it, while on the remaining archs using it according to the
> > docs (with non-default value) could mean Oops or something like that.
> 
> The platforms where it isn't implemented simply support
> it identically to how they support the normal dma_mask.

No. This is only true if you set dma_mask = consistent_dma_mask.
If they aren't equal (and don't cover the entire RAM address space)
the thing is broken.
If they have to be equal - why we need 2 masks in the first place?

> Please read the threads in the archives that caused
> consistent_dma_mask to be added to the tree in the first
> place before you go around removing it.

I did that before posting, of course. Which archives do you mean?
-- 
Krzysztof Halasa
Network Administrator
