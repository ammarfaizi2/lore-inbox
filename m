Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbWIDFzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWIDFzH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 01:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbWIDFzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 01:55:07 -0400
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:47188 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932335AbWIDFzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 01:55:06 -0400
Date: Sun, 3 Sep 2006 22:55:02 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, sergio@sergiomb.no-ip.org,
       bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, greg@kroah.com, harmon@ksu.edu,
       Daniel Drake <dsd@gentoo.org>, Len Brown <len.brown@intel.com>
Subject: VIA IRQ quirk, another (embarrassing) suggestion.
Message-ID: <20060904055502.GA26816@tuatara.stupidest.org>
References: <1157330567.3046.24.camel@localhost.portugal> <20060903175841.7a84c63c.akpm@osdl.org> <44FBBD28.6070601@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44FBBD28.6070601@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2006 at 01:44:08AM -0400, Jeff Garzik wrote:

> Some installations have VIA products on a PCI card.  We cannot
> assume that all PCI_VENDOR_ID_VIA devices are on-board devices with
> the special VIA PIC on-chip routing (the thing quirk_via_irq
> tweaks).

I'll also point out that I was told (very indirectly, those with
definitive knowledge please speak up) that VIA claimed the recommended
way to deal with these chipset problems is to use ACPI...

However, we know in some cases ACPI doesn't work as-is under Linux,
but apparently does under Windows.  In many cases though it does
appear to suffice.

When chasing down why it doesn't work on other main boards someone who
is ACPI knowledgeable claimed that in the past VIA got their ACPI
wrong, so we need to figure out what ACPI specific quirk windows is
using if we go that route.

It would be really nice if someone from VIA could come forward on this
matter.


Now, failing that, Jeff, what about if we try to use ACPI to detect if
the PCI device is on-board or a plug-in card?  If we did and ignored
them would that satisfy you?

Yes, I know this is yet-another horrible heuristic and might not work
in all cases, but I think we need to aim to get the majority of
systems broken working pretty promptly.  As Andrew said, this really
is quire embarrassing right now.

-- 
VGER BF report: H 0.3996
