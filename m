Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265054AbRFVS3D>; Fri, 22 Jun 2001 14:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265034AbRFVS2x>; Fri, 22 Jun 2001 14:28:53 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:56524 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S265408AbRFVS2n>;
	Fri, 22 Jun 2001 14:28:43 -0400
Message-ID: <3B338E4E.D1FDD74D@mandrakesoft.com>
Date: Fri, 22 Jun 2001 14:28:30 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jhon H. Caicedo O." <jhcaiced@osso.org.co>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: AMD756 PCI IRQ Routing Patch 0.2.0
In-Reply-To: <3B3343E6.122965AC@osso.org.co>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jhon H. Caicedo O." wrote:
> This is an updated version of the patch for AMD756 PCI IRQ Routing,
> the changes are to use the read/write_config_nybble functions,
> this makes the code shorter.

Looks much better, thanks!

> +       printk(KERN_INFO "AMD756: dev %04x:%04x, router pirq : %d get irq : %2d\n",
> +               dev->vendor, dev->device, pirq, irq);
[...]
> +       printk(KERN_INFO "AMD756: dev %04x:%04x, router pirq : %d SET irq : %2d\n",
> +               dev->vendor, dev->device, pirq, irq);

None of the other PCI IRQ routines print out IRQ routing messages, so
these shouldn't either.  I assume this is debugging code?

Further, the printks are potentially misleading, because pirq_amd756_get
might not receive a valid irq, if 'pirq' is greater than 4.

	Jeff


-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
