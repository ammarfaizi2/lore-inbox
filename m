Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267401AbUIFCJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267401AbUIFCJk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 22:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267403AbUIFCJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 22:09:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:34192 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267401AbUIFCJi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 22:09:38 -0400
Date: Sun, 5 Sep 2004 19:09:37 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jonsmirl@gmail.com, linux-kernel@vger.kernel.org, perex@suse.cz
Subject: Re: Intel ICH - sound/pci/intel8x0.c
Message-Id: <20040905190937.36e72b49.rddunlap@osdl.org>
In-Reply-To: <1094417386.1911.0.camel@localhost.localdomain>
References: <20040905184852.GA25431@linux.ensimag.fr>
	<9e47339104090514244873fd05@mail.gmail.com>
	<1094417386.1911.0.camel@localhost.localdomain>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Sep 2004 21:49:50 +0100 Alan Cox wrote:

| On Sul, 2004-09-05 at 22:24, Jon Smirl wrote:
| > I'd don't know enough about the LPC bridge chip to know what the
| > correct answer is for this. Right now I tend to think that the PCI
| > driver should own the bridge chip. If not the PCI driver then there
| > should be an explicit bridge driver. I don' think it is correct that a
| > joystick driver is attaching to a bridge chip given the simple fact
| 
| Nobody else currently needs to attach to it so why make life needlessly
| complicated.

What I/O addresses are we talking about here?
There is someone working on a SD/MMC (blah blah) memory card interface
that is on LPC, using what used to be reserved as timer IO ports
(0x40 - 0x5f), and he's splitting timer ports up into 2 ranges:
0x40 - 0x43 and 0x50 - 0x53, so that the LPC ports are available.

| > that all legacy IO - joystick, PS/2, parallel, serial, etc is located
| > off from that same bridge chip.
| > 
| > Matthieu's comments about using PNP for this seem to make sense. Are
| > we missing implementation of an ACPI feature for controlling these
| > ports?
| 
| See previous discussion. We have isapnp, biospnp but not great acpi pnp.
| None of them help because you need to deal with hotplug.

--
~Randy
