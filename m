Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbWHEU0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbWHEU0S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 16:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbWHEU0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 16:26:18 -0400
Received: from thunk.org ([69.25.196.29]:27567 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751484AbWHEU0R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 16:26:17 -0400
Date: Sat, 5 Aug 2006 16:26:03 -0400
From: Theodore Tso <tytso@mit.edu>
To: Michael Chan <mchan@broadcom.com>
Cc: David Miller <davem@davemloft.net>, herbert@gondor.apana.org.au,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH -rt DO NOT APPLY] Fix for tg3 networking lockup
Message-ID: <20060805202603.GA9740@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Michael Chan <mchan@broadcom.com>,
	David Miller <davem@davemloft.net>, herbert@gondor.apana.org.au,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20060804032348.GA16313@thunk.org> <1551EAE59135BE47B544934E30FC4FC093FA11@NT-IRVA-0751.brcm.ad.broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551EAE59135BE47B544934E30FC4FC093FA11@NT-IRVA-0751.brcm.ad.broadcom.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 08:45:31PM -0700, Michael Chan wrote:
> ASF is firmware that monitors the system and sends out alerts whenever
> certain events happen.  So it needs to run before the OS boots or after
> it has crashed.  When the driver is up and running, the driver and ASF
> run independently sending and receiving traffic on the same wire.  Of
> course, the bandwidth that is used by ASF is a very tiny fraction of the
> host traffic.  If the system crashes, the FIFO and other resources on
> the NIC will be backed up and ASF can no longer function without
> resetting the chip.

Thanks, that description was very helpful.  Would you accept a patch
with adding a comment describing this?  I couldn't figure it out from
looking at the source and googling "ASF" turned up lots of other uses
for that particular acronym.

It appears that there is no way of disabling ASF; is that a true
statement?

Thanks, regards,

						- Ted
