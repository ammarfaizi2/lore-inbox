Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262950AbVHEKEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262950AbVHEKEE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 06:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262948AbVHEKED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 06:04:03 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:56997 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262950AbVHEKDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 06:03:13 -0400
Date: Fri, 5 Aug 2005 12:01:54 +0200
From: Jens Axboe <axboe@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, bunk@stusta.de,
       erich@areca.com.tw
Subject: Re: areca-raid-linux-scsi-driver.patch added to -mm tree
Message-ID: <20050805100153.GJ5561@suse.de>
References: <200508050912.j759CfQp004898@shell0.pdx.osdl.net> <1123235067.3239.43.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123235067.3239.43.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05 2005, Arjan van de Ven wrote:
> > +
> > +				while (1) {
> > +					int64_t span4G, length0;
> > +					PSG64ENTRY pdma_sg = (PSG64ENTRY) psge;
> > +
> > +					span4G =
> > +					    (int64_t) address_lo + tmplength;
> > +					pdma_sg->addresshigh = address_hi;
> > +					pdma_sg->address = address_lo;
> > +					if (span4G > 0x100000000ULL) {
> > +						/*see if cross 4G boundary */
> 
> the linux block layer will guarantee that that doesn't happen afaik

yes, it even does it by default. so that code can be removed.

I agree with the other suggestions made.

-- 
Jens Axboe

