Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbWJVQbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWJVQbp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 12:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWJVQbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 12:31:45 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:2550 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751272AbWJVQbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 12:31:44 -0400
Date: Sun, 22 Oct 2006 18:31:41 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Yinghai Lu <yinghai.lu@amd.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86-64: typo in __assign_irq_vector when updating pos for vector and offset
Message-ID: <20061022163141.GF4354@rhun.haifa.ibm.com>
References: <200610212100.k9LL0GtC018787@hera.kernel.org> <20061022035109.GM5211@rhun.haifa.ibm.com> <200610221529.38694.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610221529.38694.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2006 at 03:29:38PM +0200, Andi Kleen wrote:
> 
> > This patch breaks my x366 machine:
> >  
> > aic94xx: device 0000:01:02.0: SAS addr 5005076a0112df00, PCBA SN , 8 phys, 8 enabled phys, flash present, BIOS build 1323
> > aic94xx: couldn't get irq 25 for 0000:01:02.0
> > ACPI: PCI interrupt for device 0000:01:02.0 disabled
> > aic94xx: probe of 0000:01:02.0 failed with error -38
> > 
> > Reverting it allows it to boot again. Since the patch is "obviously
> > correct", it must be uncovering some other problem with the genirq
> > code.
> 
> I wonder if the machine works when booted with a 32bit kernel?

Mostly... I don't have a 32-bit initrd environment for aic94xx, so I
gave it a spin with aic94xx built in and without firmware. It made it
as far as trying to mount the root device, and then sat there spitting
this out continously:

atkbd.c: Spurious ACK on isa0060/serio0. Some program might be trying
access hardware directly

I can put together a 32-bit initrd and try booting all the way if
it'll be a useful experiment, let me know.

Cheers,
Muli
