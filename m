Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932508AbVIMX2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbVIMX2K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 19:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbVIMX2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 19:28:10 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:57034
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932508AbVIMX2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 19:28:08 -0400
Date: Tue, 13 Sep 2005 16:27:48 -0700 (PDT)
Message-Id: <20050913.162748.86496945.davem@davemloft.net>
To: kiran@scalex86.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       bharata@in.ibm.com, shai@scalex86.org, rusty@rustcorp.com.au,
       netdev@vger.kernel.org
Subject: Re: [patch 9/11] net: dst_entry.refcount, use, lastuse to use
 alloc_percpu
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050913231717.GC6249@localhost.localdomain>
References: <20050913220737.GA6249@localhost.localdomain>
	<20050913.151216.48124942.davem@davemloft.net>
	<20050913231717.GC6249@localhost.localdomain>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravikiran G Thirumalai <kiran@scalex86.org>
Date: Tue, 13 Sep 2005 16:17:17 -0700

> But even 1 Million dst cache entries would be 16+4 MB additional for
> a 4 cpu box....is that too much?

Absolutely.

Per-cpu counters are great for things like single instance
statistics et al.  But once you start doing them per-object
that's out of control bloat as far as I'm concerned.
