Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264169AbUDROI0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 10:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264173AbUDROIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 10:08:25 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:49580 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S264169AbUDROIY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 10:08:24 -0400
From: Duncan Sands <baldrick@free.fr>
To: Oliver Neukum <oliver@neukum.org>, Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] [PATCH 1/9] USB usbfs: take a reference to the usb device
Date: Sun, 18 Apr 2004 16:08:21 +0200
User-Agent: KMail/1.5.4
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Frederic Detienne <fd@cisco.com>
References: <200404141229.26677.baldrick@free.fr> <200404181136.32308.baldrick@free.fr> <200404181557.59143.oliver@neukum.org>
In-Reply-To: <200404181557.59143.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404181608.21028.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

> Multiple interfaces are uncommon. Devices with several interfaces bound
> to usbfs are uncommoner. Concurrent use is still uncommoner. You are
> slowing the common case.

The slowdown is probably negligeable though.  The speedup may be big for
the rare cases where it matters (though I doubt anyone is ever going to care
one way or the other).

> > > > (2) push the acquisition of dev->serialize down to the lower levels
> > > > as they are fixed up.
> > >
> > > Why?
> >
> > Efficiency.  The main reason is that the copy to/from user calls are
> > inside the locked region :) As for the other places where the lock could
> > be dropped, I guess measurement is required to see if it gains anything.
>
> OK. I see. But IMHO usbfs is not written for speed anyway, so don't
> worry too much.

I'm not worrying!  It's more a matter of hygiene :)

Duncan.
