Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284795AbRLHUhJ>; Sat, 8 Dec 2001 15:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284787AbRLHUg7>; Sat, 8 Dec 2001 15:36:59 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37129 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284805AbRLHUgp>; Sat, 8 Dec 2001 15:36:45 -0500
Subject: Re: [PATCH] 2.4.16 kernel/printk.c (per processorinitializationcheck)
To: davidm@hpl.hp.com
Date: Sat, 8 Dec 2001 20:45:07 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        akpm@zip.com.au (Andrew Morton), j-nomura@ce.jp.nec.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <15378.17075.960942.357075@napali.hpl.hp.com> from "David Mosberger" at Dec 08, 2001 08:41:23 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16CoLL-0002bW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Alan> x86_udelay_tsc wont have been set at that point so the main
>   Alan> timer is still being used.
> 
> x86 does use current_cpu_data.loops_per_jiffy in the non-TSC case, no?

I believe so.  So we should propogate that across earlier, although its
not needed for our current console drivers that I can see
