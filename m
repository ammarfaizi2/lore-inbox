Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422828AbWBIGnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422828AbWBIGnQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 01:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422829AbWBIGnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 01:43:16 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:15622 "EHLO
	cyberguard.com.au") by vger.kernel.org with ESMTP id S1422828AbWBIGnP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 01:43:15 -0500
Message-ID: <43EAE4AC.6070807@snapgear.com>
Date: Thu, 09 Feb 2006 16:43:56 +1000
From: Greg Ungerer <gerg@snapgear.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Jon Ringle <jringle@vertical.com>
Subject: Re: Linux running on a PCI Option device?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jon,

Jon Ringle wrote:
> I am working on a new board that will have Linux running on an xscale 
> processor. This board will be a PCI Option device. I currently have a IXDP465 
> eval board which has a PCI Option connector that I will use for prototyping. 
> From what I can tell so far, Linux wants to scan the PCI bus for devices as 
> if it is the PCI host. Is there any provision in Linux so that it can take on 
> the role of a PCI option rather than a PCI host?

Have a look at the code in arch/arm/mach-ixp4xx/common-pci.c, in
the function ixp4xx_pci_preinit().

It does a check on whether the PCI bus is configured as HOST or not.
I don't know if that code support is enough for it all to work right
though (I certainly haven't tried it on either the 425 or 465...)

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a CyberGuard Company            PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
