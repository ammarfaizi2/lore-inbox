Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266110AbTLIUTw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 15:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266080AbTLIUSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 15:18:22 -0500
Received: from zeus.kernel.org ([204.152.189.113]:37280 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S266107AbTLIUPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 15:15:35 -0500
Date: Tue, 9 Dec 2003 11:33:57 -0800
From: Greg KH <greg@kroah.com>
To: Eduard Bloch <edi@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: State of devfs in 2.6?
Message-ID: <20031209193357.GA13572@kroah.com>
References: <200312081536.26022.andrew@walrond.org> <20031208154256.GV19856@holomorphy.com> <pan.2003.12.08.23.04.07.111640@dungeon.inka.de> <20031208233428.GA31370@kroah.com> <1070953338.7668.6.camel@simulacron> <20031209083228.GC1698@kroah.com> <3FD59CED.6090408@portrix.net> <20031209162747.GB8675@kroah.com> <20031209164738.GA4159@zombie.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031209164738.GA4159@zombie.inka.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 09, 2003 at 05:47:39PM +0100, Eduard Bloch wrote:
> #include <hallo.h>
> * Greg KH [Tue, Dec 09 2003, 08:27:47AM]:
> 
> > Like Matthew stated, either use the udev rc startup script, or put udev
> > into your initramfs image to catch all of the early boot messages.
> > Doing the initramfs method is still very tough to do right now, but
> > people have reported success that way.  I still recommend just using the
> > init.d script for now.
> 
> Wouln't it be less error-prone to introduce a kind of queing for the
> hotplug program so kernel puts all the registered devices in a list and
> the list is submitted in one pass when udev asks for it?

Heh, no.  It's much easier to just run out of early userspace.

But that's just my opinion, if you think differently, I'd be very glad
to see the code for your solution. :)

thanks,

greg k-h
