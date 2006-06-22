Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932718AbWFVXl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932718AbWFVXl4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 19:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932707AbWFVXl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 19:41:56 -0400
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:53111 "HELO
	smtp106.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932718AbWFVXlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 19:41:55 -0400
Date: Thu, 22 Jun 2006 15:54:05 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, kernel@agotnes.com, akpm@osdl.org,
       linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-usb-users@lists.sourceforge.net,
       linux-usb-devel@lists.sourceforge.net, stern@rowland.harvard.edu,
       vsu@altlinux.ru
Subject: Re: how I know if a interrupt is ioapic_edge_type or ioapic_level_type? [Was Re: [Fwd: Re: [Linux-usb-users] Fwd: Re: 2.6.17-rc6-mm2 - USB issues]]
Message-ID: <20060622225405.GA5840@tuatara.stupidest.org>
References: <4497DA3F.80302@agotnes.com> <20060620044003.4287426d.akpm@osdl.org> <4499245C.8040207@agotnes.com> <1150936606.2855.21.camel@localhost.portugal> <20060621174754.159bb1d0.rdunlap@xenotime.net> <1150938288.3221.2.camel@localhost.portugal> <20060621210817.74b6b2bc.rdunlap@xenotime.net> <1150977386.2859.34.camel@localhost.localdomain> <20060622142902.5c8f8e67.rdunlap@xenotime.net> <1151016398.3022.4.camel@localhost.portugal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151016398.3022.4.camel@localhost.portugal>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 11:46:38PM +0100, Sergio Monteiro Basto wrote:

> yap, in my opinion this function should back to

> +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);


this is *obviousyl* wrong, it should never have been merged like that
and there are reports and complaints this causes problems for some
people

we should first attempt to get all the IDs (some are clearly missing
still, patch coming up to address that) and where that fails perhaps
have a kernel command-line parameter to be overly aggressive as a
stop-gap until we van figure out the proper solution

i'd also like to figure out why the quirk is needed/fails when people
are using ACPI for interrupt routing as presumbly that must work as
windows relies on it
