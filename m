Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268078AbTBMQaM>; Thu, 13 Feb 2003 11:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268080AbTBMQaM>; Thu, 13 Feb 2003 11:30:12 -0500
Received: from fmr02.intel.com ([192.55.52.25]:5587 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S268078AbTBMQaK>; Thu, 13 Feb 2003 11:30:10 -0500
Subject: Re: [PATCH][RFC] Proposal for a new watchdog interface using sysfs
From: Rusty Lynch <rusty@linux.co.intel.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: Dave Jones <davej@codemonkey.org.uk>, wingel@nano-systems.com,
       lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <Pine.LNX.4.33.0302131002420.1133-100000@localhost.localdomain>
References: <Pine.LNX.4.33.0302131002420.1133-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Feb 2003 07:51:45 -0800
Message-Id: <1045151506.1189.1.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-13 at 08:04, Patrick Mochel wrote:
> 
> On 13 Feb 2003, Rusty Lynch wrote:
> 
> > On Thu, 2003-02-13 at 03:55, Dave Jones wrote:
> > > On Wed, Feb 12, 2003 at 07:16:55PM -0800, Rusty Lynch wrote:
> > >  > Basically, with the help of some watchdog infrastructure code, we could make 
> > >  > each watchdog device register as a platform_device named watchdog, so for 
> > >  > every watchdog on the system there is a /sys/devices/legacy/watchdogN/ 
> > >  > directory created for it.  
> > > 
> > > Why legacy ? That seems an odd place to be putting these.
> > > 
> > > 		Dave
> > > 
> > > -- 
> > > | Dave Jones.        http://www.codemonkey.org.uk
> > > | SuSE Labs
> > 
> > The watchdogN devices show up under the "legacy" directory because
> > they are platform devices.  From reading the driver-model documentation,
> > I believe that platform devices are the correct way of categorizing
> > watchdog devices.
> > 
> > <pasting from Documentation/driver-model/platform.txt>
> > 
> > Platform devices
> > ~~~~~~~~~~~~~~~~
> 
> You could regard them as 'system' devices, and have them show up in 
> devices/sys/, which would make more sense than 'legacy'.
> 
> 	-pat

Ok, system device is the winner.

    -rustyl

