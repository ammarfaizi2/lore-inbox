Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266180AbUF3BUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266180AbUF3BUy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 21:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266182AbUF3BUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 21:20:54 -0400
Received: from havoc.gtf.org ([216.162.42.101]:17630 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266180AbUF3BUw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 21:20:52 -0400
Date: Tue, 29 Jun 2004 21:20:51 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       linux-kernel@vger.kernel.org
Subject: Re: libata: 2.6.7-bk6,12 hang with ata_piix in combined mode; -bk5 ok
Message-ID: <20040630012051.GA30823@havoc.gtf.org>
References: <20040630005420.GA4163@ti64.telemetry-investments.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040630005420.GA4163@ti64.telemetry-investments.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2004 at 08:54:20PM -0400, Bill Rugolsky Jr. wrote:
> ata_piix: combined mode detected
> ACPI: PCI interrupt 0000:1f.2[A]: no GSI
[...]
>  sda:<3>ata1: command 0x25 timeout, stat 0xd0 host_stat 0x64


I wonder what "no GSI" is.  Since the command is timing out, that is
often a symptom of ACPI interrupt routing problems.

Does booting with "noapic" or "acpi=off" help anything?

Also, does disabling combined mode solve anything?

	Jeff



