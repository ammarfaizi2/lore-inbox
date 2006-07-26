Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWGZUtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWGZUtF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 16:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbWGZUtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 16:49:05 -0400
Received: from host36-195-149-62.serverdedicati.aruba.it ([62.149.195.36]:10938
	"EHLO mx.cpushare.com") by vger.kernel.org with ESMTP
	id S1750896AbWGZUtE (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 16:49:04 -0400
Date: Wed, 26 Jul 2006 22:50:17 +0200
From: andrea@cpushare.com
To: Jerome Pinot <ngc891@gmail.com>
Cc: "J. Bruce Fields" <bfields@fieldses.org>, Adrian Bunk <bunk@stusta.de>,
       Rene Rebe <rene@exactcode.de>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060726205017.GT32243@opteron.random>
References: <44C65931.6030207@namesys.com> <20060726124557.GB23701@stusta.de> <20060726132957.GH32243@opteron.random> <20060726134326.GD23701@stusta.de> <20060726142854.GM32243@opteron.random> <20060726145019.GF23701@stusta.de> <20060726160604.GO32243@opteron.random> <20060726170236.GD31172@fieldses.org> <20060726172029.GS32243@opteron.random> <88ee31b70607261201k24f4bf16s6a3a0baa1d376dcb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88ee31b70607261201k24f4bf16s6a3a0baa1d376dcb@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removed some people from CC since we're quickly changing topic and I
doubt they're interested.

On Thu, Jul 27, 2006 at 04:01:02AM +0900, Jerome Pinot wrote:
> Maybe you could try pushing the use of klive by some distros arguing
> it's "a way of getting usage statistics in order to improve kernel
> quality and hardware support". I mean, not just an extra package but a
> service launch at the first boot so anyone can use it.
> 
> klive is a nice project, it just needs more _different_ users and
> maybe, a support of some distros.

That would be nice yes. KLive is already supported by Gentoo that
created a proper emerge package, that's why there are so many gentoo
kernels being tracked. Others are of course welcome. I'm open to
suggestions on extending it as well.

At the moment the todo list is like this:

1) create an optional http transport to pass through most firewalls
2) send a packet when system reboots so I can track which sessions
   didn't cleanly reboot (it's not reliable if you disconnect
   from the internet first and you shutdown later, but it's better
   than nothing)
3) send the oops from kernel to klive server, so no oopses will be
   lost and I can use the pciids details to track down bad hardware
   as well
4) possibly send info on usb buses too and not only about the pci buses

> Maybe, you could try add a page in the klive wiki for putting packages
> and RPMs of klive for several distros ? What do you think ? It's a
> first step to get it merge into distros.

If more distros will pickup KLive that will help like demonstrated by
the emerge package from gentoo.

It's already very simple to install klive, I wrote an universal
installer that runs on any flavour of any weird distro out there:

	wget klive.cpushare.com/klive.sh
	sh klive.sh --install

If you don't want it anymore:

       sh klive.sh --uninstall

that's it.

The rpm/deb packages would be just to make life easier for distro to
pick it up but I hoped they had the resources to do the packaging work
themself...

Perhaps once I'll create the CPUShare rpm/deb packages I'll be easy to
share the work to create the KLive ones too. As far as spare time work
goes, CPUShare currently has a much higher prio than KLive, and I'm
not yet at the point of creating rpm/deb packages, now that CPUShare
transaction works and you can already compute remotely, I'm currently
fighting with the paypal sendbox so I can start accepting cash into
the system ASAP. But the hardest part of the ebusiness side of
CPUShare is the handling of the invoicing and receipts generation
which is a non computer related problem. I almost solved it though.

> In my case, I got some .tgz that feel lonely...

The .tgz is only for the ones interested hacking or studying it (both
client and server). You should be using the .sh script above.

Also note, the export of the whole database isn't available on the
site, but I've no problem to publish it after filtering out all the ip
addresses (which are collected only for purely paranoid security
purposes, and tor doesn't route udp traffic).

> Maybe be in 2 years, we will know EXACTLY of much people use
> EXT4/Reiser5/CoincoinFS/CrashFS...

BTW, CPUShare records a lot more than the fs already. 2 years or more,
but I'm not in a hurry. The server will also soon require some caching
trick to avoid recomputing the queries every time you click on
it. Current KLive is the best I could do in a very little time I spent
on it, it works well, but it still has an huge room for
improvement. Also note, so far KLive logged 76989 cumulative days of
uptime. When I see a number like that my mind thinks at the energy
that can be recycled if all that time recorded on KLive would be
routed inside CPUShare. That's why for me it's more urgent to give a
chance to those brave 500 users to cash in with CPUShare than to push
KLive beyond its current status ;). In due time KLive will get more
attention too.
