Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132685AbRC2IQu>; Thu, 29 Mar 2001 03:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132689AbRC2IQj>; Thu, 29 Mar 2001 03:16:39 -0500
Received: from chiara.elte.hu ([157.181.150.200]:9993 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S132685AbRC2IQV>;
	Thu, 29 Mar 2001 03:16:21 -0500
Date: Thu, 29 Mar 2001 09:14:32 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [patch] pae-2.4.3-C3
In-Reply-To: <200103290610.f2T6A7s282810@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.30.0103290754110.918-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 29 Mar 2001, Albert D. Cahalan wrote:

> > the problem is that redzoning is enabled unconditionally, and SLAB has no
> > information about how crutial alignment is in the case of any particular
> > SLAB cache. The CPU generates a general protection fault if in PAE mode a
> > non-16-byte aligned pgd is loaded into %cr3.
>
> How about just fixing the debug code to align things? Sure it wastes a
> bit of memory, but debug code is like that.

redzoning also catches code which assumes specific alignment.

	Ingo

