Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263741AbUFKCk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263741AbUFKCk6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 22:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263735AbUFKCk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 22:40:58 -0400
Received: from fmr11.intel.com ([192.55.52.31]:50085 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S263741AbUFKCkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 22:40:49 -0400
Subject: Re: 2.6.7-rc2-mm2
From: Len Brown <len.brown@intel.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20040603152042.GK1946@suse.de>
References: <20040603015356.709813e9.akpm@osdl.org>
	 <20040603152042.GK1946@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1086921637.2242.471.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 10 Jun 2004 22:40:37 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-03 at 11:20, Jens Axboe wrote:
> On Thu, Jun 03 2004, Andrew Morton wrote:
> >  bk-acpi.patch
> 
> Doesn't compile if you disable ACPI, since mp_register_gsi is guarded by
> 
> #if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_ACPI_INTERPRETER)
> 
> but used in arch/i386/kernel/acpi/boot.c if CONFIG_X86_IO_APIC is set
> alone. I have to disable ACPI on this box still, otherwise it crashes
> very hard immediately after displaying ACPI banner.

"Crashes very hard" I would like to know more.
Does the box have an IOAPIC?
If no, does it boot with "nolapic"?
If yes, does this patch help? 
http://bugme.osdl.org/show_bug.cgi?id=1269

thanks,
-Len



