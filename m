Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbTIRRoS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 13:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbTIRRoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 13:44:18 -0400
Received: from hqemgate00.nvidia.com ([216.228.112.144]:2058 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S261987AbTIRRoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 13:44:16 -0400
Message-ID: <8F12FC8F99F4404BA86AC90CD0BFB04F039F7137@mail-sc-6.nvidia.com>
From: Allen Martin <AMartin@nvidia.com>
To: "'Witold Krecicki'" <adasi@kernel.pl>, linux-kernel@vger.kernel.org
Subject: RE: SII SATA request size limit
Date: Thu, 18 Sep 2003 10:43:25 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > much as soon as anything touches the SCSI bus on my aic7xxx card.
> > Disabling DMA on the SiI IDE channel seems to work around it, at the
> > cost of a lot of performance... (this is on stock 2.4.22, BTW)
> No, only on-board nForce2 IDE controller. Disabling ACPI 
> helped. - now it's 
> stable

There are ACPI issues with nForce boards, you will see PCI interrupts get
programmed to edge triggered mode in /proc/interrupts when APIC is enabled.
The easiest workaround is to disable ACPI like you have done.

-Allen
