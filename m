Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWJBLu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWJBLu0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 07:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWJBLu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 07:50:26 -0400
Received: from 195-13-16-24.net.novis.pt ([195.23.16.24]:170 "EHLO
	bipbip.grupopie.com") by vger.kernel.org with ESMTP id S932117AbWJBLuZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 07:50:25 -0400
Message-ID: <4520FCFE.1080704@grupopie.com>
Date: Mon, 02 Oct 2006 12:50:22 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Jim Gettys <jg@laptop.org>,
       John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch 16/21] high-res timers: core
References: <20061001225720.115967000@cruncher.tec.linutronix.de> <20061001225724.868951000@cruncher.tec.linutronix.de>
In-Reply-To: <20061001225724.868951000@cruncher.tec.linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> [...]
> Index: linux-2.6.18-mm2/kernel/hrtimer.c
> ===================================================================
> --- linux-2.6.18-mm2.orig/kernel/hrtimer.c	2006-10-02 00:55:53.000000000 +0200
> +++ linux-2.6.18-mm2/kernel/hrtimer.c	2006-10-02 00:55:54.000000000 +0200
> @@ -38,7 +38,11 @@
>  #include <linux/hrtimer.h>
>  #include <linux/notifier.h>
>  #include <linux/syscalls.h>
> +#include <linux/kallsyms.h>

I'm not really knowledgeable in timer code to review these patches, but 
I always keep an eye out for kallsyms uses.

It seems that this include is unused. Maybe it was some debug stuff that 
got moved (or removed) later?

The patch to kernel/timer.c seems to have the same unused include, too.

-- 
Paulo Marques - www.grupopie.com

"The face of a child can say it all, especially the
mouth part of the face."
