Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129099AbQKFSiS>; Mon, 6 Nov 2000 13:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129109AbQKFSiJ>; Mon, 6 Nov 2000 13:38:09 -0500
Received: from [193.120.224.170] ([193.120.224.170]:12176 "EHLO
	florence.itg.ie") by vger.kernel.org with ESMTP id <S129099AbQKFSiB>;
	Mon, 6 Nov 2000 13:38:01 -0500
Date: Mon, 6 Nov 2000 18:37:20 +0000 (GMT)
From: Paul Jakma <paulj@itg.ie>
To: David Woodhouse <dwmw2@infradead.org>
cc: "James A. Sutherland" <jas88@cam.ac.uk>,
        Horst von Brand <vonbrand@inf.utfsm.cl>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page] 
In-Reply-To: <7101.973530736@redhat.com>
Message-ID: <Pine.LNX.4.21.0011061831080.31802-100000@rossi.itg.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2000, David Woodhouse wrote:

> No. You should initialise the hardware completely when the driver is 
> reloaded.

and it is. just that 'mixer levels' are subjective - different users
have different tastes. in what way does:

- init to mute
- user set to liking

fail people? 

(sound modules shouldn't be unloaded as a matter of course, and user
set can be done with post-install option of modules.conf)

> the same as the last time the module was loaded, you can't know that the 
> machine hasn't been suspended and resumed since then.
> 

reloading modules may be a neccessary hack at present to reinit the
drivers after suspend/resume, but surely the correct answer there is
to go fix power management. the modules are not unloaded by the kernel
as part of the suspend event and they are not loaded as part of the
resume event. the module persists across the power event, so if
something breaks, go fix the power management handling - the driver
doesn't handle it properly!

--paulj

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
