Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268484AbUI2PXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268484AbUI2PXQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 11:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268633AbUI2PVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 11:21:32 -0400
Received: from bhhdoa.org.au ([216.17.101.199]:31756 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S268484AbUI2POS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 11:14:18 -0400
Date: Wed, 29 Sep 2004 18:13:44 +0300 (EAT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartmann <greg@kroah.com>, Len Brown <len.brown@intel.com>,
       tony.luck@intel.com, acpi-devel@lists.sourceforge.net,
       linux-ia64@vger.kernel.org
Subject: Re: [ACPI] [PATCH] Updated patches for PCI IRQ resource deallocation
 support [2/3]
In-Reply-To: <415A28B9.6080504@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.61.0409291809270.3056@musoma.fsmlabs.com>
References: <Pine.LNX.4.53.0409251356110.2914@musoma.fsmlabs.com>
 <Pine.LNX.4.53.0409251401560.2914@musoma.fsmlabs.com>
 <Pine.LNX.4.53.0409251416570.2908@musoma.fsmlabs.com> <4157A9D7.4090605@jp.fujitsu.com>
 <Pine.LNX.4.61.0409281702580.3052@musoma.fsmlabs.com> <415A28B9.6080504@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sep 2004, Kenji Kaneshige wrote:

> I'm trying to update my patch based on the feedback from you. Updated
> patch defines acpi_unregister_gsi() in both include/asm-i386/acpi.h
> and include/asm-ia64/acpi.h. But now I'm having one concern about it.
> 
> Some arch specific functions would be called from acpi_unregister_gsi()
> when it is implemented. But include/asm-xxx/acpi.h is included before
> many other header files, so many 'implicit declaration of function xxx'
> warning message would be appeared. These warning messages are disappeared
> if we declare all functions called by acpi_unregister_gsi() also in
> include/asm-xxx/acpi.h. But I don't like this approach very much.
> 
> After all, now I think it is better not to define acpi_unregister_gsi()
> in header files.

Ok i think i may have not conveyed my meaning properly, my mistake. What i 
think would be better is if the architectures which have no-op 
acpi_unregister_gsi to declare them as static inline in header files. For 
architectures (such as ia64) which have a functional acpi_unregister_gsi, 
we can declare them in a .c file with the proper exports etc.

Thanks Kenji and sorry for the confusion.
	Zwane

