Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbVDEPmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbVDEPmp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 11:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbVDEPki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 11:40:38 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:9107 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261787AbVDEPhR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 11:37:17 -0400
Subject: Re: [PATCH 00/04] Load keyspan firmware with hotplug
From: Marcel Holtmann <marcel@holtmann.org>
To: dtor_core@ameritech.net
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, Greg KH <greg@kroah.com>,
       Sven Luther <sven.luther@wanadoo.fr>,
       Michael Poole <mdpoole@troilus.org>, debian-legal@lists.debian.org,
       debian-kernel@lists.debian.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <d120d50005040508287e7523c5@mail.gmail.com>
References: <20050404100929.GA23921@pegasos>
	 <20050404191745.GB12141@kroah.com>
	 <20050405042329.GA10171@delft.aura.cs.cmu.edu>
	 <200504042351.22099.dtor_core@ameritech.net>
	 <1112692926.8263.125.camel@pegasus>
	 <20050405114543.GG10171@delft.aura.cs.cmu.edu>
	 <1112711791.12406.26.camel@notepaq>
	 <d120d50005040508287e7523c5@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 17:37:11 +0200
Message-Id: <1112715431.12406.62.camel@notepaq>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

> > People are also working on a replacement for the
> > current request_firmware(), because the needs are changing. Try to keep
> > it close with the usb-serial for now.
> > 
> 
> Could you elaborate on what do you think is needed? I have some of
> patches to firmware loader and wondering if we should coordinate out
> efforts. I have
> 
> 1. convert from using a timer to wait_for_comletion_timeout which
> simplifies logic
> 2. tightening of state transition rules and removing possible memory
> leak (very unlikely)
> 3. converting firmware_priv to fw_class_dev to simplify memory management.
> 4. removing request_firmware_nowait as noone seems to be using it -
> and I doubt one would ever want to request firmware from an interrupt.
> 5. Creating firmware class in a separate thread to work around selinux
> (with prism54 firmware is loaded when interface is configured and thus
> firware loader runs in context of /sbin/ip which may not have access
> to sysfs. Having separate thread will ensure that firmware loader runs
> in kernel context).
> 
> And I was thinking about caching firmware (siomething like if you do
> "echo 2 > /sys/class/firmware/blah/loading" instead of 0 it will keep
> a copy of the firmware in memory. One could see all firmwares in
> /sys/class/firmware/loaded/<xxx> and by erase cached firmware by
> echoing 0 into it).
> 
> What do you think?

actually there is a thread about firmware loading rewrite and POST
calling of programs. It must be on LKML or the hotplug mailing list.
However my backlog for the interesting topics of these lists increased
while I was traveling the last 5-6 weeks. I think you should simply
start a new one on LKML.

Regards

Marcel


