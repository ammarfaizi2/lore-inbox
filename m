Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129827AbQKFRh4>; Mon, 6 Nov 2000 12:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130044AbQKFRhj>; Mon, 6 Nov 2000 12:37:39 -0500
Received: from lilac.csi.cam.ac.uk ([131.111.8.44]:57493 "EHLO
	lilac.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S130025AbQKFRh0>; Mon, 6 Nov 2000 12:37:26 -0500
From: "James A. Sutherland" <jas88@cam.ac.uk>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
Date: Mon, 6 Nov 2000 17:33:54 +0000
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Dan Hollis <goemon@anime.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
In-Reply-To: <00110616471600.01646@dax.joh.cam.ac.uk> <23007.973524894@redhat.com> <6786.973530532@redhat.com>
In-Reply-To: <6786.973530532@redhat.com>
MIME-Version: 1.0
Message-Id: <00110617370400.24534@dax.joh.cam.ac.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2000, David Woodhouse wrote:
> jas88@cam.ac.uk said:
> >  Yippee. As we all know, implementing GUI volume controls and putting
> > the slider in the right place is a kernel function, and nothing to do
> > with userspace... 
> 
> Don't troll, James. The kernel needs to provide the functionality required 
> by userspace. The functionality required in this case is the facility to 
> read the current mixer levels.

Except this isn't possible with the hardware in question! If it were, there
would be no problem. In cases where the hardware doesn't support the
functionality userspace "needs", why put the kludge in the kernel?

If userspace wants to know what settings it set last time, it should store
those values somewhere.

> jas88@cam.ac.uk said:
> >  The right thing in this context is not to screw with hardware
> > settings unless and until it is given settings to set. Do not set
> > values arbitrarily: set only the values you are explicitly given.
> > Anything else is simply a bug in your driver. 
> 
> It is unwise to assume that the hardware is in a sane state when the driver 
> has been unloaded and reloaded. I agree that you should set the values that 
> were explicitly given. That's why we should remember them.

No values are being explicitly given. Loading the driver should not cause
any settings to be changed: changing the settings should do that!

There is no need for the drivers to change any settings. If the settings need
to be (re)set, let userspace do it.
 

James. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
