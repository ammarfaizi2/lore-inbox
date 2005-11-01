Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbVKAJyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbVKAJyD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 04:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbVKAJyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 04:54:03 -0500
Received: from ozlabs.org ([203.10.76.45]:17048 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750712AbVKAJyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 04:54:02 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17255.13329.695936.607613@cargo.ozlabs.ibm.com>
Date: Tue, 1 Nov 2005 20:23:29 +1100
From: Paul Mackerras <paulus@samba.org>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, moilanen@austin.ibm.com
Subject: Re: [PATCH] tpm: support PPC64 hardware
In-Reply-To: <1130769479.4882.35.camel@localhost.localdomain>
References: <1130769479.4882.35.camel@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kylene Jo Hall writes:

> The TPM is discovered differently on PPC64 because the device must be
> discovered through the device tree in order to open the proper holes in
> the io_page_mask for reading and writing in the low memory space.  This
> does not happen automatically like most devices because the tpm is not a
> normal pci device and lives under the root node.

Please just do an ioremap on the physical address and use
read[bwl]/write[bwl] or ioread{8,16,32}/iowrite{8,16,32}, or else
persuade the firmware developers to put the tpm in the right place in
the device tree.

Thanks,
Paul.
