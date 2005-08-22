Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751471AbVHVWeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbVHVWeU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbVHVWeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:34:18 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:31370 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751458AbVHVWeP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:34:15 -0400
Date: Mon, 22 Aug 2005 09:47:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: Chuck Harding <charding@llnl.gov>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-rt9
Message-ID: <20050822074740.GA19386@elte.hu>
References: <200508191241.39340.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508191241.39340.annabellesgarden@yahoo.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Karsten Wiese <annabellesgarden@yahoo.de> wrote:

> diff -up arch/i386/kernel/io_apic.c.rt9 arch/i386/kernel/io_apic.c
> --- arch/i386/kernel/io_apic.c.rt9      2005-08-19 12:28:42.000000000 +0200
> +++ arch/i386/kernel/io_apic.c  2005-08-19 12:29:30.000000000 +0200
> @@ -1758,8 +1758,8 @@ void disable_IO_APIC(void)
>                  * Add it to the IO-APIC irq-routing table:
>                  */
>                 spin_lock_irqsave(&ioapic_lock, flags);
> -               io_apic_write(0, 0x11+2*pin, *(((int *)&entry)+1));
> -               io_apic_write(0, 0x10+2*pin, *(((int *)&entry)+0));
> +               io_apic_write(ioapic_data[0], 0x11+2*pin, *(((int *)&entry)+1));
> +               io_apic_write(ioapic_data[0], 0x10+2*pin, *(((int *)&entry)+0));
>                 spin_unlock_irqrestore(&ioapic_lock, flags);

i've hand-applied it - note that your mailer has converted all tabs to 
spaces.

	Ingo
