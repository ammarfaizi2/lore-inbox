Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265490AbUGZS1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265490AbUGZS1x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 14:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265487AbUGZS1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 14:27:52 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:7431 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266281AbUGZQcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 12:32:03 -0400
Date: Mon, 26 Jul 2004 17:31:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: Greg KH <greg@kroah.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] Add kref_read and kref_put_last primitives
Message-ID: <20040726173151.A11637@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ravikiran G Thirumalai <kiran@in.ibm.com>, Greg KH <greg@kroah.com>,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20040726144856.GH1231@obelix.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040726144856.GH1231@obelix.in.ibm.com>; from kiran@in.ibm.com on Mon, Jul 26, 2004 at 08:18:56PM +0530
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2004 at 08:18:56PM +0530, Ravikiran G Thirumalai wrote:
> Greg,
> Here is a patch to add kref_read and kref_put_last.
> These primitives were needed to change files_struct.f_count
> refcounter to use kref api.
> 
> kref_put_last is needed sometimes when a refcount might
> have an unconventional release which needs more than
> the refcounted object to process object release-- like in the
> files_struct.f_count conversion patch at __aio_put_req().
> The following patch depends on kref shrinkage patches.
> (which you have already included).

Why don't you simply use an atomic_t if that's what you seem to
want?

