Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262320AbUKVSdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbUKVSdt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 13:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262270AbUKVScU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 13:32:20 -0500
Received: from fmr02.intel.com ([192.55.52.25]:467 "EHLO caduceus.fm.intel.com")
	by vger.kernel.org with ESMTP id S262320AbUKVSaR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 13:30:17 -0500
Subject: Re: 2.6.10-rc2 doesn't boot (if no floppy device)
From: Len Brown <len.brown@intel.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20041120124001.GA2829@stusta.de>
References: <20041115152721.U14339@build.pdx.osdl.net>
	 <1100819685.987.120.camel@d845pe> <20041118230948.W2357@build.pdx.osdl.net>
	 <1100941324.987.238.camel@d845pe>  <20041120124001.GA2829@stusta.de>
Content-Type: text/plain
Organization: 
Message-Id: <1101148138.20008.6.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 22 Nov 2004 13:28:59 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-11-20 at 07:40, Adrian Bunk wrote:
> On Sat, Nov 20, 2004 at 04:02:04AM -0500, Len Brown wrote:
> 
> > Please try this updated debug patch.
> >
> > It clears the ELCR on Linux boot.

> With your patch, the boot failure goes away.
> This was with a kernel without Linus' patch applied.

Thanks for running this test Adrian.

> 
> BTW: Is all what ACPI does really required, if all I need ACPI for is
> to turn the power off after halting my computer?

On this system ACPI is required to configure the IOAPIC.

It may be possible to save power in idle with c-states
and at run-time with p-states (cpufreq) on this box,
but I couldn't tell that from the dmesg if CONFIG_ACPI_PROCESSOR
was included or not.

If you don't care about interrupt performance and you don't
mind pressing the power button when you halt the system,
go ahead and run with CONFIG_ACPI=n.

cheers,
-Len


