Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbVJSTwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbVJSTwc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 15:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbVJSTwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 15:52:32 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:48038 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1751263AbVJSTwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 15:52:32 -0400
Date: Wed, 19 Oct 2005 15:52:17 -0400
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to use a USB  SD/MMC card reader?
Message-ID: <20051019195217.GA5266@csclub.uwaterloo.ca>
References: <20051019193913.GA21749@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051019193913.GA21749@aitel.hist.no>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2005 at 09:39:13PM +0200, Helge Hafting wrote:
> I have an usb card reader (Apacer) in my desktop machine.
> 
> It has several slots for different card types. One of the slots accepts
> the compactflash cards I use in my camera.  I can mount those and
> copy the pictures, no problems there. (It becomes /dev/sdf)
> 
> Another slot accepts SD/MMC cards.  I tried inserting an MMC card,
> but nothing seems to happen.  Using /dev/sdf doesn't work - no medium.
> And /dev/sdg doesn't exist.  
> 
> I obviously have usb block devices & scsi working, or I'd be unable to use
> the compactflash cards.  I have also enabled CONFIG_MMC for this kernel. (2.6.14-rc3)
> 
> Is there anything else I should do, to make the mmc slot work too?

Your adapter might use LUNs rather than IDs for each port.  By default
(at least on most distribution compiled kernels) only LUN 0 is scanned.
You can enable scanning all LUNs on all scsi devices, or you can
manually run a script that scans for scsi devices on each LUN.

I belive the scsi-mod option max_luns should be set to 5 or 7 or
whatever many slots your device has, and that should hopefully make
things appear.

Len Sorensen
