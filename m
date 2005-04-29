Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262362AbVD2Akj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbVD2Akj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 20:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262359AbVD2Akf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 20:40:35 -0400
Received: from ozlabs.org ([203.10.76.45]:31680 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262358AbVD2Ak2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 20:40:28 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17009.33633.378204.859486@cargo.ozlabs.ibm.com>
Date: Fri, 29 Apr 2005 10:44:17 +1000
From: Paul Mackerras <paulus@samba.org>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] unify semaphore implementations
In-Reply-To: <20050428182926.GC16545@kvack.org>
References: <20050428182926.GC16545@kvack.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise writes:

> Please review the following series of patches for unifying the 
> semaphore implementation across all architectures (not posted as 
> they're about 350K), as they have only been tested on x86-64.  The 
> code generated is functionally identical to the earlier i386 
> variant, but since gcc has no way of taking condition codes as 
> results, there are two additional instructions inserted from the 
> use of generic atomic operations.  All told the >6000 lines of code 
> deleted makes for a much easier job for subsequent patches changing 
> semaphore functionality.  Cheers,

Vetoed.

You have made semaphores bigger and slower on the architectures that
have load-linked/store-conditional instructions, which is at least
ppc, ppc64, sparc64 and alpha.  Did you take the trouble to understand
the ppc semaphore implementation?

What changes do you want to make to the semaphore functionality?

Paul.
