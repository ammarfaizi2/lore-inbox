Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261901AbVBITGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbVBITGB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 14:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbVBITGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 14:06:01 -0500
Received: from mx2.elte.hu ([157.181.151.9]:23478 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261901AbVBITFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 14:05:54 -0500
Date: Wed, 9 Feb 2005 20:05:46 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Chris Wright <chrisw@osdl.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [patch, BK] clean up and unify asm-*/resource.h files
Message-ID: <20050209190546.GA25753@elte.hu>
References: <20050209093927.GA9726@elte.hu> <20050210020333.7941fa6e.sfr@canb.auug.org.au> <20050209180219.GC23554@elte.hu> <20050209105622.Z24171@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050209105622.Z24171@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Chris Wright <chrisw@osdl.org> wrote:

> * Ingo Molnar (mingo@elte.hu) wrote:
> > this patch does the final consolidation of asm-*/resource.h file,
> > without changing any of the rlimit definitions on any architecture.
> > Primarily it removes the __ARCH_RLIMIT_ORDER method and replaces it with
> > a more compact and isolated one that allows architectures to define only
> > the offending rlimits.
> 
> Heh, I did it this way first, then worried people might find it
> confusing to only have a subset of the block overwritten I backed it
> down to the __ARCH_RLIMIT_ORDER method.  Anyway, I like this change.
> 
> Acked-by: Chris Wright <chrisw@osdl.org>

the original reason i ended up doing this was when i introduced a new
rlimit and it needed changes in 5 include files. Now the new rlimit is
off the agenda but the cleanup remained :-)

	Ingo
