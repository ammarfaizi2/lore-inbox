Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289072AbSA1Ame>; Sun, 27 Jan 2002 19:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289073AbSA1AmZ>; Sun, 27 Jan 2002 19:42:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22283 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289072AbSA1AmJ>;
	Sun, 27 Jan 2002 19:42:09 -0500
Message-ID: <3C549E5E.4ACA093D@mandrakesoft.com>
Date: Sun, 27 Jan 2002 19:42:06 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.3-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Brian Gerst <bgerst@didntduck.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix NR_IRQS when no IO apic
In-Reply-To: <3C549AEC.D79A95FC@didntduck.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:
> 
> NR_IRQS should be 16 when the IO apic is not configured, as the 8259 PIC
> cannot generate any more interrupts.  It also fixes a bug where the IDT
> gets populated with random addresses, since only 16 entry stubs are
> created.

> +#ifdef CONFIG_X86_IO_APIC
>  #define NR_IRQS 224
> +#else
> +#define NR_IRQS 16
> +#endif

What about when ioapic is configured but not present?

	Jeff



-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
