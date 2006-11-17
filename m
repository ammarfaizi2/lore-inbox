Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755953AbWKQVs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755953AbWKQVs0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 16:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755952AbWKQVs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 16:48:26 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:62276 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1755953AbWKQVsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 16:48:24 -0500
To: Stephen Hemminger <shemminger@osdl.org>
Cc: "Divy Le Ray <divy@chelsio.com>" <divy@chelsio.com>, jeff@garzik.org,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/10] cxgb3 - main header files
X-Message-Flag: Warning: May contain useful information
References: <20061117202320.25878.26769.stgit@colfax2.asicdesigners.com>
	<20061117124902.7e69af2e@freekitty>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 17 Nov 2006 13:48:14 -0800
In-Reply-To: <20061117124902.7e69af2e@freekitty> (Stephen Hemminger's message of "Fri, 17 Nov 2006 12:49:02 -0800")
Message-ID: <adaejs1lp7l.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 17 Nov 2006 21:48:14.0957 (UTC) FILETIME=[15BD29D0:01C70A92]
Authentication-Results: sj-dkim-6; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim6002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > > +#define MDIO_LOCK(adapter) down(&(adapter)->mdio_lock)
 > > +#define MDIO_UNLOCK(adapter) up(&(adapter)->mdio_lock)
 > 
 > Please don't wrap locks

Plus these should probably be mutexes, not semaphores.

 > > +int t3_offload_tx(struct t3cdev *tdev, struct sk_buff *skb);
 > 
 > What kind of offload?  You remember TOE was rejected.

But we're OK with RDMA over TCP (iWARP) I think...

 - R.
