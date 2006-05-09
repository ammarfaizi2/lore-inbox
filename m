Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWEIVws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWEIVws (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 17:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWEIVws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 17:52:48 -0400
Received: from ns1.suse.de ([195.135.220.2]:15565 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751170AbWEIVwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 17:52:47 -0400
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [RFC PATCH 25/35] Add Xen time abstractions
Date: Tue, 9 May 2006 23:50:03 +0200
User-Agent: KMail/1.9.1
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>
References: <20060509084945.373541000@sous-sol.org> <20060509085157.908244000@sous-sol.org>
In-Reply-To: <20060509085157.908244000@sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605092350.03886.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 May 2006 09:00, Chris Wright wrote:
> Add support for Xen time abstractions. To avoid expensive traps into
> the hypervisor, the passage of time is extrapolated from the local TSC
> and a set of timestamps and scaling factors exported to the guest via
> shared memory. Xen also provides a periodic interrupt facility which
> is used to drive updates of xtime and jiffies, and perform the usual
> process accounting and profiling.

There is far too much code duplication in there. I think you need to
refactor the main time.c a bit first and strip that down.

Also you can drop all the __x86_64__ support for now.

-Andi

> 
