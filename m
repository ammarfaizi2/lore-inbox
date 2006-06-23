Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWFWPni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWFWPni (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 11:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWFWPni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 11:43:38 -0400
Received: from mms1.broadcom.com ([216.31.210.17]:9485 "EHLO mms1.broadcom.com")
	by vger.kernel.org with ESMTP id S1751162AbWFWPnh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 11:43:37 -0400
X-Server-Uuid: F962EFE0-448C-40EE-8100-87DF498ED0EA
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: Re: [discuss] Re: [RFC] Whitelist chipsets supporting MSI and
 check Hyper-transport capabilitiesKJ
Date: Fri, 23 Jun 2006 08:43:26 -0700
Message-ID: <8AFFB74283C8EF46ACA4C331087033F1AB8F0C@NT-SJCA-0750.brcm.ad.broadcom.com>
Thread-Topic: Re: [discuss] Re: [RFC] Whitelist chipsets supporting MSI
 and check Hyper-transport capabilitiesKJ
Thread-Index: AcaW28RSn3cnWTouR9G3Gy6VIi1z8A==
From: "Naren (Narendra) Sankar" <nsankar@broadcom.com>
To: ak@suse.de
cc: linux-kernel@vger.kernel.org
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006062303; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413039303230372E34343943304136302E303035352D412D;
 ENG=IBF; TS=20060623154329; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006062303_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 6882D3AA0HW50709508-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> BCM seems to need a blacklist to force MSI off (or at least tg3 is
complaining
> that MSI doesn't work). I guess we can try to contact someone at BCM
> and ask them if they actually tested it. If they did then enabling it
would
> be fine. 

Hi Everyone

I just got forwarded this discussion on LKML. Unfortunately I am not
subscribed to the mailing list.

I want to clarify that all of Broadcom's AMD chipsets do support MSI and
have done so from the very beginning. The only issue is that we did not
enable the support by default in the hardware. However some platform
vendors are choosing for their own reasons not to use the BIOS required
programming to enable the MSI support in our chipsets. So the current
state of the market is that we have some systems out there that support
MSI on our chipsets and others that do not. We are trying to work with
every vendor to make sure this gets enabled.

MSI is fully tested on our chipsets and the kernel can safely turn it on
on any platform.

The BIOS/kernel programming requirement is that the HyperTransport MSI
mapping be enabled in all the PCIX and PCIe bridges of our chipsets.
Hence PCI register 0xa2 needs to be set to 1, in the standard PCI space
of all our Bridges. This is true for the HT2000, the HT2100 and the
HT1000.

Please cc me if there are any questions.

Thanks
 
Naren Sankar
System Architect
Chipset Product Line
Broadcom Corporation
2451 Mission College Blvd
Santa Clara, CA 95054
Office:  (408) 922-7143
Email:  nsankar@broadcom.com <mailto:nsankar@broadcom.com>  

