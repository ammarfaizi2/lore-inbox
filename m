Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317811AbSGaHVZ>; Wed, 31 Jul 2002 03:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317814AbSGaHVZ>; Wed, 31 Jul 2002 03:21:25 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55050 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317811AbSGaHVY>; Wed, 31 Jul 2002 03:21:24 -0400
Date: Wed, 31 Jul 2002 08:24:42 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5.29] parport_serial/serial init dependencies (fwd)
Message-ID: <20020731082442.A17010@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0207310837050.2454-100000@linux-box.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207310837050.2454-100000@linux-box.realnet.co.sz>; from zwane@linuxpower.ca on Wed, Jul 31, 2002 at 08:37:23AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2002 at 08:37:23AM +0200, Zwane Mwaikambo wrote:
> diff -u -r1.1.1.1 Makefile
> --- linux-2.5.29/drivers/Makefile	27 Jul 2002 18:02:33 -0000	1.1.1.1
> +++ linux-2.5.29/drivers/Makefile	30 Jul 2002 22:45:59 -0000
> @@ -7,8 +7,9 @@
>  
>  obj-$(CONFIG_PCI)		+= pci/
>  obj-$(CONFIG_ACPI)		+= acpi/
> +obj-y				+= serial/
>  obj-$(CONFIG_PARPORT)		+= parport/
> -obj-y				+= base/ serial/ char/ block/ misc/ net/ media/
> +obj-y				+= base/ char/ block/ misc/ net/ media/

Hmm.  Looking at this (and the init ordering), doesn't pci use stuff from
base, so wouldn't it make sense to move base/ to being the very first
thing?  Pat?

(eg, when serial gets driverfs support)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

