Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271545AbTGQVcV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 17:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271550AbTGQVcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 17:32:21 -0400
Received: from main.gmane.org ([80.91.224.249]:18652 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S271545AbTGQVcP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 17:32:15 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jason Lunz <lunz@falooley.org>
Subject: Re: Wireless linux router
Date: Thu, 17 Jul 2003 21:46:05 +0000 (UTC)
Organization: PBR Streetgang
Message-ID: <slrnbhe6aq.95n.lunz@stoli.localnet>
References: <200307171924.UAA21477@mauve.demon.co.uk>
X-Complaints-To: usenet@main.gmane.org
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

root@mauve.demon.co.uk said:
> A while ago there was much discussion about wireless routers with
> linux kernels, and no source.
> 
> Are there any readily available ones that do, and that I can edit the 
> image, and that have a couple of meg of RAM/ROM free?

I've been playing with the Dell Truemobile 1184. It has 16M ram + 16M
flash, an ethernet interface for the internet uplink, another ethernet
interface hardwired to a four-port 10/100 switch, and a prism2 wireless
interface. If you open up the box, the machine has a serial console if
you can connect something to the pins.

It runs 2.2.14 arm linux, and you can telnet into it on port 333, though
there isn't much you can do there.  The kernel source is shipped along
with it on a CD, but there's no source for any of the other GPL code on
the machine, like brctl, ifconfig, reaim, and dproxy. I haven't checked
whether the kernel tarball contains code for all the weird hardware
devices, like the machine's LEDs.

Also, something seems fishy with the bridging. The machine's switch
interface is bridged to the prism0 interface with the linux bridging
module, and the bridge device shows up as br0. But "brctl show br0"
doesn't show the bridged devices. Maybe they're hardwired or something.

http://trilug.org/~chrish/dell-1184/

has some details. The firmware image he points to is a zipfile that
contains a gzipped binary blob. There's a kernel, a romfs, and who knows
what else in that blob (the romfs goes from 0xE2CE4 to the end of the
file). You could probably modify the firmware before sending it to the
machine and get your own code on there, but I haven't been brave enough
to do that yet.

I intend to eventually upload my own firmware to it, but I still have a
lot of investigating to do before i'm confident I won't turn it into a
paperweight. Any help would be appreciated. :)

Jason

