Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbVHLI3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbVHLI3R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 04:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbVHLI3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 04:29:17 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:20932 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750709AbVHLI3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 04:29:16 -0400
Subject: Re: [PATCH] IDE: don't offer IDE_GENERIC on ia64
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, linux-ia64@vger.kernel.org
In-Reply-To: <200508111424.43150.bjorn.helgaas@hp.com>
References: <200508111424.43150.bjorn.helgaas@hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 12 Aug 2005 09:40:12 +0100
Message-Id: <1123836012.22460.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-08-11 at 14:24 -0600, Bjorn Helgaas wrote:
> IA64 boxes only have PCI IDE devices, so there's no need to blindly poke
> around in I/O port space.  Poking at things that don't exist causes MCAs
> on HP ia64 systems.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Nak-by: Alan Cox <alan@redhat.com>

Assuming all IA-64 boxes are PCI or better then you actually want to
edit include/asm-ia64/ide.h and edit ide_default_io_base where someone
years ago cut and pasted x86-32 values so that case 2-5 are removed.
Then you will just probe the compatibility mode PCI addresses for system
IDE channels.


