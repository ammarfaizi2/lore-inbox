Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262309AbUDETA1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 15:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbUDETA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 15:00:27 -0400
Received: from kamikaze.scarlet-internet.nl ([213.204.195.165]:11161 "EHLO
	kamikaze.scarlet-internet.nl") by vger.kernel.org with ESMTP
	id S262309AbUDETAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 15:00:25 -0400
Message-ID: <1081191622.4071acc6e100c@webmail.dds.nl>
Date: Mon,  5 Apr 2004 21:00:22 +0200
From: wdebruij@dds.nl
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [ANNOUNCE] various linux kernel devtools : device handling/memory mapping/profiling/etc
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday 05 April 2004 18:23, Greg KH wrote:
> I don't see anything in there that will work properly for udev.  Am I
> just missing the code somewhere?  Remember, for udev to work, you have
> to create stuff in sysfs, which I don't see this code doing.
indeed, automatic creation of the device files is not yet incorporated under 
udev, but at least it then reverts back to the oldstyle (mknod) device file 
system, right? That's a work in progress as my systems don't actually use 
udev just yet.

> Ick, you are using pci_find_device() which is racy, depreciated, and
> does not play nice with the rest of the kernel.  Yes, it's the lowest
> common denominater accross 2.2, 2.4, and 2.6, but please don't sink to
> that level if you don't have to.  For 2.6 it's just not acceptable.

hmm, really? thanks for the tip. I basically looked at O'Reilly's book when I 
coded that. Do you have a quick alternative for me to use?

>
> I agree that at times the current kernel driver api learning curve is a
> bit steep.  But people are working to reduce that curve where they can,
> and it's one of my main priorities for 2.7.  Any help and suggestions
> that you might have in that area are greatly appreciated.
>
perhaps some of this code (when cleaned up) can serve as a guide. I was 
actually wondering when a 2.7 release was scheduled.

Thanks for taking the time to look at the code,

Willem


ps: my regular smtp server stopped, so I had to copy-paste this into webmail.
Therefore, the in-reply-to, etc. tags are ommitted, possibly causing a
threadbreak. Sorry.
