Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267807AbUH2Ncl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267807AbUH2Ncl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 09:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267815AbUH2Ncl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 09:32:41 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:38336 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S267807AbUH2Ncj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 09:32:39 -0400
Date: Sun, 29 Aug 2004 15:04:23 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: Eric Valette <eric.valette@free.fr>
Cc: "Li, Shaohua" <shaohua.li@intel.com>, Karol Kozimor <sziwan@hell.org.pl>,
       "Brown, Len" <len.brown@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8.1-mm1 and Asus L3C : problematic change found, can be reverted. Real fix still missing
Message-ID: <20040829130423.GD17032@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	Eric Valette <eric.valette@free.fr>,
	"Li, Shaohua" <shaohua.li@intel.com>,
	Karol Kozimor <sziwan@hell.org.pl>,
	"Brown, Len" <len.brown@intel.com>,
	"Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>,
	Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <B44D37711ED29844BEA67908EAF36F039A1877@pdsmsx401.ccr.corp.intel.com> <41245F59.4080608@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41245F59.4080608@free.fr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 10:05:45AM +0200, Eric Valette wrote:
> Li, Shaohua wrote:
> >Eric,
> >The patch for bug 3049 has been in 2.6.8.1 and should fix the IO port
> >problem. If the Asus quirk is just because of IO port problem, I'd like
> >to remove it.
It's not because of the IO port problem -- actually, this "IO" problem is a
new appearance, while the Asus quirk works perfectly for many people.

> > Note PNP driver also reserves the IO port for the SMBus
> >and lets SMBus driver to use it. ACPI motherboard driver behaves the
> >same as PNP driver.
> 
> Unfortunately, as I understand it, the fix is done to "unhide" the SMBus 
> that otherwyse is not seen but it has unexpected side effect of messing 
> ioports allocation/reservation. I guess lspci with and without the fix 
> could help to understand the problem.

Indeed. lspci without the fix doesn't show the device, lspci with the fix
shows the device.

	Dominik
