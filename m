Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbWIAVKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbWIAVKA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 17:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbWIAVKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 17:10:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33756 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750896AbWIAVJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 17:09:59 -0400
Date: Fri, 1 Sep 2006 14:03:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: Adrian Bunk <bunk@stusta.de>, Tom Tucker <tom@opengridcomputing.com>,
       Steve Wise <swise@opengridcomputing.com>,
       Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: 2.6.18-rc5-mm1: drivers/infiniband/hw/amso1100/c2.c compile
 error
Message-Id: <20060901140313.51cf077b.akpm@osdl.org>
In-Reply-To: <ada4pvria3v.fsf@cisco.com>
References: <20060901015818.42767813.akpm@osdl.org>
	<20060901160023.GB18276@stusta.de>
	<20060901101340.962150cb.akpm@osdl.org>
	<adak64nij8f.fsf@cisco.com>
	<20060901112312.5ff0dd8d.akpm@osdl.org>
	<ada8xl3ics4.fsf@cisco.com>
	<20060901130444.48f19457.akpm@osdl.org>
	<ada4pvria3v.fsf@cisco.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Sep 2006 13:51:32 -0700
Roland Dreier <rdreier@cisco.com> wrote:

>     Andrew> No, driver-specific workarounds are not legitimate, sorry.
> 
>     Andrew> The driver should simply fail to compile on architectures
>     Andrew> which do not implement __raw_writeq().
> 
> But how should i386 (say) implement __raw_writeq()?  As two
> __raw_writel()s protected by a spinlock (that serializes all IO
> transactions)?  That seems rather ugly.
> 

If it's a choice between "ugly" and "doesn't work on x86", we'll take
"ugly" ;)

-- 
VGER BF report: H 0
