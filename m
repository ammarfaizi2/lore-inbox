Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbWE2Apc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWE2Apc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 20:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWE2Apc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 20:45:32 -0400
Received: from mga07.intel.com ([143.182.124.22]:1968 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751084AbWE2Apc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 20:45:32 -0400
X-IronPort-AV: i="4.05,182,1146466800"; 
   d="scan'208"; a="42780779:sNHT14267085"
Subject: Re: pci_walk_bus race condition
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060526135039.GA13280@kroah.com>
References: <1148625315.4377.518.camel@ymzhang-perf.sh.intel.com>
	 <20060526135039.GA13280@kroah.com>
Content-Type: text/plain
Message-Id: <1148863271.4377.521.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 29 May 2006 08:41:11 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-26 at 21:50, Greg KH wrote:
> On Fri, May 26, 2006 at 02:35:16PM +0800, Zhang, Yanmin wrote:
> > pci_walk_bus has a race with pci_destroy_dev. In the while loop,
> > when the callback function is called, dev pointed by next might be
> > freed and erased. So later on access to dev might cause kernel panic.
> 
> Have you seen this happen?  The only user of this function is the PPC64
> EEH handler, which last time I checked, didn't run on Intel based
> processors :)
I am enabling PCI-Express AER in kernel and want to use it. After
double-checking, I found the lock is not good.

Thanks,
Yanmin
