Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264000AbTD0NaV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 09:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264002AbTD0NaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 09:30:21 -0400
Received: from zero.aec.at ([193.170.194.10]:5902 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264000AbTD0NaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 09:30:20 -0400
Date: Sun, 27 Apr 2003 15:42:17 +0200
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Andi Kleen <ak@muc.de>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [PATCH] An generic subarchitecture for 2.5.68
Message-ID: <20030427134217.GA1287@averell>
References: <20030427012238.GA13997@averell> <20030426231147.69efb07d.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030426231147.69efb07d.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 27, 2003 at 08:11:47AM +0200, Andrew Morton wrote:
> Andi Kleen <ak@muc.de> wrote:
> >
> > 
> > This patch adds an generic x86 subarchitecture.
> 
> It causes a large number of compilation errors with the config at
> http://www.zip.com.au/~akpm/linux/patches/stuff/config
> 
> Some Kconfig help would be nice...

Ah - you didn't compile it with CONFIG_SMP. Ok, that was not tested
and frankly doesn't make any sense because you don't need an APIC 
driver for > 8 CPUs for an UP kernel.

Really BIGSMP, SUMMIT, GENERICARCH need to be only enabled with
SMP is enabled.

But Kconfig seems to ignore depends inside choice. Roman, any ideas
how to fix that?

-Andi

