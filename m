Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965025AbWDBVRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbWDBVRH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 17:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965028AbWDBVRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 17:17:07 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:1721 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965025AbWDBVRF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 17:17:05 -0400
Subject: Re: [RESEND][2.6.15] New ATA error messages on upgrade to 2.6.15
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>,
       LKML Kernel <linux-kernel@vger.kernel.org>,
       John Livingston <jujutama@comcast.net>,
       "Eric D. Mudama" <edmudama@gmail.com>,
       Robert Hancock <hancockr@shaw.ca>
In-Reply-To: <0FE43D5B-B25D-45C7-83ED-4DE1552EC9DB@mac.com>
References: <Pine.LNX.4.44.0604021508540.2653-100000@coffee.psychology.mcmaster.ca>
	 <0FE43D5B-B25D-45C7-83ED-4DE1552EC9DB@mac.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 02 Apr 2006 22:24:43 +0100
Message-Id: <1144013084.31123.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2006-04-02 at 15:55 -0400, Kyle Moffett wrote:
> (2)  It's extremely unlikely that the card itself is faulty; it  
> exhibits identical symptoms on both drives and has ever since I  
> originally purchased the card and installed 2.4.X on the system.

If it has always shown those symptoms then I'd say its quite likely the
card if the crystals/PLLs on it are out. It looks like the timing is
wrong, which means either the input clocks (eg PCI clock) are wrong (eg
37.5Mhz not 33 due to BIOS overclock settings or just plain out), the
card has a dodgy crystal/PLL or the kernel set it up wrong.

PCI timings won't move between motherboards, PLL faults wont move
between cards.

> (3)  It's not possible that it's the power supply.  As I said before  
> I checked the power supply with an oscilliscope _during_boot_.  The  

I think you can rule that out. Insufficient power generally causes
drives to offline or spontaneously reset. It can cause weird symptoms as
it ends up back in PIO 0 but not ECC change downs except to PIO

> noticing a buggy firmware, then I'm hoping that with some help I can  
> determine where the kernel driver is getting confused and correct the  
> programmed bus timings (or whatever the hell isn't working).  As my  
> practical knowledge of the ATA and IDE protocols is quite limited I'm  
> well out of my depth here and unable to debug without further  
> assistance.

Unless anyone else is seeing the same problem with the same card variant
or you have two cards that do it then there isn't much that can be done
I suspect other than assume the hardware is iffy, rightly or wrongly.
I'd have expected a lot more reports if it were the controller.

(Having said that if you are reading this and your controller is a
Promise and does the same, please say so it might be vital to deducing a
pattern to problems)

Alan

