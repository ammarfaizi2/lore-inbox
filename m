Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751606AbWCYBsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751606AbWCYBsX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 20:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbWCYBsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 20:48:23 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:12736
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751603AbWCYBsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 20:48:22 -0500
Date: Fri, 24 Mar 2006 17:47:45 -0800 (PST)
Message-Id: <20060324.174745.78769720.davem@davemloft.net>
To: kenneth.w.chen@intel.com
Cc: mrustad@mac.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16 hugetlbfs problem - DEBUG_PAGEALLOC
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200603250124.k2P1OKg21526@unix-os.sc.intel.com>
References: <C53A96CB-5B11-4BF3-879E-CF7B91E1BFEC@mac.com>
	<200603250124.k2P1OKg21526@unix-os.sc.intel.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Date: Fri, 24 Mar 2006 17:24:41 -0800

> Yeah, it turns out that the debug option is not compatible with hugetlb
> page support. That debug option turns off PSE. Once it is turned off in
> CR4, cpu will ignore pse bit in the pmd and causing infinite page-not-
> present fault :-(

Thanks for tracking this down.
