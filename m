Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbVIKUoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbVIKUoO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 16:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbVIKUoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 16:44:14 -0400
Received: from fmr15.intel.com ([192.55.52.69]:60604 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750862AbVIKUoN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 16:44:13 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [2/3] Set compatibility flag for 4GB zone on IA64
Date: Sun, 11 Sep 2005 13:44:03 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F045A8E72@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2/3] Set compatibility flag for 4GB zone on IA64
Thread-Index: AcW28ixppeNPHPf1S36N4mswlWfJyQAHvfhQ
From: "Luck, Tony" <tony.luck@intel.com>
To: <ak@suse.de>, <torvalds@osdl.org>, "Greg Edwards" <edwardsg@sgi.com>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
X-OriginalArrivalTime: 11 Sep 2005 20:44:04.0287 (UTC) FILETIME=[8C1B8CF0:01C5B711]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Set compatibility flag for 4GB zone on IA64
>
>IA64 traditionally had a 4GB DMA32 zone. Set the compatibility flag
>to keep old drivers working.
>
>For new drivers it would be better to use ZONE_DMA32 now. 
>
>Signed-off-by: Andi Kleen <ak@suse.de>
>Cc: tony.luck@intel.com
>
>Index: linux/arch/ia64/Kconfig
>===================================================================
>--- linux.orig/arch/ia64/Kconfig
>+++ linux/arch/ia64/Kconfig
>@@ -54,6 +54,10 @@ config IA64_UNCACHED_ALLOCATOR
> 	bool
> 	select GENERIC_ALLOCATOR
> 
>+config ZONE_DMA_IS_DMA32
>+	bool
>+	default y
>+
> choice
> 	prompt "System type"
> 	default IA64_GENERIC
>

ia64 isn't all that homogeneous.  SGI systems stuff *all* memory
into the DMA zone as their I/O devices have no 32-bit limits (just
as well really as there is no memory below 4G on an Altix!).

What does this ZONE_DMA_IS_DMA32 thing do?

-Tony
