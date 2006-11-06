Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422764AbWKFCmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422764AbWKFCmY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 21:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422891AbWKFCmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 21:42:24 -0500
Received: from pop-sarus.atl.sa.earthlink.net ([207.69.195.72]:44478 "EHLO
	pop-sarus.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1422764AbWKFCmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 21:42:23 -0500
Message-ID: <454EA107.7020108@cfl.rr.com>
Date: Sun, 05 Nov 2006 21:42:15 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
CC: Grzegorz Kulewski <kangur@polcom.net>, linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz> <Pine.LNX.4.63.0611022346450.14187@alpha.polcom.net> <Pine.LNX.4.64.0611030015150.3266@artax.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0611030015150.3266@artax.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikulas Patocka wrote:
> There was discussion about it here some times ago, and I think the 
> result was that the IDE bus is reset prior to capacitors discharge and 
> total loss of power and disk has enough time to finish a sector --- but 
> if you have crap power supply (doesn't signal power loss), crap 
> motherboard (doesn't reset bus) or crap disk (doesn't respond to reset), 
> it can fail.
> 
> BTW. reiserfs and xfs depend on this feature too. ext3 is the only one 
> that doesn't.
> 
> Mikulas

Yes, if your disk can not atomically commit a single sector, then it is 
broken.  And ALL filesystems rely on this behavior because they all 
expect NOT to have hardware IO read failures of important metadata after 
a power failure ( due to the sector ECC failing ).


