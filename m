Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161002AbWFWBgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161002AbWFWBgn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 21:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161005AbWFWBgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 21:36:43 -0400
Received: from xenotime.net ([66.160.160.81]:12000 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161002AbWFWBgm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 21:36:42 -0400
Date: Thu, 22 Jun 2006 18:39:26 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: sergio@sergiomb.no-ip.org
Cc: cw@f00f.org, kernel@agotnes.com, akpm@osdl.org, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net,
       linux-usb-devel@lists.sourceforge.net, stern@rowland.harvard.edu,
       vsu@altlinux.ru
Subject: Re: how I know if a interrupt is ioapic_edge_type or
 ioapic_level_type? [Was Re: [Fwd: Re: [Linux-usb-users] Fwd: Re:
 2.6.17-rc6-mm2 - USB issues]]
Message-Id: <20060622183926.fada1a25.rdunlap@xenotime.net>
In-Reply-To: <1151024444.2858.14.camel@localhost.portugal>
References: <4497DA3F.80302@agotnes.com>
	<20060620044003.4287426d.akpm@osdl.org>
	<4499245C.8040207@agotnes.com>
	<1150936606.2855.21.camel@localhost.portugal>
	<20060621174754.159bb1d0.rdunlap@xenotime.net>
	<1150938288.3221.2.camel@localhost.portugal>
	<20060621210817.74b6b2bc.rdunlap@xenotime.net>
	<1150977386.2859.34.camel@localhost.localdomain>
	<20060622142902.5c8f8e67.rdunlap@xenotime.net>
	<1151016398.3022.4.camel@localhost.portugal>
	<20060622225405.GA5840@tuatara.stupidest.org>
	<1151024444.2858.14.camel@localhost.portugal>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 02:00:44 +0100 Sergio Monteiro Basto wrote:

> On Thu, 2006-06-22 at 15:54 -0700, Chris Wedgwood wrote:
> > On Thu, Jun 22, 2006 at 11:46:38PM +0100, Sergio Monteiro Basto wrote:
> > 
> > > yap, in my opinion this function should back to
> > 
> > > +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);
> > 
> > 
> > this is *obviousyl* wrong, it should never have been merged like that
> > and there are reports and complaints this causes problems for some
> > people
> >
> 
> It was like that in kernel 2.6.16 and previous since, I don't know,
> 2.6.9 or 2.6.13 ....
> 
> > 
> > we should first attempt to get all the IDs (some are clearly missing
> > still, patch coming up to address that) and where that fails perhaps
> > have a kernel command-line parameter to be overly aggressive as a
> > stop-gap until we van figure out the proper solution
> 
> I believe this quirks is just for VIA system with interrupts in XT-PIC
> mode (like my old laptop).

This sounds like just running with CONFIG_IO_APIC=n or using
"noapic" on the kernel boot command line.  If that's what is
needed, we can know that.  I just haven't seen info to know
what the real problem is.

> > i'd also like to figure out why the quirk is needed/fails when people
> > are using ACPI for interrupt routing as presumbly that must work as
> > windows relies on it
> 
> yes, this is other mysterious, why boot with acpi=noirq could be one
> workaround. But could be other problem more related with usb drives.


---
~Randy
