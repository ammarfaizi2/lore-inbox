Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbUKIGHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbUKIGHY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 01:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbUKIGAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 01:00:43 -0500
Received: from fmr12.intel.com ([134.134.136.15]:24198 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S261405AbUKIFnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 00:43:05 -0500
Subject: Re: Spurious interrupts when SCI shared with e100
From: Len Brown <len.brown@intel.com>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ganesh.venkatesan@intel.com, John Ronciak <john.ronciak@intel.com>
In-Reply-To: <20041108115955.1c8bf10f.us15@os.inf.tu-dresden.de>
References: <20041108115955.1c8bf10f.us15@os.inf.tu-dresden.de>
Content-Type: text/plain
Organization: 
Message-Id: <1099978966.6092.36.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 09 Nov 2004 00:42:46 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-08 at 05:59, Udo A. Steinberg wrote:
> My laptop has IRQ9 configured as ACPI SCI. When IRQ9 is shared between
> ACPI and e100 an IRQ9 storm occurs when e100 is enabled, as can be
> seen in the dmesg output below.

Is this new with 2.6.10-rc1, or has it always been broken in an
ACPI-enabled kernel with acpi sharing an irq with e100?

I suspect this may be a bug in the e100 -- it may have enabled
interrupts before it has registered a handler.

Assuming it is a receive interrupt, you may be able to verify this by
plugging in the network cable after the system has probed e100 and see
if it works normally after that.

Also, you might try out the eepro100 driver to see if it behaves any
differently.

thanks,
-Len


