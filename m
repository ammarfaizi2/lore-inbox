Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752150AbWCJHSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbWCJHSJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 02:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752162AbWCJHSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 02:18:09 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:25825
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1752066AbWCJHSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 02:18:08 -0500
Date: Thu, 09 Mar 2006 23:18:06 -0800 (PST)
Message-Id: <20060309.231806.10212645.davem@davemloft.net>
To: mst@mellanox.co.il
Cc: rdreier@cisco.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org, shemminger@osdl.org
Subject: Re: TSO and IPoIB performance degradation
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060310001031.GA19040@mellanox.co.il>
References: <20060308125311.GE17618@mellanox.co.il>
	<20060309.154819.104282952.davem@davemloft.net>
	<20060310001031.GA19040@mellanox.co.il>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Date: Fri, 10 Mar 2006 02:10:31 +0200

> But with the change we are discussing, could an ack now be sent even
> sooner than we have at least two full sized segments?  Or does
> __tcp_ack_snd_check delay until we have at least two full sized
> segments? David, could you explain please?

__tcp_ack_snd_check() delays until we have at least two full
sized segments.
