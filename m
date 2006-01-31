Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030323AbWAaDbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030323AbWAaDbG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 22:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030319AbWAaDbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 22:31:06 -0500
Received: from xenotime.net ([66.160.160.81]:39878 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030326AbWAaDbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 22:31:05 -0500
Date: Mon, 30 Jan 2006 19:31:29 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "L. A. Walsh" <lkml@tlinx.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: i386 requires x86_64?
Message-Id: <20060130193129.19f04e6f.rdunlap@xenotime.net>
In-Reply-To: <43DED532.5060407@tlinx.org>
References: <43DED532.5060407@tlinx.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2006 19:10:42 -0800 L. A. Walsh wrote:

> Generating a new kernel and wanted to delete the unrelated architectures.
> 
> Is the i386 supposed to depend on the the x86_64 architecture?
> 
> In file included from arch/i386/kernel/acpi/earlyquirk.c:8:
> include/asm/pci-direct.h:1:35: asm-x86_64/pci-direct.h: No such file or 
> directory
> arch/i386/kernel/acpi/earlyquirk.c: In function `check_acpi_pci':
> arch/i386/kernel/acpi/earlyquirk.c:34: warning: implicit declaration of 
> function `read_pci_config'
> make[2]: *** [arch/i386/kernel/acpi/earlyquirk.o] Error 1
> make[1]: *** [arch/i386/kernel/acpi] Error 2
> make: *** [arch/i386/kernel] Error 2
> make: *** Waiting for unfinished jobs....
> 
> I'm generating for a pentium-3 based computer.  Should that
> include x86_64 bits?

Yes, there are bits in i386 that use x86_64 and there are
bits in x86_64 that use i386 code, so that the source code
won't have to be duplicated.


---
~Randy
