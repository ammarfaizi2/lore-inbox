Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129231AbQKXRhn>; Fri, 24 Nov 2000 12:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129735AbQKXRhc>; Fri, 24 Nov 2000 12:37:32 -0500
Received: from waste.org ([209.173.204.2]:22846 "EHLO waste.org")
        by vger.kernel.org with ESMTP id <S129231AbQKXRh0>;
        Fri, 24 Nov 2000 12:37:26 -0500
Date: Fri, 24 Nov 2000 11:06:27 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Matti Aarnio <matti.aarnio@zmailer.org>
cc: Tobias Ringstrom <tori@tellus.mine.nu>, dhinds@zen.stanford.edu,
        torvalds@transmeta.com,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why not PCMCIA built-in and yenta/i82365 as modules
In-Reply-To: <20001122122543.A28963@mea-ext.zmailer.org>
Message-ID: <Pine.LNX.4.10.10011241057210.9367-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2000, Matti Aarnio wrote:

> On Tue, Nov 21, 2000 at 11:34:45PM +0100, Tobias Ringstrom wrote:
> > The subject says it all. Is there any particular (technical) reason
> > why I must have both the generic pcmcia code and the controller support
> > built-in, or build all of them as modules?
> > 
> > /Tobias
> 
> Wasn't there some strange laptop model which had PCMCIA floppy/CDROM,
> which are unavailable to bootstrap process, unless PCMCIA is supported
> at the booting kernel ?
> 
> Or was it about USB floppy at some other laptop?

Yes and yes. However, you still would need the controller specific code
built-in.

The USB floppy situation is uglier still. When I tried to put Debian on my
VAIO from floppy, I discovered that even with a USB-enabled kernel, the
floppy wasn't available in time to mount /. 

Approaches that did work, in case anyone is curious, were using loadlin
with FreeDOS (incredibly slow) to preload the second floppy via BIOS, or
using syslinux and a custom mini-kernel and initrd image crammed onto a
single floppy.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
