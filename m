Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266709AbUF3P4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266709AbUF3P4T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 11:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266717AbUF3P4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 11:56:19 -0400
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:8923 "EHLO
	ti41.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S266709AbUF3P4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 11:56:08 -0400
Date: Wed, 30 Jun 2004 11:56:08 -0400
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: libata: 2.6.7-bk6,12 hang with ata_piix in combined mode; -bk5 ok
Message-ID: <20040630155608.GA19785@ti64.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
References: <20040630005420.GA4163@ti64.telemetry-investments.com> <20040630012051.GA30823@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040630012051.GA30823@havoc.gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2004 at 09:20:51PM -0400, Jeff Garzik wrote:
> > ACPI: PCI interrupt 0000:1f.2[A]: no GSI
> [...]
> 
> I wonder what "no GSI" is.  Since the command is timing out, that is
> often a symptom of ACPI interrupt routing problems.
 
That was my initial thought, though you'll note that the same message
is present in the 2.6.7-bk5 boot log.  I'll have to hook up a serial
console to do a real diff of the IRQ initialization.

> Does booting with "noapic" or "acpi=off" help anything?
 
No, exact same behavior.

> Also, does disabling combined mode solve anything?

AFAICT, Dell's BIOS offers no option for changing the SATA mode.
("Cable Select" for the new millenium! Arrgh!)

If a diff of the boot logs shows nothing useful, I will try backing out
individual patches from patch-2.6.7-bk5-bk6.bz2.

Thanks.

	Bill Rugolsky
