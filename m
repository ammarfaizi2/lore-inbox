Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263710AbUDNIs0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 04:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263997AbUDNIsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 04:48:24 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:23531 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S263710AbUDNIrg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 04:47:36 -0400
Date: Wed, 14 Apr 2004 18:44:20 +1000
From: Anton Blanchard <anton@au1.ibm.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Paul Mackerras <paulus@samba.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, Kurt Garloff <garloff@suse.de>,
       linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: PowerPC exec page protection
Message-ID: <20040414084420.GA1950@krispykreme>
References: <9AB83E4717F13F419BD880F5254709E5011EBABA@scsmsx402.sc.intel.com> <20040414082355.GA8303@mail.shareable.org> <20040414083550.GB8303@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040414083550.GB8303@mail.shareable.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> <asm-ppc/pgtable.h> and <asm-ppc64/pgtable.h> both define the
> following map of protection bits:
> 
>     #define __P000  PAGE_NONE
>     #define __P001  PAGE_READONLY_X
>     #define __P010  PAGE_COPY
>     #define __P011  PAGE_COPY_X
>     #define __P100  PAGE_READONLY
>     #define __P101  PAGE_READONLY_X
>     #define __P110  PAGE_COPY
>     #define __P111  PAGE_COPY_X
> 
>     #define __S000  PAGE_NONE
>     #define __S001  PAGE_READONLY_X
>     #define __S010  PAGE_SHARED
>     #define __S011  PAGE_SHARED_X
>     #define __S100  PAGE_READONLY
>     #define __S101  PAGE_READONLY_X
>     #define __S110  PAGE_SHARED
>     #define __S111  PAGE_SHARED_X
> 
> The _X flags seem wrongly placed, as bit 2 is the PROT_EXEC bit, not
> bit 0.  Is the above intentional?

Its backwards and we know it :) Ive got a patch to implement per page
execute on ppc64 and that did pop up.

Thanks for pointing it out, are you looking at ppc* page protection or
just chanced upon it?

Anton
