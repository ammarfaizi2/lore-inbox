Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268233AbTBMTFR>; Thu, 13 Feb 2003 14:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268257AbTBMTFR>; Thu, 13 Feb 2003 14:05:17 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:27805 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S268233AbTBMTFQ>;
	Thu, 13 Feb 2003 14:05:16 -0500
Date: Thu, 13 Feb 2003 19:07:55 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Rusty Lynch <rusty@linux.co.intel.com>
Cc: Patrick Mochel <mochel@osdl.org>, wingel@nano-systems.com,
       lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH][RFC] Proposal for a new watchdog interface using sysfs
Message-ID: <20030213190755.GA11244@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Rusty Lynch <rusty@linux.co.intel.com>,
	Patrick Mochel <mochel@osdl.org>, wingel@nano-systems.com,
	lkml <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <Pine.LNX.4.33.0302131002420.1133-100000@localhost.localdomain> <1045151506.1189.1.camel@vmhack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045151506.1189.1.camel@vmhack>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2003 at 07:51:45AM -0800, Rusty Lynch wrote:

 > > You could regard them as 'system' devices, and have them show up in 
 > > devices/sys/, which would make more sense than 'legacy'.
 > Ok, system device is the winner.

Why? Stop for a second and look what we have in those dirs.
They both contain things that are essentially motherboard resources.

These are add-on cards we're talking about. Surely a more sensible
place for them to live is somewhere under devices/pci0/ or whatever
bus-type said card is for.

Whilst there are some watchdogs which _are_ part of the motherboard
chipset (which is arguably 'system'), these still show up in PCI
space as regular PCI devices.

Lumping them all into the same category as things like rtc, pic,
fdd etc is just _wrong_.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
