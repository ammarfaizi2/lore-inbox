Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965810AbWKTNCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965810AbWKTNCx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 08:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965816AbWKTNCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 08:02:53 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:37137 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965810AbWKTNCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 08:02:52 -0500
Date: Mon, 20 Nov 2006 13:02:37 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Tony Olech <tony.olech@elandigitalsystems.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
       Linux kernel development <linux-kernel@vger.kernel.org>,
       PCMCIA Maintainence <linux-pcmcia@lists.infradead.org>,
       David Hinds <dahinds@users.sourceforge.net>,
       Jaroslav Kysela <perex@suse.cz>,
       Bart Prescott <bart.prescott@elandigitalsystems.com>
Subject: Re: [PATCH] PCMCIA identification strings for cards manufactured by Elan
Message-ID: <20061120130237.GA22330@flint.arm.linux.org.uk>
Mail-Followup-To: Tony Olech <tony.olech@elandigitalsystems.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Linux kernel development <linux-kernel@vger.kernel.org>,
	PCMCIA Maintainence <linux-pcmcia@lists.infradead.org>,
	David Hinds <dahinds@users.sourceforge.net>,
	Jaroslav Kysela <perex@suse.cz>,
	Bart Prescott <bart.prescott@elandigitalsystems.com>
References: <200611201214.kAKCErcU005240@imap.elan.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611201214.kAKCErcU005240@imap.elan.private>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 11:17:15AM +0000, Tony Olech wrote:
> In older versions of the linux kernel it was sufficient for the
> 16-bit PCMCIA card manufacturer to distribute or make available
> a text configuration file along with the physical cards. Such a
> file with an extension of ".conf" and placed in the /etc/pcmcia
> very easily enabled new hardware without rebuilding the kernel,
> however with the new scheme of things, having found no userland
> solution to the problem of new 16bit pcmcia card identification
> this patch enumerates Elan Digital Systems strings.

> *** linux-2.6.18/drivers/serial/serial_cs.c.orig	2006-11-17 10:59:10.000000000 +0000
> --- linux-2.6.18/drivers/serial/serial_cs.c	2006-11-17 10:59:54.000000000 +0000
> ***************
> *** 786,793 ****
> --- 786,817 ----
>   	PCMCIA_DEVICE_CIS_PROD_ID12("ADVANTECH", "COMpad-32/85B-4", 0x96913a85, 0xcec8f102, "COMpad4.cis"),
>   	PCMCIA_DEVICE_CIS_PROD_ID123("ADVANTECH", "COMpad-32/85", "1.0", 0x96913a85, 0x8fbe92ae, 0x0877b627, "COMpad2.cis"),
>   	PCMCIA_DEVICE_CIS_PROD_ID2("RS-COM 2P", 0xad20b156, "RS-COM-2P.cis"),
>   	PCMCIA_DEVICE_CIS_MANF_CARD(0x0013, 0x0000, "GLOBETROTTER.cis"),
> + 	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c1997.","SERIAL CARD: SL100  1.00.",0x19ca78af,0xf964f42b),
> + 	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c1997.","SERIAL CARD: SL100",0x19ca78af,0x71d98e83),
> + 	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c1997.","SERIAL CARD: SL232  1.00.",0x19ca78af,0x69fb7490),
> + 	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c1997.","SERIAL CARD: SL232",0x19ca78af,0xb6bc0235),
> + 	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c2000.","SERIAL CARD: CF232",0x63f2e0bd,0xb9e175d3),
> + 	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c2000.","SERIAL CARD: CF232-5",0x63f2e0bd,0xfce33442),
> + 	PCMCIA_DEVICE_PROD_ID12("Elan","Serial Port: CF232",0x3beb8cf2,0x171e7190),
> + 	PCMCIA_DEVICE_PROD_ID12("Elan","Serial Port: CF232-5",0x3beb8cf2,0x20da4262),
> + 	PCMCIA_DEVICE_PROD_ID12("Elan","Serial Port: CF428",0x3beb8cf2,0xea5dd57d),
> + 	PCMCIA_DEVICE_PROD_ID12("Elan","Serial Port: CF500",0x3beb8cf2,0xd77255fa),
> + 	PCMCIA_DEVICE_PROD_ID12("Elan","Serial Port: IC232",0x3beb8cf2,0x6a709903),
> + 	PCMCIA_DEVICE_PROD_ID12("Elan","Serial Port: SL232",0x3beb8cf2,0x18430676),
> + 	PCMCIA_DEVICE_PROD_ID12("Elan","Serial Port: XL232",0x3beb8cf2,0x6f933767),
> + 	PCMCIA_MFC_DEVICE_PROD_ID12(0,"Elan","Serial Port: CF332",0x3beb8cf2,0x16dc1ba7),
> + 	PCMCIA_MFC_DEVICE_PROD_ID12(0,"Elan","Serial Port: SL332",0x3beb8cf2,0x19816c41),
> + 	PCMCIA_MFC_DEVICE_PROD_ID12(0,"Elan","Serial Port: SL385",0x3beb8cf2,0x64112029),
> + 	PCMCIA_MFC_DEVICE_PROD_ID12(0,"Elan","Serial Port: SL432",0x3beb8cf2,0x1cce7ac4),
> + 	PCMCIA_MFC_DEVICE_PROD_ID12(0,"Elan","Serial+Parallel Port: SP230",0x3beb8cf2,0xdb9e58bc),
> + 	PCMCIA_MFC_DEVICE_PROD_ID12(1,"Elan","Serial Port: CF332",0x3beb8cf2,0x16dc1ba7),
> + 	PCMCIA_MFC_DEVICE_PROD_ID12(1,"Elan","Serial Port: SL332",0x3beb8cf2,0x19816c41),
> + 	PCMCIA_MFC_DEVICE_PROD_ID12(1,"Elan","Serial Port: SL385",0x3beb8cf2,0x64112029),
> + 	PCMCIA_MFC_DEVICE_PROD_ID12(1,"Elan","Serial Port: SL432",0x3beb8cf2,0x1cce7ac4),
> + 	PCMCIA_MFC_DEVICE_PROD_ID12(2,"Elan","Serial Port: SL432",0x3beb8cf2,0x1cce7ac4),
> + 	PCMCIA_MFC_DEVICE_PROD_ID12(3,"Elan","Serial Port: SL432",0x3beb8cf2,0x1cce7ac4),

Shouldn't these be matched by the function ID?  Show the full output
of cardctl ident (or whatever the pcmcia-utils equivalent is).

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
