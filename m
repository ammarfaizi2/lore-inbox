Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966112AbWKJUjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966112AbWKJUjZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 15:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966113AbWKJUjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 15:39:25 -0500
Received: from www.osadl.org ([213.239.205.134]:37046 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S966112AbWKJUjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 15:39:24 -0500
Subject: Re: 2.6.19-rc5-mm1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Benoit Boissinot <bboissin@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <40f323d00611101220t2b8067d5g4f6b302384e41524@mail.gmail.com>
References: <20061108015452.a2bb40d2.akpm@osdl.org>
	 <40f323d00611100829m5fbd32cdt14c307e492df2984@mail.gmail.com>
	 <1163177952.8335.221.camel@localhost.localdomain>
	 <40f323d00611100925l45b2415bjcc611df6e4d1f7d4@mail.gmail.com>
	 <40f323d00611101220t2b8067d5g4f6b302384e41524@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 10 Nov 2006 21:41:44 +0100
Message-Id: <1163191305.8335.228.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-10 at 21:20 +0100, Benoit Boissinot wrote:
> It works fine with the following additional patch.
> 
> Thanks,
> 
> Benoit

Doh, this modular build of ACPI again.

Acked-by: Thomas Gleixner <tglx@linutronix.de>

> Index: linux-mm/arch/i386/kernel/apic.c
> ===================================================================
> --- a/arch/i386/kernel/apic.c	2006-11-10 20:42:30.000000000 +0100
> +++ b/arch/i386/kernel/apic.c	2006-11-10 20:42:41.000000000 +0100
> @@ -610,6 +610,7 @@
>  	if (evt->event_handler)
>  		clockevents_set_broadcast(evt, broadcast);
>  }
> +EXPORT_SYMBOL_GPL(lapic_timer_idle_broadcast);
> 
>  int setup_profiling_timer(unsigned int multiplier)
>  {

