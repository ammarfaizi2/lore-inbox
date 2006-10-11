Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030720AbWJKAPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030720AbWJKAPe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 20:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbWJKAPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 20:15:34 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:63916 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S932168AbWJKAPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 20:15:32 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AY8CACDUK0U
X-IronPort-AV: i="4.09,291,1157353200"; 
   d="scan'208"; a="1857396487:sNHT33458016"
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Stephen Hemminger <shemminger@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org, openib-general@openib.org,
       Roland Dreier <rolandd@cisco.com>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: Dropping NETIF_F_SG since no checksum feature.
X-Message-Flag: Warning: May contain useful information
References: <20061010104315.61540986@freekitty>
	<20061011001338.GA30093@mellanox.co.il>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 10 Oct 2006 17:15:26 -0700
In-Reply-To: <20061011001338.GA30093@mellanox.co.il> (Michael S. Tsirkin's message of "Wed, 11 Oct 2006 02:13:38 +0200")
Message-ID: <adavemrbtcx.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 11 Oct 2006 00:15:28.0301 (UTC) FILETIME=[5B1FFDD0:01C6ECCA]
Authentication-Results: sj-dkim-7.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Michael> Maybe I can patch linux to allow SG without checksum?
    Michael> Dave, maybe you could drop a hint or two on whether this
    Michael> is worthwhile and what are the issues that need
    Michael> addressing to make this work?

What do you really gain by allowing SG without checksum?  Someone has
to do the checksum anyway, so I don't see that much difference between
doing it in the networking core before passing the data to/from the
driver, or down in the driver itself.

 - R.
