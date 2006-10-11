Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030774AbWJKDdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030774AbWJKDdv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 23:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030769AbWJKDdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 23:33:50 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:61786 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S1030499AbWJKDdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 23:33:49 -0400
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Stephen Hemminger <shemminger@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org, openib-general@openib.org,
       Roland Dreier <rolandd@cisco.com>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: Dropping NETIF_F_SG since no checksum feature.
X-Message-Flag: Warning: May contain useful information
References: <adavemrbtcx.fsf@cisco.com>
	<20061011002656.GB30093@mellanox.co.il>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 10 Oct 2006 20:33:46 -0700
In-Reply-To: <20061011002656.GB30093@mellanox.co.il> (Michael S. Tsirkin's message of "Wed, 11 Oct 2006 02:26:56 +0200")
Message-ID: <adar6xfbk6d.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 11 Oct 2006 03:33:48.0404 (UTC) FILETIME=[10239B40:01C6ECE6]
Authentication-Results: sj-dkim-5.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Michael> My guess was, an extra pass over data is likely to be
    Michael> expensive - dirtying the cache if nothing else. But I do
    Michael> plan to measure that, and see.

I don't get it -- where's the extra pass?  If you can't compute the
checksum on the NIC then you have to compute sometime it on the CPU
before passing the data to the NIC.

 - R.
