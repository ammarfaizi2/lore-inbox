Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVFWNM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVFWNM0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 09:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbVFWNMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 09:12:25 -0400
Received: from cantor2.suse.de ([195.135.220.15]:41355 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261154AbVFWNKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 09:10:10 -0400
Date: Thu, 23 Jun 2005 15:10:05 +0200
From: Andi Kleen <ak@suse.de>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, jh@suse.cz
Subject: Re: [PATCH] x86_64 prefetchw() function can take into account CONFIG_MK8 / CONFIG_MPSC
Message-ID: <20050623131004.GL14251@wotan.suse.de>
References: <20050622.132241.21929037.davem@davemloft.net> <200506222242.j5MMgbxS009935@guinness.s2io.com> <20050622231300.GC14251@wotan.suse.de> <42BA81B2.4070108@cosmosbay.com> <20050623113150.GK14251@wotan.suse.de> <42BAB0BA.1010100@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BAB0BA.1010100@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2005 at 02:53:14PM +0200, Eric Dumazet wrote:
> Andi Kleen a ?crit :
> >On Thu, Jun 23, 2005 at 11:32:34AM +0200, Eric Dumazet wrote:
> >
> >>If we build a x86_64 kernel for an AMD64 or for an Intel EMT64, no need 
> >>to use alternative_input.
> >>Reserve alternative_input only for a generic kernel.
> >
> >
> >An EM64T kernel should still boot on AMD64 and vice versa. Rejected.
> >
> >-Andi
> >
> >
> 
> OK, I wrongly assumed the 'MK8' or 'MPSC' choices were like x86 choices :
> 
> A kernel compiled for a Pentium-4 will not run on a i486.
> 
> But then what is the meaning of the choice "Generic-x86-64" in the 
> "Processor family" menu ?
> The Help message is : CONFIG_GENERIC_CPU: Generic x86-64 CPU.

Optimize for both. It's a catch all setting for future changes
and does not do too much right now.

It also won't pass any -mcpu=... arguments to gcc. This currently
doesn't make any difference (gcc x86-64 default is to optimize
for K8), but I assume it might at some point when gcc gets
a "combined" mode that optimizes for both Intel and AMD CPUs.

-Andi

