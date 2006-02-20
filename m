Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932609AbWBTM5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932609AbWBTM5p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 07:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932613AbWBTM5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 07:57:45 -0500
Received: from mx0.towertech.it ([213.215.222.73]:2540 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S932611AbWBTM5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 07:57:44 -0500
Date: Mon, 20 Feb 2006 13:57:18 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: David Vrabel <dvrabel@cantab.net>
Cc: Adrian Bunk <bunk@stusta.de>, Martin Michlmayr <tbm@cyrius.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       John Bowler <jbowler@acm.org>
Subject: Re: [RFC] [PATCH 1/2] Driver to remember ethernet MAC values:
 maclist
Message-ID: <20060220135718.038b675b@inspiron>
In-Reply-To: <43F9B32B.3090203@cantab.net>
References: <20060220010113.GA19309@deprecation.cyrius.com>
	<20060220014735.GD4971@stusta.de>
	<20060220030146.11f418dc@inspiron>
	<43F9B32B.3090203@cantab.net>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Feb 2006 12:16:43 +0000
David Vrabel <dvrabel@cantab.net> wrote:

> >>>Some Ethernet hardware implementations have no built-in storage for
> >>>allocated MAC values - an example is the Intel IXP420 chip which has
> >>>support for Ethernet but no defined way of storing allocated MAC values.
> >>>With such hardware different board level implementations store the
> >>>allocated MAC (or MACs) in different ways.  Rather than put board level
> >>>code
 
> For those not familar with the IXP4xx, the Ethernet drivers are
> proprietary and given that there are no other proposed users of this
> maclist code there's no need for it in the kernel at this time.

> >>Why can't this be implemented in user space using the SIOCSIFHWADDR 
> >>ioctl?
 
> I'm with Adrian on this -- it's a job for userspace.  The storage of the
> MAC address isn't something that's necessarily board specific anyway but
> could depend on which bootloader is used and/or the bootloader version.

> >  Because sometimes you need to have networking available
> >  well before userspace.
> 
> In the specific case of the IXP4xx, you presumably have some userspace
> available because you've just loaded the NPE firmware from it, yes?

 Hi David,
  
  you're certainly right on the ixp4xx, but the are other uses
 for this driver which we are working on.. for example,
 some Cirrus Logic ARM based chips (ep93xx) have an ethernet device
 that could benefit from that.

  I'm pretty sure that there are and will be more devices
 with such requirements, with either proprietary or
 open source drivers. My opinion is that a maclist alike
 facility can clean some of the mess in that area.

  If we implement such a thing in userspace every distribution
 will need to be aware of a specific trick for a specific
 board. If we have a clean facility in the kernel, userspace
 will not need to care.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

