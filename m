Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbUA2IRD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 03:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbUA2IRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 03:17:03 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:22546 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261595AbUA2IRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 03:17:01 -0500
Date: Thu, 29 Jan 2004 08:16:56 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Christoph Hellwig <hch@infradead.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PC300 update
Message-ID: <20040129081656.A6944@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58L.0401281741120.2088@logos.cnet> <20040128212115.A2027@infradead.org> <Pine.LNX.4.58L.0401282203170.2163@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58L.0401282203170.2163@logos.cnet>; from marcelo.tosatti@cyclades.com on Wed, Jan 28, 2004 at 10:06:25PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 28, 2004 at 10:06:25PM -0200, Marcelo Tosatti wrote:
> 
> 
> Hi Christoph!
> 
> On Wed, 28 Jan 2004, Christoph Hellwig wrote:
> 
> > > - Mark pci_device_id list with __devinitdata
> >
> > This is bogus and can crash the kernel if you're unlucky.
> 
> Other wan drivers are doing the same:
> 
> [marcelo@logos wan]$ grep __devinitdata *
> farsync.c:static char *type_strings[] __devinitdata = {
> wanxl.c:static struct pci_device_id wanxl_pci_tbl[] __devinitdata = {
> 
> I believe a handful of others are using "__devinitdata". How can the
> kernel crash because of this? Who will try to touch the data?

The id table is register witch the pci core who will look at it for
probing (e.g. when a new module is loaded), so it may not simply disappear
behind the scenes.

