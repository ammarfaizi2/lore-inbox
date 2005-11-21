Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbVKUWRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbVKUWRh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbVKUWRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:17:37 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:30612 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751166AbVKUWRf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:17:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O9Ygi3oE9BZqI15MsLRb+2AqfhtUSDjVe/FCrL3B9LdvdQ54MK6Q2biCao3t8uzr8UDCwijD0JNsq04QlXkE1KGP4fJ1gZjHK5pGBxXRlY+RS4AhTeCVGztA+0d5wOVkDxOj0ZsThHwXJJEY8KO9C5OmOj/EDzy8vYa+nyRn14w=
Message-ID: <86802c440511211417h737474fbt57946f4f2396b701@mail.gmail.com>
Date: Mon, 21 Nov 2005 14:17:35 -0800
From: yhlu <yhlu.kernel@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: x86_64: apic id lift patch
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org, linuxbios@openbios.org
In-Reply-To: <20051121220605.GD20775@brahms.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <86802c440511211349t6a0a9d30i60e15fa23b86c49d@mail.gmail.com>
	 <20051121220605.GD20775@brahms.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you please explain clearly:
>
> - What are you changing.
1.  use core_vir instead of x86_max_cores, for E0 later single core,
core_vir could be 2, and x86_max_cores still is 1. So it makes node
calculation right.
2. not assuming that lifted apic id is continous. We can get exact
node id and core id from initial apicid.
> - What was the problem with the old behaviour
1. for E0 single core, node 2, initial apicid is 4, and old cold will
get node=4 instead of 2.
2. if the lifted apicid is not continous, it will assign strange node
id to the cpu.
> - Why that particular change
1. We can get exact node id and core id from initial apicid for E0 later.
> - Why can't that APIC number setup not be done by the BIOS itself
1. That patch the code more generic. and don't assume the lifted
apicid is continous.

Thanks

YH
