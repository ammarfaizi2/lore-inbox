Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268072AbTBMQBF>; Thu, 13 Feb 2003 11:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268074AbTBMQBF>; Thu, 13 Feb 2003 11:01:05 -0500
Received: from air-2.osdl.org ([65.172.181.6]:30610 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268072AbTBMQA6>;
	Thu, 13 Feb 2003 11:00:58 -0500
Date: Thu, 13 Feb 2003 10:04:02 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Rusty Lynch <rusty@linux.co.intel.com>
cc: Dave Jones <davej@codemonkey.org.uk>, <wingel@nano-systems.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH][RFC] Proposal for a new watchdog interface using sysfs
In-Reply-To: <1045150488.1009.3.camel@vmhack>
Message-ID: <Pine.LNX.4.33.0302131002420.1133-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 13 Feb 2003, Rusty Lynch wrote:

> On Thu, 2003-02-13 at 03:55, Dave Jones wrote:
> > On Wed, Feb 12, 2003 at 07:16:55PM -0800, Rusty Lynch wrote:
> >  > Basically, with the help of some watchdog infrastructure code, we could make 
> >  > each watchdog device register as a platform_device named watchdog, so for 
> >  > every watchdog on the system there is a /sys/devices/legacy/watchdogN/ 
> >  > directory created for it.  
> > 
> > Why legacy ? That seems an odd place to be putting these.
> > 
> > 		Dave
> > 
> > -- 
> > | Dave Jones.        http://www.codemonkey.org.uk
> > | SuSE Labs
> 
> The watchdogN devices show up under the "legacy" directory because
> they are platform devices.  From reading the driver-model documentation,
> I believe that platform devices are the correct way of categorizing
> watchdog devices.
> 
> <pasting from Documentation/driver-model/platform.txt>
> 
> Platform devices
> ~~~~~~~~~~~~~~~~

You could regard them as 'system' devices, and have them show up in 
devices/sys/, which would make more sense than 'legacy'.

	-pat

