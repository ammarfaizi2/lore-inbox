Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751750AbWCHMxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbWCHMxB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 07:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751755AbWCHMxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 07:53:01 -0500
Received: from [194.90.237.34] ([194.90.237.34]:7844 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S1751448AbWCHMxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 07:53:00 -0500
Date: Wed, 8 Mar 2006 14:53:11 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: "David S. Miller" <davem@davemloft.net>
Cc: rdreier@cisco.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org, shemminger@osdl.org
Subject: Re: Re: TSO and IPoIB performance degradation
Message-ID: <20060308125311.GE17618@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <1141776697.6119.938.camel@localhost> <20060307.161808.60227862.davem@davemloft.net> <adaacc1raz9.fsf@cisco.com> <20060307.172336.107863253.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060307.172336.107863253.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 08 Mar 2006 12:55:20.0328 (UTC) FILETIME=[8E737880:01C642AF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. David S. Miller <davem@davemloft.net>:
> Subject: Re: Re: TSO and IPoIB performance degradation
> 
> From: Roland Dreier <rdreier@cisco.com>
> Date: Tue, 07 Mar 2006 17:17:30 -0800
> 
> > The reason TSO comes up is that reverting the patch described below
> > helps (or helped at some point at least) IPoIB throughput quite a bit.
> 
> I wish you had started the thread by mentioning this specific patch

Er, since you mention it, the first message in thread did include this link:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=314324121f9b94b2ca657a494cf2b9cb0e4a28cc
and I even pasted the patch description there, but oh well.

Now that Roland helped us clear it all up, and now that it has been clarified
that reverting this patch gives us back most of the performance, is the answer
to my question the same?

What I was trying to figure out was, how can we re-enable the trick without
hurting TSO? Could a solution be to simply look at the frame size, and call
tcp_send_delayed_ack if the frame size is small?

-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
