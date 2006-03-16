Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbWCPRog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbWCPRog (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 12:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752447AbWCPRog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 12:44:36 -0500
Received: from mx.pathscale.com ([64.160.42.68]:55750 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1752446AbWCPRof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 12:44:35 -0500
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
	driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, rdreier@cisco.com, torvalds@osdl.org,
       hch@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0603161724070.23220@goblin.wat.veritas.com>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
	 <ada4q27fban.fsf@cisco.com>
	 <1141948516.10693.55.camel@serpentine.pathscale.com>
	 <ada1wxbdv7a.fsf@cisco.com>
	 <1141949262.10693.69.camel@serpentine.pathscale.com>
	 <20060309163740.0b589ea4.akpm@osdl.org>
	 <1142470579.6994.78.camel@localhost.localdomain>
	 <ada3bhjuph2.fsf@cisco.com>
	 <1142475069.6994.114.camel@localhost.localdomain>
	 <adaslpjt8rg.fsf@cisco.com>
	 <1142477579.6994.124.camel@localhost.localdomain>
	 <20060315192813.71a5d31a.akpm@osdl.org>
	 <1142485103.25297.13.camel@camp4.serpentine.com>
	 <20060315213813.747b5967.akpm@osdl.org>
	 <1142521718.25297.37.camel@camp4.serpentine.com>
	 <Pine.LNX.4.61.0603161724070.23220@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Thu, 16 Mar 2006 09:44:34 -0800
Message-Id: <1142531074.25297.145.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-16 at 17:27 +0000, Hugh Dickins wrote:

> There's no need to do a get_page after the allocation and a put_page
> before the free (though you could, it's just extra unnecessary work):
> the allocation comes with a reference count of 1, the free frees up
> that last remaining reference count of 1 (as Andrew explained more
> lucidly elsewhere in his mail).

All right.  I followed your advice and you are indeed correct; the added
get_page and put_page were not necessary; __GFP_COMP alone did the
trick.

Thanks,

	<b

