Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbVH1Ty2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbVH1Ty2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 15:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbVH1Ty2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 15:54:28 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:1698 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S1750772AbVH1Ty1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 15:54:27 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Telling Linux that a SATA device has gone away
In-Reply-To: <1125070980.4958.102.camel@localhost.localdomain>
References: <20050826144250.GA12816@srcf.ucam.org> <20050826144250.GA12816@srcf.ucam.org> <1125070980.4958.102.camel@localhost.localdomain>
Date: Sun, 28 Aug 2005 20:54:21 +0100
Message-Id: <E1E9TET-0003Hc-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> It won't work on hd* either. 2.4-ac supports drive plugging but nothing
> else ever did. For the SATA case see Jeff's sata status page 8) and join
> in the fun. Most of what is needed is already there. 

Ok. The machine in question has an ICH6 controller, which is in theory
capable of hotplugging. However, the ahci driver fails to load with
ENOMEM and so I end up with ata_piix. According to
http://linux.yyz.us/sata/software-status.html#hotplug , this /doesn't/
support hotplug. Now, Windows seems to be dealing somehow - it's
entirely happy with the drive vanishing without warning. This confuses
me a little.

Is there any hope of 2.6 gaining IDE hotswap? Given how easy it is to
capture removal events with ACPI, it would be nice to be able to do
something useful with it (rather than just tending to crash the machine)

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
