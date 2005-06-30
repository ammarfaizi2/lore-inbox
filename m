Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbVF3NMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVF3NMo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 09:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbVF3NMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 09:12:44 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:32901 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S261183AbVF3NMm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 09:12:42 -0400
Message-ID: <1120137161.42c3efc93b36c@imp1-q.free.fr>
Date: Thu, 30 Jun 2005 15:12:41 +0200
From: eric.valette@free.fr
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: updating kernel to 2.6.13-rc1 from 2.6.12 + CONFIG_DEVFS_FS + empty /dev
References: <42C30CBC.5030704@free.fr> <20050629224040.GB18462@kroah.com>
In-Reply-To: <20050629224040.GB18462@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 193.49.124.107
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Greg KH <greg@kroah.com>:

> On Wed, Jun 29, 2005 at 11:03:56PM +0200, Eric Valette wrote:
> > For years now my /dev has been empty. When upgrading to 2.6.13-rc1 from
> > 2.6.12, and updating my kernel config file via "make oldconfig" I got no
> > visible warning about CONFIG_DEVFS_FS options being set (or at least did
> > no see it).
>
> devfs has been marked OBSOLETE for a year now.  It has also been
> documented as going away.  Because of this, you should not have been
> supprised at all.

I knew it! I just the announce for 2.6.13-rc1 did not contain this fact and I
did not realize booting this new kernel will fail on my machine which is bad for
a stable serie.


> What are the speed differences that you see?  I've tested it and on a
> slow old laptop, with a lot of devices, udev only takes 2 seconds to
> initialize the whole device tree.  If you put it in initramfs, it will
> take no additional time, as it will operate on all of the hotplug events
> as they happen.  Can't get faster than "nothing" :)


If I already have every device in /dev, I do not need udev and yes it is fast
:-) This is exactly what I did to boot my system again. Just via devfs, I do
not need an initial filesystem nor need anything in user space to boot a full
system which I like.


-- eric

