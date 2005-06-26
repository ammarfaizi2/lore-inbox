Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbVFZXuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVFZXuu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 19:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbVFZXuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 19:50:50 -0400
Received: from ozlabs.org ([203.10.76.45]:54675 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261667AbVFZXup (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 19:50:45 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17087.15740.442831.617781@cargo.ozlabs.ibm.com>
Date: Mon, 27 Jun 2005 09:42:52 +1000
From: Paul Mackerras <paulus@samba.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: increased translation cache footprint in v2.6
In-Reply-To: <20050626172334.GA5786@logos.cnet>
References: <20050626172334.GA5786@logos.cnet>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti writes:

> We've noticed a slowdown while moving from v2.4 to v2.6 on a small PPC platform
> (855T CPU running at 48Mhz, containing pair of separate I/D TLB caches with 
> 32 entries each), with a relatively recent kernel (v2.6.11).
> 
> Test in question is a "dd" copying 16MB from /dev/zero to RAMDISK. 
> 
> Pinning an 8Mbyte TLB entry at KERNELBASE brought performance back to v2.4 levels.

Why are we not pinning a large TLB entry at KERNELBASE in 2.6?  Was
that taken out to reduce the size of the tlb miss handler or
something?

Paul.
