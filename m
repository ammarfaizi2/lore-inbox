Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760612AbWLFNt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760612AbWLFNt4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 08:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760613AbWLFNt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 08:49:56 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41504 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760612AbWLFNt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 08:49:56 -0500
Date: Wed, 6 Dec 2006 13:57:15 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI legacy resource fix
Message-ID: <20061206135715.2ca1dd7f@localhost.localdomain>
In-Reply-To: <20061206134143.GA6772@linux-mips.org>
References: <20061206134143.GA6772@linux-mips.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006 13:41:43 +0000
Ralf Baechle <ralf@linux-mips.org> wrote:

> Since commit 368c73d4f689dae0807d0a2aa74c61fd2b9b075f the kernel will try
> to update the non-writeable BAR registers 0..3 of PIIX4 IDE adapters if
> pci_assign_unassigned_resources() is used to do full resource assignment
> of the bus.  This fails because in the PIIX4 these BAR registers have
> implicitly assumed values and read back as zero; it used to work because
> the kernel used to just write zero to that register the read back value
> did match what was written.
> 
> The fix is a new resource flag IORESOURCE_PCI_FIXED used to mark a
> resource as non-movable.  This will also be useful to keep other import
> system resources from being moved around - for example system consoles
> on PCI busses.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

Acked-by: Alan Cox <alan@redhat.com>
