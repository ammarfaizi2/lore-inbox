Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268993AbUJELds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268993AbUJELds (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 07:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268995AbUJELds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 07:33:48 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:39317 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S268993AbUJELdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 07:33:46 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andi Kleen <ak@muc.de>
Subject: Re: 2.6.9-rc3-mm[12]: x86-64-clustered-apic-support.patch problem
Date: Tue, 5 Oct 2004 13:36:17 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <2LHjU-fJ-49@gated-at.bofh.it> <m3pt3yushp.fsf@averell.firstfloor.org>
In-Reply-To: <m3pt3yushp.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410051336.17345.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 of October 2004 22:40, Andi Kleen wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > Andrew,
> >
> > The patch x86-64-clustered-apic-support.patch causes the 2.6.9-rc3-mm[12] 
> > kernel to crash at startup on a single-CPU AMD64 box :
> 
> This untested patch may fix it. Does it?
> 
> -Andi
> 
> Index: linux/arch/x86_64/kernel/genapic.c
> ===================================================================
> --- linux.orig/arch/x86_64/kernel/genapic.c	2004-10-03 16:28:07.%N +0200
> +++ linux/arch/x86_64/kernel/genapic.c	2004-10-03 17:05:10.%N +0200
> @@ -27,7 +27,7 @@
>  extern struct genapic apic_cluster;
>  extern struct genapic apic_flat;
>  
> -struct genapic *genapic;
> +struct genapic *genapic = &apic_flat;
>  
>  
>  /*

Yes, it does.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
