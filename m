Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbUCHWFw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 17:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbUCHWFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 17:05:51 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:39851 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S261296AbUCHWFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 17:05:34 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>, davidm@hpl.hp.com
Subject: Re: [PATCH] fix PCI interrupt setting for ia64
Date: Mon, 8 Mar 2004 15:05:21 -0700
User-Agent: KMail/1.5.4
Cc: Takayoshi Kochi <t-kochi@bq.jp.nec.com>, benjamin.liu@intel.com,
       iod00d@hp.com, kaneshige.kenji@jp.fujitsu.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3ACA40606221794F80A5670F0AF15F8401B1A017@PDSMSX403.ccr.corp.intel.com> <16460.59685.452893.22564@napali.hpl.hp.com> <20040308215448.I21938@flint.arm.linux.org.uk>
In-Reply-To: <20040308215448.I21938@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403081505.21644.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 March 2004 2:54 pm, Russell King wrote:
> OTOH, if you know "this port is absolutely definitely using this IRQ"
> then you don't want to use IRQ probing.
> 
> As long as ACPI positively knows the correct IRQ, so we really shouldn't
> be using IRQ probing here.  The only thing which causes me concern is...
> what about ACPI table/BIOS bugs?

I suspect (not being expert in the serial innards) that with the old
code things would "just work", and the ACPI table bug would never
be noticed.

With the new code, my guess is that the device just wouldn't work
(we think it has an interrupt, but it's not hooked up correctly).

My inclination is that it's better to help find ACPI bugs, and
if broken tables turn out to be a problem, we can add some kind
of command-line switch or blacklist to deal with it.  But I
guess we should really get David's opinion, since this is a
potential issue for 2.6 distributions.

Bjorn

