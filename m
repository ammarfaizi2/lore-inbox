Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbWIDRCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbWIDRCe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 13:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWIDRCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 13:02:34 -0400
Received: from alnrmhc11.comcast.net ([206.18.177.51]:12798 "EHLO
	alnrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S964900AbWIDRCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 13:02:33 -0400
Message-ID: <44FADE18.5040107@gentoo.org>
Date: Sun, 03 Sep 2006 09:52:24 -0400
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060818)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Andrew Morton <akpm@osdl.org>, sergio@sergiomb.no-ip.org,
       bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wedgwood <cw@f00f.org>,
       greg@kroah.com, harmon@ksu.edu, Len Brown <len.brown@intel.com>
Subject: Re: VIA IRQ quirk fixup only in XT-PIC mode Take 3
References: <1157330567.3046.24.camel@localhost.portugal> <20060903175841.7a84c63c.akpm@osdl.org> <44FBBD28.6070601@garzik.org>
In-Reply-To: <44FBBD28.6070601@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Andrew Morton wrote:
>> There's a similar patch in -mm: 
>> pci-quirk_via_irq-behaviour-change.patch. Does that work for you?
> 
> And then, we return to:
> 
> Some installations have VIA products on a PCI card.  We cannot assume 
> that all PCI_VENDOR_ID_VIA devices are on-board devices with the special 
> VIA PIC on-chip routing (the thing quirk_via_irq tweaks).

I'm not sure whether you are commenting on my patch 
(pci-quirk_via_irq-behaviour-change.patch), or Sergio's, but just to 
clarify:

My patch includes a hack that detects the presence of a VIA southbridge, 
and only applies quirks if a southbridge is present.

This isn't perfect, as someone could insert a VIA PCI card into a 
VIA-based motherboard and the PCI card would get quirked, but it's the 
most accurate solution which has been proposed so far.

If the southbridge detection hack is acceptable, there is no reason why 
it could not be combined with Sergio's patch.

Daniel

