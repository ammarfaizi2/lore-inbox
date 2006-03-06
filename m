Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbWCFW2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbWCFW2Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 17:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWCFW2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 17:28:16 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:62101
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932408AbWCFW2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 17:28:15 -0500
Date: Mon, 06 Mar 2006 14:28:14 -0800 (PST)
Message-Id: <20060306.142814.109285730.davem@davemloft.net>
To: rdreier@cisco.com
Cc: mshefty@ichips.intel.com, sean.hefty@intel.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH 6/6] IB: userspace support for
 RDMA connection manager
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <adabqwj5j7b.fsf@cisco.com>
References: <adaoe0j5kd6.fsf@cisco.com>
	<440CACB5.2010609@ichips.intel.com>
	<adabqwj5j7b.fsf@cisco.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 06 Mar 2006 13:58:32 -0800

>     Sean> Unless I miss counted, they should be aligned.
>     Sean> ib_user_path_rec is defined near the end of patch 1/6.
> 
> You're right.  struct sockaddr_in6 is 28 bytes long (not a multiple of
> 8) but gcc seems to lay everything out the same on 32-bit and 64-bit
> architectures just the same.

Please make sure you check "x86_64 vs. x86", and then something like
"powerpc64 vs. powerpc32" or "sparc64 vs. sparc32", as those are the
two different classes of ABI layouts.

