Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030354AbWBNFCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030354AbWBNFCK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbWBNFCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:02:10 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:35333 "EHLO
	cyberguard.com.au") by vger.kernel.org with ESMTP id S1030354AbWBNFCJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:02:09 -0500
Message-ID: <43F16484.2080800@snapgear.com>
Date: Tue, 14 Feb 2006 15:03:00 +1000
From: Greg Ungerer <gerg@snapgear.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Ringle <jringle@vertical.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux running on a PCI Option device?
References: <43EAE4AC.6070807@snapgear.com> <200602091131.12535.jringle@vertical.com>
In-Reply-To: <200602091131.12535.jringle@vertical.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

Jon Ringle wrote:
> On Thursday 09 February 2006 01:43 am, Greg Ungerer wrote:
>>Jon Ringle wrote:
>>>I am working on a new board that will have Linux running on an xscale
>>>processor. This board will be a PCI Option device. I currently have a
>>>IXDP465 eval board which has a PCI Option connector that I will use for
>>>prototyping. From what I can tell so far, Linux wants to scan the PCI bus
>>>for devices as if it is the PCI host. Is there any provision in Linux so
>>>that it can take on the role of a PCI option rather than a PCI host?
>>
>>Have a look at the code in arch/arm/mach-ixp4xx/common-pci.c, in
>>the function ixp4xx_pci_preinit().
>>
>>It does a check on whether the PCI bus is configured as HOST or not.
>>I don't know if that code support is enough for it all to work right
>>though (I certainly haven't tried it on either the 425 or 465...)
> 
> 
> Something that I don't quite understand is how I'm supposed to make vendor Id 
> information available to the PCI host. Any ideas there?

No, sorry, no idea. I haven't looked at it in that much detail.

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a CyberGuard Company            PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
