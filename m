Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWCYC5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWCYC5M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 21:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWCYC5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 21:57:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4481 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750718AbWCYC5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 21:57:11 -0500
Date: Fri, 24 Mar 2006 18:53:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: mrustad@mac.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16 hugetlbfs problem - DEBUG_PAGEALLOC
Message-Id: <20060324185331.56837b0a.akpm@osdl.org>
In-Reply-To: <200603250124.k2P1OKg21526@unix-os.sc.intel.com>
References: <C53A96CB-5B11-4BF3-879E-CF7B91E1BFEC@mac.com>
	<200603250124.k2P1OKg21526@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
>
> Mark Rustad wrote on Friday, March 24, 2006 9:52 AM
>  > I have narrowed this down to DEBUG_PAGEALLOC. If that option is  
>  > enabled, attempts to reference areas mmap-ed from hugetlbfs files  
>  > fault forever. You can see that I had that set in the failing config  
>  > I reported below.
> 
>  Yeah, it turns out that the debug option is not compatible with hugetlb
>  page support. That debug option turns off PSE. Once it is turned off in
>  CR4, cpu will ignore pse bit in the pmd and causing infinite page-not-
>  present fault :-(

I wonder if any of the other architectures which implement both these
features might have problems too.

