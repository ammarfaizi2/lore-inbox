Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267254AbUIEVwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267254AbUIEVwl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 17:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267278AbUIEVwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 17:52:41 -0400
Received: from the-village.bc.nu ([81.2.110.252]:53662 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267254AbUIEVwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 17:52:39 -0400
Subject: Re: Intel ICH - sound/pci/intel8x0.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jaroslav Kysela <perex@suse.cz>
In-Reply-To: <9e47339104090514244873fd05@mail.gmail.com>
References: <20040905184852.GA25431@linux.ensimag.fr>
	 <9e47339104090514244873fd05@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094417386.1911.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 05 Sep 2004 21:49:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-09-05 at 22:24, Jon Smirl wrote:
> I'd don't know enough about the LPC bridge chip to know what the
> correct answer is for this. Right now I tend to think that the PCI
> driver should own the bridge chip. If not the PCI driver then there
> should be an explicit bridge driver. I don' think it is correct that a
> joystick driver is attaching to a bridge chip given the simple fact

Nobody else currently needs to attach to it so why make life needlessly
complicated.

> that all legacy IO - joystick, PS/2, parallel, serial, etc is located
> off from that same bridge chip.
> 
> Matthieu's comments about using PNP for this seem to make sense. Are
> we missing implementation of an ACPI feature for controlling these
> ports?

See previous discussion. We have isapnp, biospnp but not great acpi pnp.
None of them help because you need to deal with hotplug.

Alan

