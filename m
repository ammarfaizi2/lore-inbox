Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287984AbSAHIgl>; Tue, 8 Jan 2002 03:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287983AbSAHIg3>; Tue, 8 Jan 2002 03:36:29 -0500
Received: from mail002.syd.optusnet.com.au ([203.2.75.245]:29365 "EHLO
	mail002.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S287991AbSAHIgP>; Tue, 8 Jan 2002 03:36:15 -0500
Date: Tue, 8 Jan 2002 19:36:04 +1100
To: linux-kernel@vger.kernel.org
Cc: david-b@pacbell.net
Subject: Re: Hardware Inventory [was: Re: ISA slot detection on PCI systems?]
Message-ID: <20020108193604.A27539@beernut.flames.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <17d401c197ca$a78e66c0$6800000a@brownell.org>
From: Kevin Easton <s3159795@student.anu.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hopefully, integration of /sbin/hotplug during the boot process (using 
> > dietHotplug) will reduce the number of things the "coldplug" issue will 
> > have to handle. 
> 
> 
> Somewhat -- though it only handles the "load a module" 
> subproblem. When new devices need any more setup 
> than that, "dietHotplug" isn't enough. 
> 
> 
> - Dave 

What if this was handled by the kernel not sending hotplug messages until it
had been told that the system was ready to load drivers etc.

init.d/hotplug tells the kernel that userspace is ready to hear about hotplug
events, and the kernel kicks off by telling /sbin/hotplug about the devices
that are already in the system at startup.

It should probably be a priority or bitmask, rather than a simple on/off
switch, so that the diethotplug in initramfs can be told about the devices
needed for booting (but the TV tuner can wait until the heavyweight hotplug
is around).

...or have I totally misunderstood the coldplug problem?

    - Kevin.

