Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289871AbSAWOva>; Wed, 23 Jan 2002 09:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289874AbSAWOvK>; Wed, 23 Jan 2002 09:51:10 -0500
Received: from colorfullife.com ([216.156.138.34]:21252 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S289872AbSAWOvE>;
	Wed, 23 Jan 2002 09:51:04 -0500
Date: Wed, 23 Jan 2002 15:50:59 +0100 (CET)
From: Manfred Spraul <manfred@colorfullife.com>
X-X-Sender: <manfred@dbl.localdomain>
To: "David S. Miller" <davem@redhat.com>
cc: <masp0008@stud.uni-saarland.de>, <drobbins@gentoo.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Athlon/AGP issue update
In-Reply-To: <20020123.034411.71089598.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0201231546560.23603-100000@dbl.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2002, David S. Miller wrote:

>
> This isn't true.  The speculative store won't get data into the
> cache if there is a TLB miss.
>
The Pentium III loads TLB entries speculatively, there is a Intel
document how to flush tbl entries where they explicitely mention that.

> 4MB pages map the GART pages and "other stuff", ie. memory used by
> other subsystems, user pages and whatever else.  This is the only
> way the bug can be thus triggered for kernel mappings, which is why
> turning off 4MB pages fixes this part.
>

We might be luky - pIII performs speculative tlb loads, and Athlon
performs spurious cache line writeouts, but I don´t trust such solutions.

