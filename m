Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWHaAeB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWHaAeB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 20:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbWHaAeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 20:34:00 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:4275 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750774AbWHaAd7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 20:33:59 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17654.11889.933070.539839@cargo.ozlabs.ibm.com>
Date: Thu, 31 Aug 2006 10:33:53 +1000
From: Paul Mackerras <paulus@samba.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [RFC][PATCH 0/9] generic PAGE_SIZE infrastructure (v4)
In-Reply-To: <20060830221604.E7320C0F@localhost.localdomain>
References: <20060830221604.E7320C0F@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen writes:

> Why am I doing this?  The OpenVZ beancounter patch hooks into the
> alloc_thread_info() path, but only in two architectures.  It is silly
> to patch each and every architecture when they all just do the same
> thing.  This is the first step to have a single place in which to
> do alloc_thread_info().  Oh, and this series removes about 300 lines
> of code.

... at the price of making the Kconfig help text more generic and
therefore possibly confusing on some platforms.

I really don't see much value in doing all this.

Paul.
