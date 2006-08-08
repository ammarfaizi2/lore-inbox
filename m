Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbWHHFKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbWHHFKI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 01:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWHHFKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 01:10:08 -0400
Received: from ozlabs.org ([203.10.76.45]:8655 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750829AbWHHFKG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 01:10:06 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17624.7310.856480.704542@cargo.ozlabs.ibm.com>
Date: Tue, 8 Aug 2006 15:09:34 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64: Make NR_IRQS configurable in Kconfig
In-Reply-To: <20060807194159.f7c741b5.akpm@osdl.org>
References: <m1irl4ftya.fsf@ebiederm.dsl.xmission.com>
	<m1slk89ozd.fsf@ebiederm.dsl.xmission.com>
	<20060807165512.dabefb63.akpm@osdl.org>
	<200608080417.59462.ak@suse.de>
	<20060807194159.f7c741b5.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> > Drawback would be some more TLB misses.
> 
> yup.  On some (important) architectures - I'm not sure which architectures
> do the bigpage-for-kernel trick.

I looked at optimizing the per-cpu data accessors on PowerPC and only
ever saw fractions of a percent change in overall performance, which
says to me that we don't actually use per-cpu data all that much.  So
unless you make per-cpu data really really slow, I doubt that we'll
see any significant performance difference.

Paul.
