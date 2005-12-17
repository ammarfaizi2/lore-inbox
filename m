Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932600AbVLQV1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600AbVLQV1N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 16:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbVLQV1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 16:27:13 -0500
Received: from [194.90.237.34] ([194.90.237.34]:3113 "EHLO mtlex01.yok.mtl.com")
	by vger.kernel.org with ESMTP id S932600AbVLQV1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 16:27:12 -0500
Date: Sat, 17 Dec 2005 23:30:30 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Andrew Morton <akpm@osdl.org>
Cc: Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [git patch review 2/7] IB/mthca: correct log2 calculation
Message-ID: <20051217213030.GB19246@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20051217123816.18ad94e0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051217123816.18ad94e0.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Andrew Morton <akpm@osdl.org>:
> Subject: Re: [git patch review 2/7] IB/mthca: correct log2 calculation
> 
> Roland Dreier <rolandd@cisco.com> wrote:
> >
> > Fix thinko in rd_atomic calculation: ffs(x) - 1 does not find the next
> > power of 2 -- it should be fls(x - 1).
> 
> Please use round_up_pow_of_two().

Yes, but we want the bit number. roundup_pow_of_two does a shift.

-- 
MST
