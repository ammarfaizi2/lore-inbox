Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946642AbWJSW7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946642AbWJSW7j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 18:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946643AbWJSW7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 18:59:39 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:214
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1946642AbWJSW7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 18:59:38 -0400
Date: Thu, 19 Oct 2006 15:59:39 -0700 (PDT)
Message-Id: <20061019.155939.48528489.davem@davemloft.net>
To: ralf@linux-mips.org
Cc: nickpiggin@yahoo.com.au, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, anemo@mba.ocn.ne.jp
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061019181346.GA5421@linux-mips.org>
References: <1161275748231-git-send-email-ralf@linux-mips.org>
	<4537B9FB.7050303@yahoo.com.au>
	<20061019181346.GA5421@linux-mips.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ralf Baechle <ralf@linux-mips.org>
Date: Thu, 19 Oct 2006 19:13:46 +0100

> That would require changing the order of cache flush and tlb flush.
> To keep certain architectures that require a valid translation in
> the TLB the cacheflush has to be done first.  Not sure if those
> architectures need a writeable mapping for dirty cachelines - I
> think hypersparc was one of them.

There just has to be "a mapping" in the TLB so that the L2 cache can
translate the virtual address to a physical one for the writeback to
main memory.
