Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261765AbVDEOlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbVDEOlb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 10:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbVDEOlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 10:41:31 -0400
Received: from mailgw.voltaire.com ([212.143.27.70]:62700 "EHLO
	mailgw.voltaire.com") by vger.kernel.org with ESMTP id S261765AbVDEOlF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 10:41:05 -0400
Subject: Re: [-mm patch] drivers/infiniband/hw/mthca/mthca_main.c: remove
	an unused label
From: Hal Rosenstock <halr@voltaire.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Roland Dreier <roland@topspin.com>,
       linux-kernel@vger.kernel.org, Sean Hefty <mshefty@ichips.intel.com>,
       openib-general@openib.org
In-Reply-To: <20050405142449.GF6885@stusta.de>
References: <20050405000524.592fc125.akpm@osdl.org>
	 <20050405142449.GF6885@stusta.de>
Content-Type: text/plain
Organization: 
Message-Id: <1112711845.4490.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 05 Apr 2005 10:37:25 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-05 at 10:24, Adrian Bunk wrote:
> On Tue, Apr 05, 2005 at 12:05:24AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.12-rc1-mm4:
> >...
> > +ib-mthca-add-support-for-new-mt25204-hca.patch
> > 
> >  Infiniband update
> >...
> 
> 
> This patch causes the following compile warning:
> 
> <--  snip  -->
> 
> ...
>   CC      drivers/infiniband/hw/mthca/mthca_main.o
> drivers/infiniband/hw/mthca/mthca_main.c: In function `mthca_init_icm':
> drivers/infiniband/hw/mthca/mthca_main.c:479: warning: label 
> `err_unmap_eqp' defined but not used
> ...
> 
> <--  snip  -->
> 
> 
> I'm not sure whether this patch to remove this label is correct, but if 
> it isn't correct there must be a bug somewhere.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.12-rc2-mm1-full/drivers/infiniband/hw/mthca/mthca_main.c.old	2005-04-05 16:18:09.000000000 +0200
> +++ linux-2.6.12-rc2-mm1-full/drivers/infiniband/hw/mthca/mthca_main.c	2005-04-05 16:19:15.000000000 +0200
> @@ -475,8 +475,6 @@
>  
>  err_unmap_rdb:
>  	mthca_free_icm_table(mdev, mdev->qp_table.rdb_table);
> -
> -err_unmap_eqp:
>  	mthca_free_icm_table(mdev, mdev->qp_table.eqp_table);
>  
>  err_unmap_qp:

Roland caught this recently and there is a patch for this which will
sent upstream. The proper fix is different from this.

-- Hal

