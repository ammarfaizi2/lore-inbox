Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271036AbTHLRhr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 13:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271037AbTHLRhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 13:37:47 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:28744 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S271036AbTHLRhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 13:37:45 -0400
Date: Tue, 12 Aug 2003 18:37:07 +0100
From: Dave Jones <davej@redhat.com>
To: Matthew Wilcox <willy@debian.org>
Cc: Robert Love <rml@tech9.net>, CaT <cat@zip.com.au>,
       linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
Message-ID: <20030812173707.GB6919@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Matthew Wilcox <willy@debian.org>, Robert Love <rml@tech9.net>,
	CaT <cat@zip.com.au>, linux-kernel@vger.kernel.org,
	kernel-janitor-discuss@lists.sourceforge.net
References: <20030812020226.GA4688@zip.com.au> <1060654733.684.267.camel@localhost> <20030812023936.GE3169@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030812023936.GE3169@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 12, 2003 at 03:39:36AM +0100, Matthew Wilcox wrote:

 > By and large ... here's a counterexample:
 > 
 > static struct pci_device_id tg3_pci_tbl[] __devinitdata = {
 >         { PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5700,
 >           PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
 >         { PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5701,
 >           PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
 > ...
 > 
 > I don't think anyone would appreciate you converting that to:
 > <snip C99>

Depends. If it's a huuuge struct (see the device ID struct in 2.4's
agpgart for eg) it becomes much more readable. Whitespace good, clutter bad.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
