Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbUDOIbc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 04:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbUDOIbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 04:31:32 -0400
Received: from mail1.kontent.de ([81.88.34.36]:64691 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262065AbUDOIbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 04:31:23 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Duncan Sands <baldrick@free.fr>, Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] [PATCH 7/9] USB usbfs: destroy submitted urbs only on the disconnected interface
Date: Thu, 15 Apr 2004 10:31:19 +0200
User-Agent: KMail/1.5.1
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Frederic Detienne <fd@cisco.com>
References: <200404141245.37101.baldrick@free.fr> <200404142239.08408.oliver@neukum.org> <200404151005.22143.baldrick@free.fr>
In-Reply-To: <200404151005.22143.baldrick@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404151031.19940.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 15. April 2004 10:05 schrieb Duncan Sands:
> On Wednesday 14 April 2004 22:39, Oliver Neukum wrote:
> > > > I would prefer a real WARN_ON() so that the imbedded people compiling
> > > > for size are not affected.
> > >
> > > What do you mean?  How is a real WARN_ON() better?
> >
> > WARN_ON can be defined away to make a smaller kernel. Code that does
> > not use it takes away that option.
>
> Hi Oliver, I thought you meant that CONFIG_EMBEDDED made WARN_ON go away
> (or something like that).  If you just mean that it is easy to redefine
> WARN_ON by hand, then all I can say is: it is also easy to redefine warn by
> hand!  Anyway, I made you the following patch:

Yes, but I don't trust gcc to optimise away the 'if' if you redefine warn().

But there is another point. The embedded people deserve a single switch
to remove assertion checks. The purpose of macros like WARN_ON() is
easy and _central_ choice of debugging output vs. kernel size.

	Regards
		Oliver

