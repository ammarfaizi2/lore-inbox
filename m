Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWGKRzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWGKRzS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 13:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWGKRzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 13:55:18 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:31575 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1751155AbWGKRzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 13:55:16 -0400
Message-ID: <44B3E5FE.5080709@tls.msk.ru>
Date: Tue, 11 Jul 2006 21:55:10 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Olaf Hering <olh@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
       Roman Zippel <zippel@linux-m68k.org>, torvalds@osdl.org,
       klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [klibc] klibc and what's the next step?
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home> <20060711044834.GA11694@suse.de> <44B37D9D.8000505@tls.msk.ru> <20060711112746.GA14059@suse.de> <44B3D0A0.7030409@zytor.com> <20060711164040.GA16327@suse.de> <44B3DA77.50103@garzik.org>
In-Reply-To: <44B3DA77.50103@garzik.org>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
[]
>> But so far, the arguments are not convincing that kinit has to be in the
>> kernel tree.
> 
> Two are IMO fairly plain:
> 
> * Makes sure you can boot the kernel you just built.

Nowadays, less and less setups will Just Work without additional
help.  softraid/lvm (yes I know about raid-autodetect, which should
DIE better sooner than later, due to its brokeness), firmware loading,
DSDT table updates, iSCSI and what not.

So, by just moving stuff to kinit and providing it with kernel
solves nothing in this area.

Yes, there's a very tiny difference between in-kernel kinit and
external kinit: I mean, external kinit has a >< bit more chances
to be incompatible with new kernel than kernel-supplied one.
But so are other tools and libraries, listed in Documentation/Changes.

> * Makes it easier to move stuff between kernel and userspace.

Again, not an argument to have kinit to be supplied by kernel.
Or, rarther, not strong argument.

It'd be much easier to "test" some stuff and to shuffle things
between kernel and user spaces if kinit is a part of kernel.
Like, move things to kinit, discover it does not quite work,
move some stuff back, etc.  With external kinit that will not
be easy, and kinit will grow indefinitely, accumulating all
the various compatibility/testing cruft.

But that's not how things should be done IMHO.  Testing/planning,
that is...

And again, how much stuff it's possible to shuffle this way?
How many new concepts *can* be moved from kernel to kinit,
anyway?  Uswsusp has been mentioned.  Anything else?

/mjt

