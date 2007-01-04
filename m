Return-Path: <linux-kernel-owner+w=401wt.eu-S932273AbXADFOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbXADFOm (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 00:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbXADFOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 00:14:42 -0500
Received: from p02c11o146.mxlogic.net ([208.65.145.69]:59698 "EHLO
	p02c11o146.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932261AbXADFOl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 00:14:41 -0500
Date: Thu, 4 Jan 2007 07:07:22 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Steve Wise <swise@opengridcomputing.com>
Cc: netdev@vger.kernel.org, Roland Dreier <rdreier@cisco.com>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH  v4 01/13] Linux RDMA Core Changes
Message-ID: <20070104050722.GA9900@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <1167851839.4187.36.camel@stevo-desktop> <20070103193324.GD29003@mellanox.co.il> <1167855618.4187.65.camel@stevo-desktop> <1167859320.4187.81.camel@stevo-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1167859320.4187.81.camel@stevo-desktop>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 04 Jan 2007 05:08:27.0595 (UTC) FILETIME=[5E5021B0:01C72FBE]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14914.001
X-TM-AS-Result: No--9.493800-4.000000-31
X-Spam: [F=0.0100000000; S=0.010(2006120601)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you think I should not add the udata parameter to the req_notify_cq()
> provider verb, then I can rework the chelsio driver:
> 
> 1) at cq creation time, pass the virtual address of the u32 used by the
> library to track the current cq index.  That way the chelsio kernel
> driver can save the address in its kernel cq context for later use.
> 
> 2) change chelsio's req_notify_cq() to copy in the current cq index
> value directly for rearming.
> 
> This puts all the burden on the chelsio driver, which is apparently the
> only one that needs this functionality.  

Good thinking, I haven't thought of this approach.

This way there won't be any API/core changes and no changes to
other low level drivers, correct? And for chelsio, there's no overhead
as compared to code you posted.

Sounds good.

-- 
MST
