Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269222AbUINJCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269222AbUINJCm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 05:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269204AbUINJCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 05:02:38 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:25110 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S269222AbUINJAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 05:00:36 -0400
X-BrightmailFiltered: true
Message-Id: <5.1.0.14.2.20040914184652.03e24de0@171.71.163.14>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 14 Sep 2004 18:48:20 +1000
To: "David S. Miller" <davem@davemloft.net>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: [PATCH] [RFC] Support for wccp version 1 and 2 in ip_gre.c
Cc: Paul P Komkoff Jr <i@stingr.net>, i@stingr.net, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040913161912.7dcc809f.davem@davemloft.net>
References: <20040913051706.GB26337@stingr.sgu.ru>
 <20040911194108.GS28258@stingr.sgu.ru>
 <20040912170505.62916147.davem@davemloft.net>
 <20040913051706.GB26337@stingr.sgu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:19 AM 14/09/2004, David S. Miller wrote:
> > As you can see, I am applying it unconditionally when fits. For most
> > cases, this will be OK.
> > There can be situations when this is not wanted (for example, when
> > debugging something), so in general, tuning knob will be useful, but
> > I just don't know where to add it, maybe tunnel->parms.i_flags ...
>
>I don't think adding such a knob is necessary, but yes i_flags
>would be the place to do it.
>
>I will apply your patch with the "if(1)" simply removed.

the logic is correct, but it may make sense to call the appropriate 
netfilter hook again with the "unwrapped" GRE packet, as otherwise 
packets-inside-GRE represent a possible security hole where one can inject 
packets externally and bypass firewall rules.


cheers,

lincoln.

