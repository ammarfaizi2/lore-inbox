Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbWJVN3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbWJVN3z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 09:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbWJVN3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 09:29:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:20681 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750899AbWJVN3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 09:29:54 -0400
From: Andi Kleen <ak@suse.de>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Subject: Re: [PATCH] x86-64: typo in __assign_irq_vector when updating pos for vector and offset
Date: Sun, 22 Oct 2006 15:29:38 +0200
User-Agent: KMail/1.9.5
Cc: Yinghai Lu <yinghai.lu@amd.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200610212100.k9LL0GtC018787@hera.kernel.org> <20061022035109.GM5211@rhun.haifa.ibm.com>
In-Reply-To: <20061022035109.GM5211@rhun.haifa.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610221529.38694.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This patch breaks my x366 machine:
>  
> aic94xx: device 0000:01:02.0: SAS addr 5005076a0112df00, PCBA SN , 8 phys, 8 enabled phys, flash present, BIOS build 1323
> aic94xx: couldn't get irq 25 for 0000:01:02.0
> ACPI: PCI interrupt for device 0000:01:02.0 disabled
> aic94xx: probe of 0000:01:02.0 failed with error -38
> 
> Reverting it allows it to boot again. Since the patch is "obviously
> correct", it must be uncovering some other problem with the genirq
> code.

I wonder if the machine works when booted with a 32bit kernel?
Presumably Eric made less typos when doing the i386 genirq code @)

-Andi

