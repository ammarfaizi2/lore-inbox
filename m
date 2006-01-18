Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030366AbWARV1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030366AbWARV1R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 16:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030473AbWARV1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 16:27:17 -0500
Received: from [194.90.237.34] ([194.90.237.34]:39833 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP
	id S1030366AbWARV1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 16:27:16 -0500
Date: Wed, 18 Jan 2006 23:27:32 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Shirley Ma <xma@us.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
       openib-general@openib.org, openib-general-bounces@openib.org
Subject: Re: Fwd: [PATCH 1 of 3] move destructor to struct	neigh_parms
Message-ID: <20060118212732.GA32283@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <OFB2D358DB.F7A4CFB5-ON872570FA.007138E4-882570FA.00714019@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFB2D358DB.F7A4CFB5-ON872570FA.007138E4-882570FA.00714019@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Shirley Ma <xma@us.ibm.com>:
> Subject: Re: Fwd: [PATCH 1 of 3] move destructor to struct neigh_parms
> 
> 
> >+                 if (neigh->parms->neigh_destructor)
> >+                                  (neigh->parms->neigh_destructor)(neigh); 
> 
> Is that safe without checking neigh->parms here?

Yes, we have neigh_parms_put(neigh->parms); a couple of lines below.

-- 
MST
