Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262581AbRENXih>; Mon, 14 May 2001 19:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262587AbRENXi1>; Mon, 14 May 2001 19:38:27 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:666 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S262581AbRENXiK>; Mon, 14 May 2001 19:38:10 -0400
Date: Mon, 14 May 2001 17:34:44 -0600
Message-Id: <200105142334.f4ENYiG19426@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <20010514230954.A4305@gruyere.muc.suse.de>
In-Reply-To: <3B003EFC.61D9C16A@mandrakesoft.com>
	<Pine.LNX.4.31.0105141328020.22874-100000@penguin.transmeta.com>
	<20010514230954.A4305@gruyere.muc.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
> On Mon, May 14, 2001 at 01:29:51PM -0700, Linus Torvalds wrote:
> > Big device numbers are _not_ a solution. I will accept a 32-bit one, but
> > no more, and I will _not_ accept a "manage by hand" approach any more. The
> > time has long since come to say "No". Which I've done. If you can't make
> > it manage the thing automatically with a script, you won't get a hardcoded
> > major device number just because you're lazy.
> 
> As far as I can see it just needs a /proc/devices that also outputs
> minor ranges with names, and a small program similar to scsidev to 
> generate nodes in /dev based on that on the fly on early bootup.

You can do that with devfs. It provides all this information. If you
really don't want to mount devfs over /dev, then mount it elsewhere
and just use it as an information source to populate /dev. No need to
add more code to the kernel to do it another way.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
