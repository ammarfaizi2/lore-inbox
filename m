Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbUKTADn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbUKTADn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 19:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbUKTADA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 19:03:00 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:25728 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261374AbUKSXpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 18:45:15 -0500
Subject: Re: 2.6.9-ac10 compile error
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: haiquy@yahoo.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0411200859320.1593@linuxcd>
References: <Pine.LNX.4.53.0411200859320.1593@linuxcd>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100904126.8909.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 19 Nov 2004 22:42:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-11-20 at 09:15, haiquy@yahoo.com wrote:
> I got compile error with 2.6.9-ac10
> 
> root@perfectpc:/home/linux-2.6.9# make bzImage modules>/dev/null
> In file included from drivers/atm/../../include/asm/byteorder.h:5:
> /usr/include/linux/compiler.h:1:2: warning: #warning "You shouldn't be using this header"
> drivers/pnp/pnpbios/core.c: In function `pnpbios_init':
> drivers/pnp/pnpbios/core.c:541: error: `acpi_disabled' undeclared (first use in this function)
> drivers/pnp/pnpbios/core.c:541: error: (Each undeclared identifier is reported only once
> drivers/pnp/pnpbios/core.c:541: error: for each function it appears in.)

Thanks. That test needs an #ifdef CONFIG_ACPI around it. I've already
put out -ac11 but will fix in -ac12 (or say Y to ACPI).

