Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265331AbUIIO4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265331AbUIIO4a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 10:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265489AbUIIO4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 10:56:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:7827 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265331AbUIIOzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 10:55:42 -0400
Date: Thu, 9 Sep 2004 07:55:37 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: Paul Mackerras <paulus@samba.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Matt Mackall <mpm@selenic.com>, Anton Blanchard <anton@samba.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [PATCH][5/8] Arch agnostic completely out of line locks / ppc64
In-Reply-To: <Pine.LNX.4.58.0409090751230.5912@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0409090754270.5912@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409021231570.4481@montezuma.fsmlabs.com>
 <16703.60725.153052.169532@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.53.0409090810550.15087@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0409090751230.5912@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 Sep 2004, Linus Torvalds wrote:
> 
> and the fact is, this is all much better just done in the arch-specific 
> spinlock code. 

This is especially true since some architectures may have high overheads 
for this, so you may do normal spinning for a while before you even start 
doing the "fancy" stuff. So there is no ay we should expose this as a 
"generic" interface. It ain't generic. It's very much a low-level 
implementation detail of "spin_lock()".

		Linus
