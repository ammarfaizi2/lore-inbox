Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263567AbUDURmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263567AbUDURmV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 13:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbUDURmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 13:42:21 -0400
Received: from borf.com ([209.179.94.84]:49583 "EHLO edsac.borf.com")
	by vger.kernel.org with ESMTP id S263567AbUDURmQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 13:42:16 -0400
Message-ID: <c6be8c22d61f39eeb861c900d5abd7fe@borf.com>
Subject: AoE inclusion into 2.4.x
From: Sam Hopkins <sah@coraid.com>
Date: Wed, 21 Apr 2004 13:34:58 -0400
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I would like to offer our driver for inclusion into the 2.4 kernel.
Marcelo suggested (strongly) that I make this request officially
to the list.

The driver code is available from:

	http://www.coraid.com/support/aoe-1.6.tar

I'm now going to cheat and copy our prior correspondence.  Please CC me
on any comments / questions as I'm not a lkml subscriber.


Cheers,

Sam Hopkins
sah@coraid.com

-----
>From cyclades.com!marcelo.tosatti Wed Apr 21 12:18:18 EDT 2004
Date: Wed, 21 Apr 2004 13:16:35 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Sam Hopkins <sah@coraid.com>
Subject: Re: AoE driver inclusion into standard kernel release
In-Reply-To: <70362c6516a63d61c978affd8ac6d270@borf.com>

mail linux-kernel@vger.kernel.org
Subject: AoE inclusion into 2.4.x
Greetings,

I would like to offer our driver for inclusion into the 2.4 kernel.
Marcelo suggested (strongly) that I make this request officially
to the list.

The driver code is available from:

	http://www.coraid.com/support/aoe-1.6.tar

I'm now going to cheat and copy our prior correspondence.  Please CC me
on any comments / questions as I'm not a lkml subscriber.


Cheers,

Sam Hopkins
sah@coraid.com

-----
>From cyclades.com!marcelo.tosatti Wed Apr 21 12:18:18 EDT 2004
Date: Wed, 21 Apr 2004 13:16:35 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Sam Hopkins <sah@coraid.com>
Subject: Re: AoE driver inclusion into standard kernel release
In-Reply-To: <70362c6516a63d61c978affd8ac6d270@borf.com>

Hi Sam, 

Sorry for taking so long to answer. 

Currently 2.4.x is in maintenance-only mode, but I dont see a problem including
your driver. I strongly suggest you to post this announcement to the linux-kernel 
mailing list to get wider review, please.

Thanks!

On Sat, Apr 17, 2004 at 05:26:50PM -0400, Sam Hopkins wrote:
> Hello,
> 
> I would like to discuss getting my AoE protocol driver
> into the standard kernel release.  AoE (ATA over Ethernet)
> is an open protocol for transmitting ATA commands over ethernet
> frames.  AoE has an assigned IANA Ethernet type of 0x88a2 and
> an assigned linux kernel major number of 152.  The AoE driver
> translates block device requests into AoE requests to EtherDrive
> blades, the only device to currently support the AoE protocol.
> An EtherDrive blade is a small computer that answers AoE requests
> by performing them upon the attached ATA drive.  Each blade slides
> into a rackmount shelf where it gets access to power and ethernet.
> Each blade has its own ethernet address.  For more information about
> EtherDrive blades, please visit www.coraid.com.
> 
> The current addressing scheme for accessing EtherDrive blades
> has changed since the initial registration of the major number.
> Previously we had a mechanism by which users associated blades
> with a minor number and then accessed the blade by accessing
> /dev/etherd/<minor number>.  This was scrapped in favor of a
> simpler method.  The current mechanism relies on the notion
> that each blade slides into one of 18 slots in an addressable rack.
> The blade in shelf 0, slot 1 is addressed as /dev/etherd/00:01.
> For char devices, the following is now employed:
> 
> 	0 = /dev/etherd/ctl
> 	1 = /dev/etherd/stat
> 	2 = /dev/etherd/err
> 
> We may add /dev/etherd/raw back in the future, but currently
> it is no longer necessary.  Documentation at lanana.org should
> probably be updated to reflect these changes.
> 
> We've been using the AoE driver with EtherDrive blades and
> software raid for a while and I feel the driver is ready for
> this next step.  Please let me know if there is anything you
> need for me to do in order to move this along.
> 
> Cheers,
> 
> Sam Hopkins
> sah@coraid.com
