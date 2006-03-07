Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWCGVtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWCGVtf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 16:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbWCGVtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 16:49:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3775 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964771AbWCGVte (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 16:49:34 -0500
Date: Tue, 7 Mar 2006 13:49:07 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Matt Leininger <mlleinin@hpcn.ca.sandia.gov>
Cc: Shirley Ma <xma@us.ibm.com>, netdev@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org, "David S. Miller" <davem@davemloft.net>,
       mst@mellanox.co.il
Subject: Re: [openib-general] Re: TSO and IPoIB performance degradation
Message-ID: <20060307134907.733d3d27@localhost.localdomain>
In-Reply-To: <1141767891.6119.903.camel@localhost>
References: <OF336D72E6.999D2A30-ON8725712A.00117C92-8825712A.00116629@us.ibm.com>
	<1141767891.6119.903.camel@localhost>
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Mar 2006 13:44:51 -0800
Matt Leininger <mlleinin@hpcn.ca.sandia.gov> wrote:

> On Mon, 2006-03-06 at 19:13 -0800, Shirley Ma wrote:
> > 
> > > More likely you are getting hit by the fact that TSO prevents the
> > congestion
> > window from increasing properly. This was fixed in 2.6.15 (around mid
> > of Nov 2005). 
> > 
> > Yep, I noticed the same problem. After updating to the new kernel, the
> > performance are much better, but it's still lower than before.
> 
>  Here is an updated version of OpenIB IPoIB performance for various
> kernels with and without one of the TSO patches.  The netperf
> performance for the latest kernels has not improved the TSO performance
> drop.
> 
>   Any comments or suggestions would be appreciated.
> 
>   - Matt

Configuration information? like did you increase the tcp_rmem, tcp_wmem?
Tcpdump traces of what is being sent and available window?
Is IB using NAPI or just doing netif_rx()?
