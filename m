Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbTJGNRW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 09:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbTJGNRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 09:17:22 -0400
Received: from web40910.mail.yahoo.com ([66.218.78.207]:48505 "HELO
	web40910.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261869AbTJGNRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 09:17:20 -0400
Message-ID: <20031007131719.27061.qmail@web40910.mail.yahoo.com>
Date: Tue, 7 Oct 2003 06:17:19 -0700 (PDT)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Re: devfs and udev
To: mru@users.sourceforge.net
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Rullgard,

> I noticed this in the help text for devfs in 2.6.0-test6:
>
> Note that devfs has been obsoleted by udev,
> <http://www.kernel.org/pub/linux/utils/kernel/hotplug/>.
> It has been stripped down to a bare minimum and is only provided for
> legacy installations that use its naming scheme which is
> unfortunately different from the names normal Linux installations
> use.
> 
> Now, this puzzles me, for a few of reasons. Firstly, not long ago,
> devfs was spoken of as the way to go, and all drivers were rewritten
> to support it. Why this sudden change? Secondly, that link only
> leads me to a package describing itself as an experimental
> proof-of-concept thing, not to be used for anything serious. How can
> something that incomplete obsolete a working system like devfs?
> Thirdly, udev appears to respond to hotplug events only. How is it
> supposed to handle device files not corresponding to any physical
> device? Finally, I quite liked the idea of a virtual filesystem for
> /dev. It reduced the clutter quite a bit. As for the naming scheme,
> it could easily be changed.

I think the two things which really prevented devfs from working were:

1. The namespace was too different from the original and required additional
configuration to maintain compatibility (devfsd and changes to core /etc
files.)
2. Devfs was not immediately picked up my the major distros, which meant that
any moderate end-user who wanted to use it would have to be careful when
setting it up or risk massive core breakage due to the changed device nodes
(initscripts failing and the like).

I used it for a very long time, personally; it was a good idea, and it had
potential. If the namespace that had been used was the same flat namespace as
the original /dev, it would have probably taken off. As it is, I think udev
is the new way of doing this (I haven't used it yet).

Brad

=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
