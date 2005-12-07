Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbVLGPnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbVLGPnG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 10:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbVLGPnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 10:43:05 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:50348 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751149AbVLGPnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 10:43:03 -0500
Subject: Re: [RFC]add ACPI hooks for IDE suspend/resume
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Shaohua Li <shaohua.li@intel.com>,
       linux-ide <linux-ide@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, pavel <pavel@ucw.cz>,
       Len Brown <len.brown@intel.com>, akpm <akpm@osdl.org>
In-Reply-To: <58cb370e0512070645o78569e82y63483a9ae5511f52@mail.gmail.com>
References: <1133849404.3026.10.camel@sli10-mobl.sh.intel.com>
	 <20051206222001.GA14171@srcf.ucam.org>
	 <58cb370e0512070017u606ee22fse207b9a859856dd4@mail.gmail.com>
	 <20051207131454.GA16558@srcf.ucam.org>
	 <58cb370e0512070619k17022317v8e871dc3f9cafb9@mail.gmail.com>
	 <20051207143337.GA16938@srcf.ucam.org>
	 <58cb370e0512070645o78569e82y63483a9ae5511f52@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 07 Dec 2005 15:41:14 +0000
Message-Id: <1133970074.544.69.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-12-07 at 15:45 +0100, Bartlomiej Zolnierkiewicz wrote:
> OK, I understand it now - when using 'ide-generic' host driver for IDE
> PCI device, resume fails (for obvious reason - IDE PCI device is not
> re-configured) and this patch fixes it through using ACPI methods.

Even in the piix case some devices need it because the bios wants to
issue commands such as password control if the laptop is set up in
secure modes.

