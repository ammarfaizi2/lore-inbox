Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751793AbWFWRN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbWFWRN3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 13:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbWFWRN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 13:13:29 -0400
Received: from palrel10.hp.com ([156.153.255.245]:50573 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S1751793AbWFWRN1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 13:13:27 -0400
Date: Fri, 23 Jun 2006 10:14:57 -0700
From: Grant Grundler <iod00d@hp.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Steve Wise <swise@opengridcomputing.com>, rdreier@cisco.com,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       netdev@vger.kernel.org
Subject: Re: [openib-general] [PATCH v3 1/7] AMSO1100 Low Level Driver.
Message-ID: <20060623171457.GA3610@esmail.cup.hp.com>
References: <20060620203050.31536.5341.stgit@stevo-desktop> <20060620203055.31536.15131.stgit@stevo-desktop> <1150836226.2891.231.camel@laptopd505.fenrus.org> <1151070290.7808.33.camel@stevo-desktop> <1151070532.3204.10.camel@laptopd505.fenrus.org> <1151071005.7808.39.camel@stevo-desktop> <1151071471.3204.12.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151071471.3204.12.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 04:04:31PM +0200, Arjan van de Ven wrote:
> > I thought the posted write WILL eventually get to adapter memory.  Not
> > stall forever cached in a bridge.  I'm wrong?
> 
> I'm not sure there is a theoretical upper bound.... 

I'm not aware of one either since MMIO writes can travel
across many other chips that are not constrained by
PCI ordering rules (I'm thinking of SGI Altix...)

> (and if it's several msec per bridge, then you have a lot of latency
> anyway)

That's what my original concern was when I saw you point this out.
But MMIO reads here would be expensive and many drivers tolerate
this latency in exchange for avoiding the MMIO read in the
performance path.

grant
