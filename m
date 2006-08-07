Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbWHGCzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWHGCzw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 22:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbWHGCzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 22:55:52 -0400
Received: from cantor2.suse.de ([195.135.220.15]:40941 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750936AbWHGCzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 22:55:52 -0400
From: Andi Kleen <ak@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: 2.6.18-rc3-mm2 early_param mem= fix
Date: Mon, 7 Aug 2006 04:55:44 +0200
User-Agent: KMail/1.9.3
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
References: <Pine.LNX.4.64.0608061811030.19637@blonde.wat.veritas.com> <1154919267.21647.7.camel@localhost.localdomain>
In-Reply-To: <1154919267.21647.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608070455.44237.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 August 2006 04:54, Rusty Russell wrote:
> On Sun, 2006-08-06 at 18:22 +0100, Hugh Dickins wrote:
> > but I wonder how many other early_param
> > "option=" args are wrong (e.g. "memmap=" in the same file): x86_64
> > shows many such, i386 shows only one, I've not followed it up further.
> 
> Thanks Hugh.
> 
> Andrew, here's that i386 fix:

I had already fixed that one and the x86-64 ones.

But it still doesn't boot on x86-64 - gets into an endless loop
at boot. I'm suspecting the code can't deal with duplicated
prefixes.

-Andi
