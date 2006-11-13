Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933070AbWKMVd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933070AbWKMVd0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 16:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933075AbWKMVdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 16:33:25 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64687 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S933070AbWKMVdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 16:33:25 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Adrian Bunk <bunk@stusta.de>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] make arch/i386/kernel/io_apic.c:irq_vector[] static
References: <20061113210342.GE22565@stusta.de>
Date: Mon, 13 Nov 2006 14:32:53 -0700
In-Reply-To: <20061113210342.GE22565@stusta.de> (Adrian Bunk's message of
	"Mon, 13 Nov 2006 22:03:42 +0100")
Message-ID: <m13b8nowvu.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> irq_vector[] can now become static.
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-by: Eric W. Biederman <ebiederm@xmission.com>

I made this change on x86_64 and forgot it can equally apply to i386.

> --- linux-2.6.19-rc5-mm1/arch/i386/kernel/io_apic.c.old 2006-11-13
> 18:13:14.000000000 +0100
> +++ linux-2.6.19-rc5-mm1/arch/i386/kernel/io_apic.c 2006-11-13
> 18:13:25.000000000 +0100
> @@ -1242,7 +1242,7 @@
>  }
>  
>  /* irq_vectors is indexed by the sum of all RTEs in all I/O APICs. */
> -u8 irq_vector[NR_IRQ_VECTORS] __read_mostly = { FIRST_DEVICE_VECTOR , 0 };
> +static u8 irq_vector[NR_IRQ_VECTORS] __read_mostly = { FIRST_DEVICE_VECTOR , 0
> };
>  
>  static int __assign_irq_vector(int irq)
>  {

Eric
