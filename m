Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129991AbRBYJkS>; Sun, 25 Feb 2001 04:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129993AbRBYJkI>; Sun, 25 Feb 2001 04:40:08 -0500
Received: from adsl-63-202-13-20.dsl.snfc21.pacbell.net ([63.202.13.20]:15622
	"EHLO earth.zigamorph.net") by vger.kernel.org with ESMTP
	id <S129991AbRBYJj4>; Sun, 25 Feb 2001 04:39:56 -0500
Date: Sun, 25 Feb 2001 09:40:26 +0000 (UTC)
From: Adam Fritzler <mid@earth.zigamorph.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Core dumps for threads
In-Reply-To: <20010225221505.A12595@metastasis.f00f.org>
Message-ID: <Pine.LNX.4.21.0102250925230.26932-100000@earth.zigamorph.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Theres a patch floating around that does just that. Its an obvious
hack.  I would like to see something clean get into the mainstream
kernels.  Its a real pain not to have cores for threaded code.

It does work, however. It effectively dumps the thread that caused the
fault.  

(I have a complimentary hack that will dump the stacks of all the
rest of the threads as well (though its a good trick to get gdb to
interpret this). Available upon request.)

af

On Sun, 25 Feb 2001, Chris Wedgwood wrote:

> On Sat, Feb 24, 2001 at 09:57:44PM +0000, Alan Cox wrote:
> 
>     The I/O to dump the core would race other changes on the mm. The
>     right fix is probably to copy the mm (as fork does) then dump the
>     copy.
> 
> Stupid question... but since all threads see the same memory space as
> each other; can we not lock the entire vma for the process whilst
> it's being written out?
> 
> 
> 
>   --cw
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

