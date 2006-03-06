Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbWCFWkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbWCFWkd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 17:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWCFWkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 17:40:32 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:48840
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932419AbWCFWka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 17:40:30 -0500
Date: Mon, 06 Mar 2006 14:40:34 -0800 (PST)
Message-Id: <20060306.144034.53871111.davem@davemloft.net>
To: mst@mellanox.co.il
Cc: netdev@vger.kernel.org, openib-general@openib.org,
       linux-kernel@vger.kernel.org, mlleinin@hpcn.ca.sandia.gov
Subject: Re: TSO and IPoIB performance degradation
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060306223438.GA18277@mellanox.co.il>
References: <20060306223438.GA18277@mellanox.co.il>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Date: Tue, 7 Mar 2006 00:34:38 +0200

> So I'm trying to get a handle on it: could a solution be to simply
> look at the frame size, and call tcp_send_delayed_ack from
> if the frame size is no larger than 1/8?
> 
> Does this make sense?

The comment you mention is very old, and no longer applies.

Get full packet traces from the kernel TSO code in the 2.6.x
kernel, analyze is, and post here what you think is occuring
that is causing the performance problems.

One thing to note is that the newer TSO code really needs to
have large socket buffers, so you can experiment with that.
