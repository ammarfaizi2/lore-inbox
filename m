Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262486AbVHDSLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262486AbVHDSLy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 14:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262478AbVHDSLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 14:11:54 -0400
Received: from ammasso.com ([66.228.85.228]:4649 "EHLO mail2.ammasso.com")
	by vger.kernel.org with ESMTP id S262486AbVHDSLK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 14:11:10 -0400
From: "Steve Wise" <swise@ammasso.com>
To: "'Roland Dreier'" <rolandd@cisco.com>, <openib-general@openib.org>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [openib-general] [RFC] Move InfiniBand .h files
Date: Thu, 4 Aug 2005 13:11:10 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcWZGn55PRakW+QlQiGzmKUDn5VSXgABVQBA
In-Reply-To: <52iryla9r5.fsf@cisco.com>
Message-ID: <MAIL2XR08ies8JynCR3000005b2@mail2.ammasso.com>
X-OriginalArrivalTime: 04 Aug 2005 18:11:10.0331 (UTC) FILETIME=[E44E74B0:01C5991F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems reasonable to me...


Steve.

 

> -----Original Message-----
> From: openib-general-bounces@openib.org 
> [mailto:openib-general-bounces@openib.org] On Behalf Of Roland Dreier
> Sent: Thursday, August 04, 2005 12:32 PM
> To: openib-general@openib.org; linux-kernel@vger.kernel.org
> Subject: [openib-general] [RFC] Move InfiniBand .h files
> 
> I would like to get people's reactions to moving the InfiniBand .h
> files from their current location in drivers/infiniband/include/ to
> include/linux/rdma/.  If we agree that this is a good idea then I'll
> push this change as soon as 2.6.14 starts.
> 
> The advantages of doing this are:
> 
>   - The headers become more easily accessible to other parts of the
>     tree that might want to use IB support.  For example, an NFS/RDMA
>     client probably wants to live under fs/
>   - It makes it easier to build IB modules outside the tree, since
>     include/linux gets put in /lib/modules/<ver>/build.  I realize
>     that we don't really care about out-of-tree modules, but it is
>     convenient to be able to develop and distribute new drivers that
>     build against someone's existing kernels.
>   - We can kill off the ugly
> 
>         EXTRA_CFLAGS += -Idrivers/infiniband/include
> 
>     lines in our Makefiles.
> 
> The disadvantages are:
> 
>   - It's churn with little technical merit.
>   - It makes it a little harder to pull the OpenIB svn tree into a
>     kernel tree, since one would have to link both drivers/infiniband
>     and include/linux/rdma instead of just drivers/infiniband.  This
>     problem goes away if/when OpenIB shifts over to a new source code
>     control system.
> 
> Thanks,
>   Roland
> _______________________________________________
> openib-general mailing list
> openib-general@openib.org
> http://openib.org/mailman/listinfo/openib-general
> 
> To unsubscribe, please visit 
> http://openib.org/mailman/listinfo/openib-general
> 

