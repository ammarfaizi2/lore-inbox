Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288998AbSBDO52>; Mon, 4 Feb 2002 09:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289004AbSBDO5R>; Mon, 4 Feb 2002 09:57:17 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:53009 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S288998AbSBDO5E>; Mon, 4 Feb 2002 09:57:04 -0500
Message-Id: <200202041455.g14EtSt14092@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Oliver Feiler <kiza@gmx.net>
Subject: Re: fixup descriptions in pci-pc.c
Date: Mon, 4 Feb 2002 16:55:29 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020203152913.A533@gmx.net> <200202041311.g14DB2t12901@Port.imtp.ilyichevsk.odessa.ua> <20020204154946.A235@gmx.net>
In-Reply-To: <20020204154946.A235@gmx.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 February 2002 12:49, Oliver Feiler wrote:
> Denis Vlasenko wrote:
> > Probably. + [reg]: old->new or similar
>
> 	Ok. Better with this?
>
>
> --- linux-2.4.18-pre7/arch/i386/kernel/pci-pc.c	Mon Feb  4 15:13:45 2002
> +++ linux-2.4.18-pre7_testing/arch/i386/kernel/pci-pc.c	Mon Feb  4 15:15:13
> 2002 @@ -1129,7 +1129,7 @@
>
>  	pci_read_config_byte(d, where, &v);
>  	if (v & 0xe0) {
> -		printk("Trying to stomp on VIA Northbridge bug...\n");
> +		printk("Disabling VIA memory write queue. Clearing bits 5, 6, 7 at
> 0x%x.\n", where); v &= 0x1f; /* clear bits 5, 6, 7 */
>  		pci_write_config_byte(d, where, v);
>  	}

printk("Disabling VIA memory write queue: [%02x] %02x->%02x\n", where, v, v & 0x1f);

This way we will see exactly where and what changed
--
vda
