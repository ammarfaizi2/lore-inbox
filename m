Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262283AbVHCNSC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbVHCNSC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 09:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbVHCNSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 09:18:02 -0400
Received: from cantor2.suse.de ([195.135.220.15]:28806 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262283AbVHCNSA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 09:18:00 -0400
Date: Wed, 3 Aug 2005 15:17:59 +0200
From: Andi Kleen <ak@suse.de>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64 : prefetchw() can fall back to prefetch() if !3DNOW
Message-ID: <20050803131759.GT10895@wotan.suse.de>
References: <m1slxz1ssn.fsf@ebiederm.dsl.xmission.com> <86802c44050728092275e28a9a@mail.gmail.com> <42E91191.60603@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E91191.60603@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2005 at 07:10:41PM +0200, Eric Dumazet wrote:
> [PATCH] x86_64 : prefetchw() can fall back to prefetch() if !3DNOW
> 
> If the cpu lacks 3DNOW feature, we can use a normal prefetcht0 instruction 
> instead of NOP5.
> "prefetchw (%rxx)" and "prefetcht0 (%rxx)" have the same length, ranging 
> from 3 to 5 bytes
> depending on the register. So this patch even helps AMD64, shortening the 
> length of the code.

Looks good, thanks.

-Andi

