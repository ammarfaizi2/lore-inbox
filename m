Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261797AbULLMdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbULLMdv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 07:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbULLMdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 07:33:51 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:3806 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261797AbULLMdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 07:33:50 -0500
Subject: Re: PCI IRQ problems -- update
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jim Paris <jim@jtan.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041211202314.GA22731@jim.sh>
References: <20041211173538.GA21216@jim.sh>
	 <1102783555.7267.37.camel@localhost.localdomain>
	 <20041211202314.GA22731@jim.sh>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1102850984.1332.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 12 Dec 2004 11:29:46 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-12-11 at 20:23, Jim Paris wrote:
> The ICH3-M datasheet says offset 0x09 is the Programming Interface
> register.  Default value is 0x8A (legacy on both), value here is 0x8E
> (legacy on primary, native on secondary).  This mixed-mode setting
> is noted as a disallowed combination in the datasheet.
> 
> So it looks like my BIOS is screwing me.  Where could/should I fix
> this up?

A PCI quirk would be the obvious place, or in the ICH driver
(drivers/ide/pci/piix). You might want to print it early in boot and
make sure it was the BIOS not the kernel that did it.

