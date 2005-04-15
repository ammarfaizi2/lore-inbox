Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbVDOQK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbVDOQK6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 12:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVDOQK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 12:10:58 -0400
Received: from f13.mail.ru ([194.67.57.43]:27917 "EHLO f13.mail.ru")
	by vger.kernel.org with ESMTP id S261846AbVDOQKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 12:10:52 -0400
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/serial/8250_acpi.c: fix a warning
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: 10.0.3.112 via proxy [217.10.38.130]
Date: Fri, 15 Apr 2005 20:10:54 +0400
In-Reply-To: <20050415151053.GM5456@stusta.de>
Reply-To: Alexey Dobriyan <adobriyan@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1DMTPC-000ASo-00.adobriyan-mail-ru@f13.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2005 17:10:53 +0200, Adrian Bunk wrote:

> This patch fixes the following warning:

>   CC      drivers/serial/8250_acpi.o
> drivers/serial/8250_acpi.c: In function `acpi_serial_ext_irq':
> drivers/serial/8250_acpi.c:51: warning: implicit declaration of function `acpi_register_gsi'

> --- linux-2.6.12-rc2-mm1-full/drivers/serial/8250_acpi.c.old
> +++ linux-2.6.12-rc2-mm1-full/drivers/serial/8250_acpi.c

> +#include <linux/config.h>

drivers/serial/8250_acpi.c doesn't use CONFIG_ symbols.
