Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263975AbUF0QbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263975AbUF0QbZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 12:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264061AbUF0QbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 12:31:25 -0400
Received: from smtp.hia.no ([158.36.178.5]:24515 "EHLO smtp.hia.no")
	by vger.kernel.org with ESMTP id S263975AbUF0QbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 12:31:23 -0400
Subject: Re: [ACPI] No APIC interrupts after ACPI suspend
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: David Eriksson <david@2good.nu>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
In-Reply-To: <1088268145.14987.248.camel@zion.2good.net>
References: <1088160505.3702.4.camel@tyrosine>
	 <1088268145.14987.248.camel@zion.2good.net>
Content-Type: text/plain
Date: Sun, 27 Jun 2004 17:27:47 +0100
Message-Id: <1088353667.5113.1.camel@tyrosine>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-06-26 at 18:42 +0200, David Eriksson wrote:

> Maybe you've found this bug?
> 
> http://bugme.osdl.org/show_bug.cgi?id=2643

Yeah, that one was biting me, but it's not the one causing this bug.
cat /proc/interrupts shows that the ACPI interrupt is correctly set to
level triggered, but the ioapic isn't set up correctly so no interrupts
make it through. The same seems to be true for all other level-triggered
interrupts.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

