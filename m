Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267565AbUHTFDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267565AbUHTFDa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 01:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267555AbUHTFDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 01:03:30 -0400
Received: from web14926.mail.yahoo.com ([216.136.225.84]:21111 "HELO
	web14926.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267565AbUHTFDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 01:03:08 -0400
Message-ID: <20040820050301.51038.qmail@web14926.mail.yahoo.com>
Date: Thu, 19 Aug 2004 22:03:01 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: legacy VGA device requirements (was: Exposing ROM's though sysfs)
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Torrey Hoffman <thoffman@arnor.net>,
       lkml <linux-kernel@vger.kernel.org>,
       Alex Romosan <romosan@sycorax.lbl.gov>, Dave Airlie <airlied@linux.ie>
In-Reply-To: <20040820045356.GA594@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Vojtech Pavlik <vojtech@suse.cz> wrote:
> Well, the stealth compatibility mode is even uglier than VesaFB not
> claiming the PCI device, so I don't think it's really worth it for
> this reason.

Stealth mode will die the minute DRM and fbdev merge but until then we
have no choice. DRM has always run in steath mode, the new feature is
the mode where DRM claims the resources.

> 
> You can just as well enable the stealth mode if you can't get the
> resources.

I'll go look and see if I can modify the DRM probe function to claim
PCI device and resources before returning instead of just the device.
Before this it never occured to me that a driver would claim resources
without also claiming the device. Claiming both should be a simpler
solution than trying to fix VesaFB.


=====
Jon Smirl
jonsmirl@yahoo.com


		
_______________________________
Do you Yahoo!?
Win 1 of 4,000 free domain names from Yahoo! Enter now.
http://promotions.yahoo.com/goldrush
