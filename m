Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932773AbWFWBkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932773AbWFWBkq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 21:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932767AbWFWBkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 21:40:46 -0400
Received: from munin.agotnes.com ([202.173.149.60]:31402 "EHLO
	mail.agotnes.com") by vger.kernel.org with ESMTP id S932766AbWFWBkp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 21:40:45 -0400
Message-ID: <449B4684.8030409@agotnes.com>
Date: Fri, 23 Jun 2006 11:40:20 +1000
From: Johny <kernel@agotnes.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, kernel@agotnes.com,
       akpm@osdl.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-usb-users@lists.sourceforge.net,
       linux-usb-devel@lists.sourceforge.net, stern@rowland.harvard.edu,
       vsu@altlinux.ru
Subject: Re: how I know if a interrupt is ioapic_edge_type or ioapic_level_type?
 [Was Re: [Fwd: Re: [Linux-usb-users] Fwd: Re: 2.6.17-rc6-mm2 - USB issues]]
References: <4497DA3F.80302@agotnes.com> <20060620044003.4287426d.akpm@osdl.org> <4499245C.8040207@agotnes.com> <1150936606.2855.21.camel@localhost.portugal> <20060621174754.159bb1d0.rdunlap@xenotime.net> <1150938288.3221.2.camel@localhost.portugal> <20060621210817.74b6b2bc.rdunlap@xenotime.net> <1150977386.2859.34.camel@localhost.localdomain> <20060622142902.5c8f8e67.rdunlap@xenotime.net> <1151016398.3022.4.camel@localhost.portugal> <20060622225405.GA5840@tuatara.stupidest.org>
In-Reply-To: <20060622225405.GA5840@tuatara.stupidest.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris,

If you keep me posted on the patch when released (I'm not on the kernel 
list, too high volume for me) I'll be happy to give your patch a whirl 
on my test box against whichever kernel you patch.

Your last point is real good, how DOES Windows figure it out? In saying 
that, without the VIA drivers I only have USB1.1 support on this 
motherboard... Again, happy to test some theories if you have some tests 
you'd like ran...

Cheers,

:)Johny

Chris Wedgwood wrote:
> On Thu, Jun 22, 2006 at 11:46:38PM +0100, Sergio Monteiro Basto wrote:
> 
>> yap, in my opinion this function should back to
> 
>> +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);
> 
> 
> this is *obviousyl* wrong, it should never have been merged like that
> and there are reports and complaints this causes problems for some
> people
> 
> we should first attempt to get all the IDs (some are clearly missing
> still, patch coming up to address that) and where that fails perhaps
> have a kernel command-line parameter to be overly aggressive as a
> stop-gap until we van figure out the proper solution
> 
> i'd also like to figure out why the quirk is needed/fails when people
> are using ACPI for interrupt routing as presumbly that must work as
> windows relies on it
