Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264554AbTDPTZK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 15:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264555AbTDPTZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 15:25:09 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:54508 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264554AbTDPTZE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 15:25:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Stekloff <dsteklof@us.ibm.com>
To: Patrick Mochel <mochel@osdl.org>
Subject: Re: [patch] printk subsystems
Date: Wed, 16 Apr 2003 12:35:12 +0000
User-Agent: KMail/1.4.1
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Martin Hicks <mort@wildopensource.com>,
       <hpa@zytor.com>, <pavel@ucw.cz>, <jes@wildopensource.com>,
       <linux-kernel@vger.kernel.org>, <wildos@sgi.com>
References: <Pine.LNX.4.44.0304161140160.912-100000@cherise>
In-Reply-To: <Pine.LNX.4.44.0304161140160.912-100000@cherise>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304161235.12839.dsteklof@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 April 2003 06:42 pm, Patrick Mochel wrote:
> > Would the debug level be for the entire subsystem? Do you think people
> > would like to be able to set debug/logging level per driver or device,
> > and not just subsystem?
>
> I can see a use for doing per-object debug levels, but I'd rather not add
> the overhead to every object, especially when it would be used by a small
> minority of the populace.
>
> Such a flag could easily be placed in the subsystem-specific object, and
> accessed through the logging/debugging wrappers.


I was thinking this as well, having the dev_* macros make the check for the 
current logging level. That way each call to the macros wouldn't have to 
check the flag but could be part of the added value the macros give us.



> > Is debugging level here the same as logging level?
>
> Yes.
>
> > I like the idea of having logging levels, which include debug, defined by
> > subsystem. Each subsystem will have separate requirements for logging.
> > Networking, for instance, already has the NETIF_MSG* levels defined in
> > netdevice.h that can be set with Ethtool. I can see, for example, having
> > the msg_enable not in the private data as it is now but in the subsystem
> > or class structure for that device, such as in struct net_device. This
> > could easily be exported through sysfs.
>
> It would be nice. Unfortunately, it's only a nifty pipe-dream at the
> moment, unless some lucky volunteer would like to step forward. ;)


This is where I was going back when I sent you the patch for the network 
device class. Unfortunately, I haven't returned to looking at it. Too busy 
banging my head against other things... <grin>


