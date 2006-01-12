Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964948AbWALB1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbWALB1g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 20:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbWALB1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 20:27:36 -0500
Received: from mx.pathscale.com ([64.160.42.68]:988 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S964948AbWALB1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 20:27:36 -0500
Subject: Re: [PATCH 2 of 2] __raw_memcpy_toio32 for x86_64
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, rdreier@cisco.com, linux-kernel@vger.kernel.org
In-Reply-To: <200601120156.11529.ak@suse.de>
References: <f03a807a80b8bc45bf91.1137025776@eng-12.pathscale.com>
	 <200601120156.11529.ak@suse.de>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 17:27:13 -0800
Message-Id: <1137029233.17705.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-12 at 01:56 +0100, Andi Kleen wrote:

> At least some people have complained about the "All Rights reserved"
> in the past. Best you drop it.

OK, thanks.

> Usually one should use .p2align or ENTRY() at function beginning,
> otherwise you might get some penalty on K8.

Will do.

> > +__raw_memcpy_toio32:
> > +	movl %edx,%ecx
> > +	shrl $1,%ecx
> 
> 1? If it's called memcpy it should get a byte argument, no? If not
> name it something else, otherwise everybody will be confused. 

It's called toio32 for a reason :-)

Also, the kernel doc clearly states its purpose.

> movsq? I thought you wanted 32bit IO? 

The northbridge will split qword writes into pairs of dword writes.

> The movsd also looks weird.

Why?

	<b
-- 
Bryan O'Sullivan <bos@pathscale.com>

