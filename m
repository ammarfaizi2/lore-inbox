Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbTLJNkr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 08:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbTLJNkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 08:40:47 -0500
Received: from aun.it.uu.se ([130.238.12.36]:64903 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262321AbTLJNkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 08:40:46 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16343.8777.389445.2007@alkaid.it.uu.se>
Date: Wed, 10 Dec 2003 14:40:25 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Ryan Underwood <nemesis-lists@icequake.net>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ACPI] IO-APIC on MS-6163 (2.4.23). ACPI?
In-Reply-To: <20031210125543.GA1444@dbz.icequake.net>
References: <3ACA40606221794F80A5670F0AF15F8401720C15@PDSMSX403.ccr.corp.intel.com>
	<20031210125543.GA1444@dbz.icequake.net>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Underwood writes:
 > 
 > Attached dmesg and interrupts with acpi=off.  Also attached kernel
 > config.
 > 
 > As you see, it acknowledges a local APIC but mentions nothing about
 > IO-APIC.  So I guess this isn't ACPI issue after all.  But, I wonder why
 > the IO-APIC isn't being used on this board anymore.  There was a
 > blacklist entry for it, but it was removed after it was discovered to be
 > in error.

Your dmesg log doesn't mention any MP-table. With neither ACPI MADT
nor an MP-table the kernel has no way of knowing about any I/O-APIC.

You do have UP_IOAPIC enabled, so the kernel should look for it.
Please check your BIOS settings, and try with no ACPI at all in the kernel
(just to verify that acpi=off doesn't prevent MP-table parsing).

/Mikael
