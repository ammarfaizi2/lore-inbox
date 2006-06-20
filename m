Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbWFTU5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbWFTU5U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 16:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWFTU5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 16:57:20 -0400
Received: from osa.unixfolk.com ([209.204.179.118]:41915 "EHLO
	osa.unixfolk.com") by vger.kernel.org with ESMTP id S1751054AbWFTU5U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 16:57:20 -0400
Date: Tue, 20 Jun 2006 13:57:17 -0700 (PDT)
From: Dave Olson <olson@unixfolk.com>
To: Brice Goglin <brice@myri.com>
Cc: greg.lindahl@qlogic.com, "Randy.Dunlap" <rdunlap@xenotime.net>, ak@suse.de,
       discuss@x86-64.org, linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [discuss] Re: [RFC] Whitelist chipsets supporting MSI and check
 Hyper-transport capabilities
In-Reply-To: <44985F9A.6000108@myri.com>
Message-ID: <Pine.LNX.4.64.0606201355320.12870@topaz.pathscale.com>
References: <fa.5FgZbVFZIyOdjQ3utdNvbqTrUq0@ifi.uio.no>
 <fa.URgTUhhO9H/aLp98XyIN2gzSppk@ifi.uio.no> <Pine.LNX.4.61.0606192237560.25433@osa.unixfolk.com>
 <200606200925.30926.ak@suse.de> <20060620200352.GJ1414@greglaptop.internal.keyresearch.com>
 <20060620132049.ff5e6f67.rdunlap@xenotime.net>
 <20060620204109.GA1980@greglaptop.internal.keyresearch.com> <44985F9A.6000108@myri.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006, Brice Goglin wrote:

| Greg Lindahl wrote:
| > Andi, is the tg3 NIC that didn't work in a Supermicro system
| > on PCI-X or PCI Express?
| >   
| 
| IIRC, Andi was talking about a Supermicro machine with a ServerWorks
| HT2000 chipset. We have such a machine here. Its MSI is disabled in the
| Hyper-transport mapping. But, MSI works once the HT capability is
| enabled (and my quirk will detect it right).
| For such machines, if people really want MSI, we'll need to enable the
| HT cap in my quirk. But, as long as they just want IRQ to work,
| detecting whether the HT cap is enabled or not should be enough.

We definitely want that chipset to be on the whitelist.   It's used in
supermicro systems, the Mac systems with the 970 chip, and some large
vendor systems as well.

The detection of MSI not being enabled in the config space is 
a good thing to do (and warn about), of course, no problem with that.

I've seen no MSI-related issues with the ST2000 on 3 different
platforms, so far.

Dave Olson
olson@unixfolk.com
