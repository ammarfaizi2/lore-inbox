Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130723AbRCMBnH>; Mon, 12 Mar 2001 20:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130733AbRCMBm5>; Mon, 12 Mar 2001 20:42:57 -0500
Received: from laurin.munich.netsurf.de ([194.64.166.1]:20967 "EHLO
	laurin.munich.netsurf.de") by vger.kernel.org with ESMTP
	id <S130723AbRCMBmn>; Mon, 12 Mar 2001 20:42:43 -0500
Date: Tue, 13 Mar 2001 02:43:11 +0100
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hotplug and interrupt context
Message-ID: <20010313024310.B2436@storm.local>
Mail-Followup-To: Jeff Garzik <jgarzik@mandrakesoft.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010312014811.B472@storm.local> <3AAC3FFA.1C3DDC0E@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AAC3FFA.1C3DDC0E@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sun, Mar 11, 2001 at 10:18:18PM -0500
From: Andreas Bombe <andreas.bombe@munich.netsurf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 11, 2001 at 10:18:18PM -0500, Jeff Garzik wrote:
> Andreas Bombe wrote:
> > 
> > I couldn't trace that down to be 100% sure and it's better to conform to
> > design than implementation, so I'll ask:
> > 
> > Do the probe and remove functions of a pci_driver have to be able to
> > work in interrupt context?  (i.e. GFP_ATOMIC and stuff)
> 
> No, no interrupt context to worry about.  It would really suck if you
> couldn't sleep in pci_driver::probe :)

Very good.  I wasn't sure since I saw GFP_ATOMIC allocations somewhere
in the cardbus code which looked like it was in card initialization.
But it's also confusing and somewhere was a note saying that some of
this is obsolete code which is replaced elsewhere...

> For CardBus, it calls schedule_task ..

Another thing learned, thanks.

-- 
 Andreas E. Bombe <andreas.bombe@munich.netsurf.de>    DSA key 0x04880A44
http://home.pages.de/~andreas.bombe/    http://linux1394.sourceforge.net/
