Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbWCFWjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWCFWjM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 17:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWCFWjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 17:39:12 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:46792
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932417AbWCFWjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 17:39:10 -0500
Date: Mon, 06 Mar 2006 14:39:01 -0800 (PST)
Message-Id: <20060306.143901.26500391.davem@davemloft.net>
To: rdreier@cisco.com
Cc: mshefty@ichips.intel.com, sean.hefty@intel.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH 6/6] IB: userspace support for
 RDMA connection manager
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <aday7zn432b.fsf@cisco.com>
References: <adabqwj5j7b.fsf@cisco.com>
	<20060306.142814.109285730.davem@davemloft.net>
	<aday7zn432b.fsf@cisco.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 06 Mar 2006 14:32:28 -0800

> The fundamental question seems to be whether things like
> 
> 	struct foo {
> 		struct sockaddr_in6 src;
> 		struct sockaddr_in6 dst;
> 	};
> 
> and
> 
> 	struct bar {
> 		struct sockaddr_in6 a;
> 		__u32 b;
> 	};

I wrote a test program and it looks ok:

davem@sunset:~/src/GIT/sparc-2.6.17$ gcc -m32 -O -o foo foo.c
davem@sunset:~/src/GIT/sparc-2.6.17$ ./foo
SPARC32
foo src: 0
foo dst: 28
bar a: 0
bar b: 28
davem@sunset:~/src/GIT/sparc-2.6.17$ gcc -m64 -O -o foo foo.c
davem@sunset:~/src/GIT/sparc-2.6.17$ ./foo
SPARC64
foo src: 0
foo dst: 28
bar a: 0
bar b: 28
