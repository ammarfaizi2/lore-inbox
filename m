Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267209AbUHaTcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267209AbUHaTcW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 15:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267223AbUHaTbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 15:31:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:42145 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268944AbUHaT21 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:28:27 -0400
Date: Tue, 31 Aug 2004 12:26:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@intel.com
Subject: Re: 2.6.9-rc1-mm2
Message-Id: <20040831122636.15b07a4e.akpm@osdl.org>
In-Reply-To: <230680000.1093978386@flay>
References: <20040830235426.441f5b51.akpm@osdl.org>
	<230680000.1093978386@flay>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm2/
> > 
> > Nothing particularly noteworthy here.  Some seriously bad scheduler
> > performance with SMT and HT was fixed up, as was the
> > fails-to-read-the-last-4k-of-a-file brown bag.
> 
> Something is borked in ACPI:
> 
> drivers/built-in.o(.text+0x1cf2c): In function `acpi_pci_root_add':
> /root/linux/2.6.9-rc1-mm2/drivers/acpi/pci_root.c:270: undefined reference to `pci_acpi_scan_root'
> 
> Didn't actually realise I had ACPI config'ed in, so will just get rid of
> it, but though you might want to know.

I assume this is due to the ACPI Kconfig circular dependency?
