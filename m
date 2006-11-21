Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031271AbWKUS2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031271AbWKUS2u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 13:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031272AbWKUS2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 13:28:49 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:61144 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1031271AbWKUS2t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 13:28:49 -0500
Message-ID: <4563455D.80207@garzik.org>
Date: Tue, 21 Nov 2006 13:28:45 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: "Renato S. Yamane" <renatoyamane@mandic.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ahci] Failed with error -12
References: <4562F38F.8010404@mandic.com.br>
In-Reply-To: <4562F38F.8010404@mandic.com.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Renato S. Yamane wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I receive this error message on boot with Kernel 2.6.18.3
> 
> relevant (I think) dmesg output:
> =======
> ahci 0000:00:1f.2: version 2.0
> ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
> ACPI: PCI Interrupt 0000:00:1f.2[B] -> Link [LNKD] -> GSI 11 (level,
> low) -> IRQ 11
> ahci: probe of 0000:00:1f.2 failed with error -12

"-12" is ENOMEM, which means it failed to map an MMIO resource.

Either (a) you should turn on AHCI (or RAID) in BIOS, or (b) you should 
not even try to load ahci driver.

	Jeff



