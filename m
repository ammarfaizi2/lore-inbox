Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129416AbQKHO47>; Wed, 8 Nov 2000 09:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129451AbQKHO4k>; Wed, 8 Nov 2000 09:56:40 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:18195 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129130AbQKHO4W>;
	Wed, 8 Nov 2000 09:56:22 -0500
Date: Wed, 8 Nov 2000 15:56:15 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
        David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
Message-ID: <20001108155615.B2430@pcep-jamie.cern.ch>
In-Reply-To: <200011061631.eA6GVkw07051@pincoya.inf.utfsm.cl> <E13spzE-0006Q3-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E13spzE-0006Q3-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Nov 06, 2000 at 05:23:11PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Add a 'preserved' tag for one section of module memory. On load look up the
> data, if its from this boot memcpy it into the module. On unload write it
> back to disk. No kernel code needed.

I like!  No kernel code, yet no races or delay.

As written that removes the possibilities of variable length persistant
data, and the data is opaque to user space.

MODULE_PARM provides type information and structure to the data.  Why
not mark certain PARMS as persistent?  Not all would be named -- a block
of opaque data is useful.  But certain things like all the mixer levels
could be named parameters, giving you both persistant storage _and_
explicit configuration when you want that.  "s" PARMS (or similar)
can hold variable length data.

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
