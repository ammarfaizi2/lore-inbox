Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268267AbTBMTNo>; Thu, 13 Feb 2003 14:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268268AbTBMTNo>; Thu, 13 Feb 2003 14:13:44 -0500
Received: from fmr01.intel.com ([192.55.52.18]:28110 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S268267AbTBMTNn>;
	Thu, 13 Feb 2003 14:13:43 -0500
Subject: Re: [PATCH][RFC] Proposal for a new watchdog interface using sysfs
From: Rusty Lynch <rusty@linux.co.intel.com>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Patrick Mochel <mochel@osdl.org>, wingel@nano-systems.com,
       lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20030213190755.GA11244@codemonkey.org.uk>
References: <Pine.LNX.4.33.0302131002420.1133-100000@localhost.localdomain>
	<1045151506.1189.1.camel@vmhack>  <20030213190755.GA11244@codemonkey.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Feb 2003 10:31:22 -0800
Message-Id: <1045161084.1721.30.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-13 at 11:07, Dave Jones wrote:
> On Thu, Feb 13, 2003 at 07:51:45AM -0800, Rusty Lynch wrote:
> 
>  > > You could regard them as 'system' devices, and have them show up in 
>  > > devices/sys/, which would make more sense than 'legacy'.
>  > Ok, system device is the winner.
> 
> Why? Stop for a second and look what we have in those dirs.
> They both contain things that are essentially motherboard resources.
> 
> These are add-on cards we're talking about. Surely a more sensible
> place for them to live is somewhere under devices/pci0/ or whatever
> bus-type said card is for.
> 
> Whilst there are some watchdogs which _are_ part of the motherboard
> chipset (which is arguably 'system'), these still show up in PCI
> space as regular PCI devices.
> 
> Lumping them all into the same category as things like rtc, pic,
> fdd etc is just _wrong_.
> 
> 		Dave
> 

The thing I would like to see is an easy way for a user space
application to see the available watchdog devices without searching
every possible bus type.  If we had that one location to find all
watchdog devices, then each device could just be a symbolic link to the
device in it's real bus.

Maybe the system bus is not right.  Is there a right place, or does the
sysfs layout need a new concept?  This could apply to any type of
device, not just watchdogs.

    --rustyl

