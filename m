Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264527AbTDPScf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 14:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264533AbTDPScf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 14:32:35 -0400
Received: from air-2.osdl.org ([65.172.181.6]:30429 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264527AbTDPSce (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 14:32:34 -0400
Date: Wed, 16 Apr 2003 11:42:59 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Daniel Stekloff <dsteklof@us.ibm.com>
cc: "Randy.Dunlap" <rddunlap@osdl.org>, Martin Hicks <mort@wildopensource.com>,
       <hpa@zytor.com>, <pavel@ucw.cz>, <jes@wildopensource.com>,
       <linux-kernel@vger.kernel.org>, <wildos@sgi.com>
Subject: Re: [patch] printk subsystems
In-Reply-To: <200304141533.18779.dsteklof@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0304161140160.912-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Would the debug level be for the entire subsystem? Do you think people would 
> like to be able to set debug/logging level per driver or device, and not just 
> subsystem? 

I can see a use for doing per-object debug levels, but I'd rather not add 
the overhead to every object, especially when it would be used by a small 
minority of the populace. 

Such a flag could easily be placed in the subsystem-specific object, and 
accessed through the logging/debugging wrappers.

> Is debugging level here the same as logging level? 

Yes. 

> I like the idea of having logging levels, which include debug, defined by 
> subsystem. Each subsystem will have separate requirements for logging. 
> Networking, for instance, already has the NETIF_MSG* levels defined in 
> netdevice.h that can be set with Ethtool. I can see, for example, having the 
> msg_enable not in the private data as it is now but in the subsystem or class 
> structure for that device, such as in struct net_device. This could easily be 
> exported through sysfs. 

It would be nice. Unfortunately, it's only a nifty pipe-dream at the 
moment, unless some lucky volunteer would like to step forward. ;)


	-pat

