Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbTHUAfx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 20:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbTHUAfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 20:35:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7635 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262327AbTHUAfv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 20:35:51 -0400
Message-ID: <3F4413DB.4060106@pobox.com>
Date: Wed, 20 Aug 2003 20:35:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] fix ioapic build breakage
References: <20030820221755.GA20633@gtf.org> <Pine.LNX.4.53.0308202026030.17457@montezuma.mastecende.com>
In-Reply-To: <Pine.LNX.4.53.0308202026030.17457@montezuma.mastecende.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Wed, 20 Aug 2003, Jeff Garzik wrote:
> 
> 
>>
>>===== arch/i386/kernel/setup.c 1.92 vs edited =====
>>--- 1.92/arch/i386/kernel/setup.c	Tue Aug 19 16:01:09 2003
>>+++ edited/arch/i386/kernel/setup.c	Wed Aug 20 18:15:34 2003
>>@@ -543,11 +543,13 @@
>> 			if (!acpi_force) acpi_disabled = 1;
>> 		}
>> 
>>+#ifdef CONFIG_X86_LOCAL_APIC
>> 		/* disable IO-APIC */
>> 		else if (!memcmp(from, "noapic", 6)) {
>> 			skip_ioapic_setup = 1;
>> 		}
>>-#endif
>>+#endif /* CONFIG_X86_LOCAL_APIC */
>>+#endif /* CONFIG_ACPI_BOOT */
> 
> 
> Shouldn't that be CONFIG_X86_IO_APIC ?


If so, other code wants changing, too...

	Jeff



