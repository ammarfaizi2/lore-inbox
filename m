Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161466AbWBUKgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161466AbWBUKgi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 05:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161464AbWBUKgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 05:36:38 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45531 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161463AbWBUKgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 05:36:37 -0500
Date: Tue, 21 Feb 2006 10:36:33 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Mark Maule <maule@sgi.com>
Cc: akpm@osdl.org, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] altix:  export sn_pcidev_info_get
Message-ID: <20060221103633.GA19349@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mark Maule <maule@sgi.com>, akpm@osdl.org,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060214162337.GA16954@sgi.com> <20060220201713.GA4992@infradead.org> <20060221024710.GB30226@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060221024710.GB30226@sgi.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 08:47:10PM -0600, Mark Maule wrote:
> On Mon, Feb 20, 2006 at 08:17:14PM +0000, Christoph Hellwig wrote:
> > On Tue, Feb 14, 2006 at 10:23:37AM -0600, Mark Maule wrote:
> > > Export sn_pcidev_info_get.
> > 
> > Tony or Andrew please back this out again.  The only reason SGI wants this is
> > to support their illegal graphics driver, and no core code uses it.
> > 
> > And Mark, please stop submitting such patches.
> 
> All I'm doing by exporting sn_pcidev_info_get is allowing a module to use
> the SGI SN_PCIDEV_BUSSOFT() macro which will tell a driver which piece of
> altix PCI hw its device is sitting behind (e.g. PCIIO_ASIC_TYPE_TIOCP et. al).

And that's absolutely not something a driver should care about.  If you
illegal binary driver uses it it's totally broken (but then we knew that
before anyway ;-))

