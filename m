Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267971AbUHKLBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267971AbUHKLBg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 07:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268026AbUHKLBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 07:01:35 -0400
Received: from the-village.bc.nu ([81.2.110.252]:29904 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267971AbUHKLBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 07:01:30 -0400
Subject: Re: 2.6.8-rc4-mm1 doesn't boot
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200408101646.57542.bjorn.helgaas@hp.com>
References: <20040810002110.4fd8de07.akpm@osdl.org>
	 <200408100959.18903.bjorn.helgaas@hp.com>
	 <20040810173223.GQ26174@fs.tum.de>
	 <200408101646.57542.bjorn.helgaas@hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092218191.19009.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 11 Aug 2004 10:56:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-08-10 at 23:46, Bjorn Helgaas wrote:
> I'm confused.  I think the hang is related to IDE, but that
> code all looks OK.  I expected to see a note about ACPI routing
> the IDE interrupt, something like this:

The IDE interrupt for the southbridge legacy controller will
not be in PCI space. It's hardwired for IRQ 14/15 in legacy mode,
PCI int (if wired) in native.

