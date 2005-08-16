Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965126AbVHPGnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965126AbVHPGnI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 02:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbVHPGnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 02:43:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46287 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932605AbVHPGnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 02:43:07 -0400
Date: Mon, 15 Aug 2005 23:42:56 -0700
From: Chris Wright <chrisw@osdl.org>
To: zach@vmware.com
Cc: ak@suse.de, akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org,
       hpa@zytor.com, linux-kernel@vger.kernel.org, mbligh@mbligh.org,
       pratap@vmware.com, virtualization@lists.osdl.org,
       zwane@arm.linux.org.uk
Subject: Re: [PATCH 6/6] i386 virtualization - Attempt to clean up pgtable code motion
Message-ID: <20050816064256.GY7762@shell0.pdx.osdl.net>
References: <200508152301.j7FN19cj005354@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508152301.j7FN19cj005354@zach-dev.vmware.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* zach@vmware.com (zach@vmware.com) wrote:
> Virtualization aware Linux kernels may need to redefine functions which write
> to hardware page tables at the sub-architecture layer.  Previously, this was
> done by encapsulation in a split mach-xxx/pgtable-{2|3}level-ops.h file, but
> having 8 pgtable header files is simply unacceptable.  This goes some ways
> towards cleaning that up by deprecating the 2/3 level subarch functions.
> This is accomplished by using __HAVE_ARCH_FUNC macros, and allowing
> one sub-arch file, pgtable-ops.h, which gets included before any functions
> which write to hardware page tables, allowing the sub-architecture to override
> any or all definitions it needs.

This looks like a better tradeoff.
