Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263264AbVGOJ7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263264AbVGOJ7a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 05:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263266AbVGOJ7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 05:59:30 -0400
Received: from gwbw.xs4all.nl ([213.84.100.200]:9897 "EHLO laptop.blackstar.nl")
	by vger.kernel.org with ESMTP id S263264AbVGOJ73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 05:59:29 -0400
Subject: Re: ATAPI+SATA support in 2.6.13-rc3
From: Bas Vermeulen <bvermeul@blackstar.nl>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <42D78269.5020809@gmx.net>
References: <42D78269.5020809@gmx.net>
Content-Type: text/plain
Date: Fri, 15 Jul 2005 11:59:17 +0200
Message-Id: <1121421557.5110.11.camel@laptop.blackstar.nl>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-14.WB1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-15 at 11:31 +0200, Carl-Daniel Hailfinger wrote:
> Hi Jeff,
> 
> I have a Intel ICH6M chipset and am using ata_piix as my
> default disk driver. With the SUSE patched 2.6.11.4 kernel
> (it has some libata patches) my DVD-RAM drive works, with
> 2.6.13-rc3 it doesn't work. My .config is nearly identical
> for both kernels (except options introduced after 2.6.11).
> 
> I have two suspects: the changed interrupt routing and
> libata version differences. Especially strange is the fact
> that both kernels seem to disagree with lspci about the
> interrupts assigned to the SATA controller.
> 
> Please find dmesg, /proc/interrupts and lspci -v attached
> for both kernels.
> 
> Regards,
> Carl-Daniel

You'll need to enable ATAPI support for ata_piix in
include/linux/libata.h

Change:
#undef ATA_ENABLE_ATAPI

into
#define ATA_ENABLE_ATAPI

Suse has probably done that for you, it's disabled by default.

-- 
Bas Vermeulen <bvermeul@blackstar.nl>

