Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbWGLQdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbWGLQdR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 12:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWGLQdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 12:33:17 -0400
Received: from fmr17.intel.com ([134.134.136.16]:27880 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751012AbWGLQdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 12:33:16 -0400
Message-ID: <44B523F9.1060501@ichips.intel.com>
Date: Wed, 12 Jul 2006 09:31:53 -0700
From: Sean Hefty <mshefty@ichips.intel.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
CC: Ingo Molnar <mingo@elte.hu>, Sean Hefty <sean.hefty@intel.com>,
       Roland Dreier <rdreier@cisco.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Zach Brown <zach.brown@oracle.com>, openib-general@openib.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [openib-general] ipoib lockdep warning
References: <20060712093820.GA9218@elte.hu> <20060712110955.GB18466@mellanox.co.il>
In-Reply-To: <20060712110955.GB18466@mellanox.co.il>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael S. Tsirkin wrote:
> Yes, this is true for users that pass GFP_ATOMIC to sa_query, at least.  But
> might not be so for other users:  send_mad in sa_query actually gets gfp_flags
> parameter, but for some reason it does not pass it to idr_pre_get, which means
> even sa query done with GFP_KERNEL flag is likely to fail.
> 
> Sean, it seems we need something like the following - what do you think?

I noticed this same thing looking at the code yesterday.  I can't think of any 
reason why your patch wouldn't work.

- Sean

