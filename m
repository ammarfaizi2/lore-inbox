Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752784AbWKCNE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784AbWKCNE5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 08:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbWKCNE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 08:04:57 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:10659
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1752784AbWKCNE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 08:04:56 -0500
Date: Fri, 03 Nov 2006 05:04:55 -0800 (PST)
Message-Id: <20061103.050455.25477833.davem@davemloft.net>
To: lwoodman@redhat.com
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: __alloc_pages() failures reported due to fragmentation
From: David Miller <davem@davemloft.net>
In-Reply-To: <454B3890.8070607@redhat.com>
References: <454B3282.3010308@redhat.com>
	<1162556514.14530.163.camel@laptopd505.fenrus.org>
	<454B3890.8070607@redhat.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Larry Woodman <lwoodman@redhat.com>
Date: Fri, 03 Nov 2006 07:39:44 -0500

> Hi Arjan.  Right but this just includes __GFP_REPEAT in the mask so we can
> defrag in __alloc_pages and only if GFP_WAIT was passed in origionally.

Indeed, quoting that small snippet of the patch was deceptive :-)

Arjan, gfp_mask is set to sk->sk_allocation, and we just add a bit
into it conditionally.
