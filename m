Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbWGYBly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWGYBly (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 21:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWGYBly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 21:41:54 -0400
Received: from colin.muc.de ([193.149.48.1]:40968 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1751203AbWGYBlx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 21:41:53 -0400
Date: 25 Jul 2006 03:41:51 +0200
Date: Tue, 25 Jul 2006 03:41:51 +0200
From: Andi Kleen <ak@muc.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Keir Fraser <Keir.Fraser@cl.cam.ac.uk>,
       Jeremy Fitzhardinge <jeremy@goop.org>, Zachary Amsden <zach@vmware.com>,
       Pratap <pratap@vmware.com>, Chris Wright <chrisw@sous-sol.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] cpuid neatening.
Message-ID: <20060725014151.GB91138@muc.de>
References: <1153526643.13699.18.camel@localhost.localdomain> <1153526798.13699.23.camel@localhost.localdomain> <1153527194.13699.34.camel@localhost.localdomain> <44C55E8F.2020200@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C55E8F.2020200@zytor.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2006 at 04:58:07PM -0700, H. Peter Anvin wrote:
> Rusty Russell wrote:
> >Roll all the cpuid asm into one __cpuid call.  It's a little neater,
> >and also means only one place to patch for paravirtualization.
> 
> The whole point of those is to avoid the unnecessary write to memory and 
> pick it back up again.  This patch reintroduces that ugliness.

Modern gcc should optimize this when it is inlined. If it didn't
most abstracted C++ code would be quite unhappy.

Also as far as I know there is only a single time critical CPUID
in the code and it ignores all output arguments.

-Andi
