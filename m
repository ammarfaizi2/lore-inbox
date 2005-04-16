Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVDPH7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVDPH7h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 03:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbVDPH7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 03:59:37 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:42000 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261343AbVDPH7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 03:59:32 -0400
Date: Sat, 16 Apr 2005 08:59:23 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Alexey Dobriyan <adobriyan@mail.ru>, Andrew Morton <akpm@osdl.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-serial@vger.kernel.org,
       linux-kernel@vger.kernel.org, len.brown@intel.com,
       acpi-devel@lists.sourceforge.ne
Subject: Re: [2.6 patch] drivers/serial/8250_acpi.c: fix a warning
Message-ID: <20050416085923.A10826@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Alexey Dobriyan <adobriyan@mail.ru>, Andrew Morton <akpm@osdl.org>,
	Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, len.brown@intel.com,
	acpi-devel@lists.sourceforge.ne
References: <20050415151053.GM5456@stusta.de> <E1DMTPC-000ASo-00.adobriyan-mail-ru@f13.mail.ru> <20050416023852.GI4831@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050416023852.GI4831@stusta.de>; from bunk@stusta.de on Sat, Apr 16, 2005 at 04:38:52AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 16, 2005 at 04:38:52AM +0200, Adrian Bunk wrote:
> In the Linux kernel, it's more common to put such header dependencies 
> for header files into the C files, but if the ACPI people agree a patch 
> to add the #include <linux/config.h> to acpi_bus.h is the other possble 
> correct solution for this issue.

With the exception of linux/config.h.

Do a 'make configcheck' and it'll tell you where linux/config.h is missing
and where it shouldn't be.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
