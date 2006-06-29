Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751860AbWF2LIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860AbWF2LIY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 07:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751868AbWF2LIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 07:08:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11425 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751860AbWF2LIX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 07:08:23 -0400
Date: Thu, 29 Jun 2006 04:08:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: mmilenko@us.ibm.com, linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
       hpa@zytor.com
Subject: Re: [2.6 PATCH] Exporting mmu_cr4_features again for i386 & x86_64
Message-Id: <20060629040801.734ca23c.akpm@osdl.org>
In-Reply-To: <200606291255.36206.ak@suse.de>
References: <OF692619AF.8A926C55-ON8725719B.007C1C06-8625719B.007E27C7@us.ibm.com>
	<200606291255.36206.ak@suse.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006 12:55:36 +0200
Andi Kleen <ak@suse.de> wrote:

> On Thursday 29 June 2006 01:01, Milena Milenkovic wrote:
> > Hi all,
> > 
> > The mmu_cr4_features variable was "unexported" in 2.6.12 kernel
> > (A patch submitted by Adrian Bunk, [2.6 patch] unexport mmu_cr4_features).
> 
> Normal policy is to unexport symbols that are not used in the core 
> kernel.
> 
> However I think there is a deprecation policy with prior 
> warning that might not have been followed here.

We have EXPORT_UNUSED_SYMBOL() and EXPORT_UNUSED_SYMBOL_GPL() as of this
morning.  We can convert unused exports to use those and users will get a
nasty warning at modprobe-time when they use the exported symbols.

