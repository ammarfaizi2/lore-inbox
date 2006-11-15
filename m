Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966720AbWKOJcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966720AbWKOJcJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 04:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966721AbWKOJcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 04:32:09 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:43481 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S966720AbWKOJcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 04:32:08 -0500
Subject: Re: [Patch -mm 2/5] driver core: Introduce device_move(): move a
	device to a new parent.
From: Kay Sievers <kay.sievers@vrfy.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
In-Reply-To: <20061115102409.6e6e5dc0@gondolin.boeblingen.de.ibm.com>
References: <20061114113208.74ec12c4@gondolin.boeblingen.de.ibm.com>
	 <20061115065052.GC23810@kroah.com>
	 <20061115082856.195ca0ab@gondolin.boeblingen.de.ibm.com>
	 <3ae72650611150044y8e0b57k681c478dca5c6cbf@mail.gmail.com>
	 <20061115102409.6e6e5dc0@gondolin.boeblingen.de.ibm.com>
Content-Type: text/plain
Date: Wed, 15 Nov 2006 10:31:59 +0100
Message-Id: <1163583119.4244.6.camel@pim.off.vrfy.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:4ddcc9dd12ba6cf3155e4d81b383efda
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-15 at 10:24 +0100, Cornelia Huck wrote:
> On Wed, 15 Nov 2006 09:44:33 +0100,
> "Kay Sievers" <kay.sievers@vrfy.org> wrote:
> 
> > Udev and HAL, both will need an event for the moving, with the old
> > DEVPATH value in the environment. We want something like a "rename" or
> > "move" event. Without that, weird things will happen in userspace,
> > because the devpath is used as the key to the device during the whole
> > device lifetime. The only weird exception today is the netif rename
> > case, which is already handled by special code in udev.
> 
> Something like below (completely untested as my test box is currently
> inaccessible)?

We need the old DEVPATH in the environment (or something similar),
otherwise we can't connect the event with the new device location to the
current device. :)

> Wouldn't we need something similar for kobject_rename()
> as well?

Maybe kobject_rename() can go, if we have a move function which can be
used. In any case, the events should look identical to userspace, yes.

Thanks,
Kay

