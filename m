Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWIUKh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWIUKh2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 06:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWIUKh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 06:37:28 -0400
Received: from aun.it.uu.se ([130.238.12.36]:57274 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1750704AbWIUKh1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 06:37:27 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17682.27477.995475.57130@alkaid.it.uu.se>
Date: Thu, 21 Sep 2006 12:37:09 +0200
From: Mikael Pettersson <mikpe@it.uu.se>
To: David Miller <davem@davemloft.net>
Cc: simoneau@ele.uri.edu, sparclinux@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [sparc64] 2.6.18 unaligned acccess in ehci_hub_control
In-Reply-To: <20060920.105659.128612840.davem@davemloft.net>
References: <20060920172123.GA9334@ele.uri.edu>
	<20060920.105659.128612840.davem@davemloft.net>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller writes:
 > From: Will Simoneau <simoneau@ele.uri.edu>
 > Date: Wed, 20 Sep 2006 13:21:23 -0400
 > 
 > > I upgraded from 2.6.17.7 to 2.6.18 today, and in dmesg I have 5 of these
 > > messages in a row:
 > > 
 > > Kernel unaligned access at TPC[100be8c8] ehci_hub_control+0x350/0x680 [ehci_hcd]
 > > 
 > > This message wasn't there before... I suppose it is pretty harmless as
 > > the kernel is supposed to handle unaligned accesses (right?) but this is
 > > the first time it's happened.
 > 
 > Yes, I've been meaning to send Greg KH patches to fix these
 > cases, thanks for reminding me about it.

I don't think it's harmless. My Ultra5 has an add-on PCI USB controller
card (Belkin). A 2.6.18-rc kernel compiled with gcc-4.1.1 will throw a few
unaligned accesses when I initialise USB by inserting a USB memory stick.
Removing the memory stick then results in PCI errors and other breakage.

The same kernel compiled with gcc-3.4.6 has no problems at all, so I've
been assuming it's a gcc-4 issue and not a kernel issue.

/Mikael
