Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbVKWP5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbVKWP5H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 10:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbVKWP5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 10:57:06 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:45722 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1751135AbVKWP4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 10:56:34 -0500
Date: Wed, 23 Nov 2005 16:56:50 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Christmas list for the kernel
Message-ID: <20051123155650.GB6970@stiffy.osknowledge.org>
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com> <20051122204918.GA5299@kroah.com> <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com> <20051123121726.GA7328@ucw.cz> <9e4733910511230643j64922738p709fecd6c86b4a95@mail.gmail.com> <20051123150349.GA15449@flint.arm.linux.org.uk> <9e4733910511230712y2b394851rc17fa71c6f9c6ecf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910511230712y2b394851rc17fa71c6f9c6ecf@mail.gmail.com>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.15-rc2-marc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jon Smirl <jonsmirl@gmail.com> [2005-11-23 10:12:58 -0500]:

> On 11/23/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > > Plus I have 64 tty devices. Couldn't the tty devices be created
> > > dynamically as they are consumed? Same for the loop and ram devices?
> >
> > You do realise that the dynamic device creation for those 64 console
> > devices is done via the console device being _opened_ by userspace?
> >
> > Hence, if the device doesn't exist in userspace, it can't be created
> > for userspace to open it to create the device via udev.  Have you
> > noticed a catch-22 with that statement?
> 
> Couldn't we create tty0-3 and then when one of those gets opened,
> create tty4, and so on? Then there would always be two or three more
> tty devices than there are open tty devices.
> 

How does that work when you ie. have tty0, tty1, tty2, tty3 per default,
open tty4, tty5, tty6 and the close tty4? And what if you then open
another? Will it be tty4 oder tty7? If so, what if the maximum numer is
reached even if only 3 ttys are left open?
