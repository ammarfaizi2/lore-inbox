Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285909AbRLHLYU>; Sat, 8 Dec 2001 06:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285913AbRLHLYK>; Sat, 8 Dec 2001 06:24:10 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42757 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285909AbRLHLX4>; Sat, 8 Dec 2001 06:23:56 -0500
Subject: Re: [PATCH] 2.4.16 kernel/printk.c (per processorinitializationcheck)
To: davidm@hpl.hp.com
Date: Sat, 8 Dec 2001 11:27:19 +0000 (GMT)
Cc: marcelo@conectiva.com.br (Marcelo Tosatti),
        akpm@zip.com.au (Andrew Morton), j-nomura@ce.jp.nec.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <15377.26745.265632.705793@napali.hpl.hp.com> from "David Mosberger" at Dec 07, 2001 05:10:17 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16CfdX-00017X-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm no x86 expert, but I have the impression that
> current_cpu_data.loops_per_jiffy will be invalid (probably 0) until
> smp_store_cpu_info() is called in smp_callin().  If so, a console
> driver using udelay() might not work properly.  I suspect there are
> other issues, but this is just based on looking at the x86 source code
> for 5 minutes.

x86_udelay_tsc wont have been set at that point so the main timer is still
being used.
