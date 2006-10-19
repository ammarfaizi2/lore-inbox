Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751524AbWJSMo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbWJSMo7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 08:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751530AbWJSMo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 08:44:59 -0400
Received: from cantor.suse.de ([195.135.220.2]:60900 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751522AbWJSMo7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 08:44:59 -0400
From: Andi Kleen <ak@suse.de>
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: ASUS M2NPV-VM APIC/ACPI Bug (patched)
Date: Thu, 19 Oct 2006 14:44:53 +0200
User-Agent: KMail/1.9.3
Cc: Len Brown <lenb@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Daniel Mierswa <impulze@impulze.org>, Andy Currid <acurrid@nvidia.com>
References: <fa.09mXx81eXfIStK3wap/U1OZn+kg@ifi.uio.no> <fa.1/QTOTFQC91cwKwinVDxrePnGHo@ifi.uio.no> <4536C9DA.4060704@shaw.ca>
In-Reply-To: <4536C9DA.4060704@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610191444.53968.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I think the intent of the HPET check was that the quirk wasn't needed on 
> chipsets new enough to have an HPET. 

Yes.

> Unfortunately, even if the chipset  
> has an HPET it isn't always enabled by the BIOS.

It was supposed to be correct in the NF5 reference BIOS, but somehow Asus
must have managed to break the reference BIOS.

> Clearly this quirk is too broad, it should likely be only triggering on 
> known chipset revisions with the bad timer overrides and not on all 
> NVIDIA chipsets. 

That was impossible at the point where it was implemented.

> What I am wondering is how these boards manage to work  
> fine in Windows, (presumably) without any such chipset-specific tweaks..

They use the RTC interrupt for timing instead AFAIK so a broken interrupt 0
won't affect them. That's probably why we have so many problems with
interrupt 0 on cheap systems.

I tried it once to use in Linux too BTW, but it unfortunately cannot generate
any of the standard Linux timer frequencies.

-Andi
