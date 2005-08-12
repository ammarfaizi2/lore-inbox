Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbVHLO51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbVHLO51 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 10:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbVHLO51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 10:57:27 -0400
Received: from cantor2.suse.de ([195.135.220.15]:45774 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751035AbVHLO50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 10:57:26 -0400
Date: Fri, 12 Aug 2005 16:57:25 +0200
From: Andi Kleen <ak@suse.de>
To: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: APIC version and 8-bit APIC IDs
Message-ID: <20050812145725.GD922@wotan.suse.de>
References: <42FC8461.2040102@fujitsu-siemens.com.suse.lists.linux.kernel> <p73pssj2xdz.fsf@verdi.suse.de> <42FCA23C.7040601@fujitsu-siemens.com> <20050812133248.GN8974@wotan.suse.de> <42FCA97E.5010907@fujitsu-siemens.com> <42FCB86C.5040509@fujitsu-siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42FCB86C.5040509@fujitsu-siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 04:55:40PM +0200, Martin Wilck wrote:
> I wrote:
> 
> >>How so? The XAPIC version check should work there.
> >
> >ACPI: LAPIC (acpi_id[0x11] lapic_id[0x21] enabled)
> >Processor #33 15:4 APIC version 16
> >ACPI: LAPIC (acpi_id[0x12] lapic_id[0x26] enabled)
> >Processor #38 15:4 APIC version 16
> 
> Forget it. I have fallen prey to  this line:
> 
> 	processor.mpc_apicver = 0x10; /* TBD: lapic version */
> 
> in arch/x86_64/kernel/mpparse.c.
> I am used to get correct answers from Linux :-)

Heh. Should probably fix that. Can you file a bug with the ACPI
people on http://bugzilla.kernel.org ? (or do a patch?)

-Andi
