Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265548AbUGTFBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265548AbUGTFBm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 01:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265654AbUGTFBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 01:01:42 -0400
Received: from [216.208.38.106] ([216.208.38.106]:61437 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S265548AbUGTFBk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 01:01:40 -0400
Date: Tue, 20 Jul 2004 07:02:43 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: john stultz <johnstul@us.ibm.com>
Cc: greg kh <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x445 usb legacy fix
Message-ID: <20040720050243.GC313@ucw.cz>
References: <1090286508.1388.434.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090286508.1388.434.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2004 at 06:21:49PM -0700, john stultz wrote:

> Greg, All,
> 	Apparently there is an issue w/ the IBM x440/x445's BIOS's USB Legacy
> support. Due to the delay in issuing SMI's across the IOAPICs, its
> possible for I/O to ports 60/64 to cause register corruption. 
> 
> The solution is to disable the BIOS's USB Legacy support early in boot
> (via PCI quirks) for x440/x445 systems. 
> 
> This is the same method posted to lkml here (Originally written by
> Vojtech): http://www.ussg.iu.edu/hypermail/linux/kernel/0405.3/1712.html
> 
> (Use the following link for the raw mbox email)
> http://lkml.org/lkml/mbox/2004/5/31/97
> 
> While Greg was cautious that this method couldn't always be used, I've
> created a patch that applies on top of Vojtech's that creates a boot
> option which allows you to specify "no-usb-legacy". Additionally this
> patch enables the "no-usb-legacy" option by default for x440/x445
> systems.
> 
> Please consider for inclusion (along with the patch linked to above)
> into your tree. 

I think we'll go with the original patch that disables it
unconditionally, right, Greg?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
