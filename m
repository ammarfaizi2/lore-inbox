Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932522AbVLJAQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbVLJAQn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 19:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbVLJAQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 19:16:42 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:60386 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932522AbVLJAQm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 19:16:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DwPE1YogQl6HqGWsSs9fnuk6tMyYz7lvIszoDjXFrg/vFof8zh0tPCmUJ6tNeJKCmhmi5eFpMw5N5HgweIkvkXoFIajCONsF9jK+h5+THZG+Ob1mVgWw2Fo8GuNJzZA3LI/cUVQZo2MQqXEe9qdfUFsnYBVKl3vDV3PPZF5IPxw=
Message-ID: <a762e240512091616l62f1c69andeec382d7356ba64@mail.gmail.com>
Date: Fri, 9 Dec 2005 16:16:41 -0800
From: Keith Mannthey <kmannth@gmail.com>
To: Andi Kleen <ak@muc.de>
Subject: Re: [patch 3/3] add x86-64 support for memory hot-add
Cc: Matt Tolentino <metolent@cs.vt.edu>, akpm@osdl.org, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, matthew.e.tolentino@intel.com
In-Reply-To: <20051209173249.GA54033@muc.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200512091523.jB9FNn5J006697@ap1.cs.vt.edu>
	 <20051209173249.GA54033@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> These should be all __cpuinit.
>
> In general SRAT has a hotplug memory bit so it's possible
> to predict how much memory there will be in advance. Since
> the overhead of the kernel page tables should be very
> low I would prefer if you just used instead.

How much overhead would there be?

> (i.e. instead of extending the kernel mapping preallocate
> the direct mapping and just clear the P bits)

On my box the SRAT for hot-add areas exposed are from the end
installed memory to way out in outerspace.
SRAT: hot plug zone found 280000000 - 2300000000
I can't hot add that sort of range on my box but the bios didn't want
to limit or is planing for really really big dimms.

I wouldn't want to waste resource for areas that will never be added.

Thanks,
 Keith
