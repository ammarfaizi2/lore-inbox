Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261381AbREQJWX>; Thu, 17 May 2001 05:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261382AbREQJWD>; Thu, 17 May 2001 05:22:03 -0400
Received: from unamed.infotel.bg ([212.39.68.18]:38661 "EHLO l.himel.bg")
	by vger.kernel.org with ESMTP id <S261381AbREQJV6>;
	Thu, 17 May 2001 05:21:58 -0400
Date: Thu, 17 May 2001 12:22:15 +0300 (EEST)
From: Julian Anastasov <ja@ssi.bg>
To: Andrew Morton <andrewm@uow.edu.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: locked 3c905B with 2.4.5pre2
In-Reply-To: <3B0336E1.5ED05565@uow.edu.au>
Message-ID: <Pine.LNX.4.10.10105171215440.2977-100000@l>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Thu, 17 May 2001, Andrew Morton wrote:

> > eth0: Interrupt posted but not delivered -- IRQ blocked by another device?
>
> This is a failure of the APIC interrupt controller in
> the 2.4 kernel.  You'll need to boot your kernel with
> the `noapic' LILO option.  Or run -ac kernels, which
> have a software workaround which fixes the problem.

	Yes, it seems noapic solved the problem with the lockup :(

> Rumour has it that the APIC fix will be merged into Linus' tree
> very soon.  It needs to be - one of the more important ethernet
> drivers is basically unviable on x86 SMP in 2.4.

	Agreed :) The performance sucks without apic.

Regards

--
Julian Anastasov <ja@ssi.bg>

