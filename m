Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751692AbWDCJVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbWDCJVv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 05:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751693AbWDCJVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 05:21:51 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58586 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751692AbWDCJVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 05:21:50 -0400
Subject: Re: [RESEND][2.6.15] New ATA error messages on upgrade to 2.6.15
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: mrmacman_g4@mac.com, edmudama@gmail.com, hahn@physics.mcmaster.ca,
       hancockr@shaw.ca, jujutama@comcast.net, linux-kernel@vger.kernel.org
In-Reply-To: <200604030907.k33974O9020701@harpo.it.uu.se>
References: <200604030907.k33974O9020701@harpo.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 03 Apr 2006 10:29:36 +0100
Message-Id: <1144056576.719.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-04-03 at 11:07 +0200, Mikael Pettersson wrote:
> 20269 PCI controller card. The 20269+cable+disk does udma5
> just fine in a PC, but throws a few BadCRCs at bootup on
> the PowerMac, resets and drops to udma4, and then things work
> OK for me, but I don't stress it very much (no RAID).

Interesting. 

> Since the card's bios doesn't get run at powerup, I always
> suspected that the driver fails to initialize some timing thing.

The BIOS does various bits of PCI bus setup on some systems including
latency setting. That might be relevant, especially latency to get
bursting.

> Another possibility is the "data coherency" issue in some
> G4 CPUs which requires mappings of memory shared with other
> agents to use some additional magic in the page table.


The CRC is computed between the controller as the bits get fired over
the cable and drive so it shouldn't be caused by any weird bus timings.

More info would be useful although it may be a while before I can look
at it

