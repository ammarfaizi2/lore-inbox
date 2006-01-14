Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbWANWv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWANWv5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 17:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWANWvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 17:51:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54194 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751338AbWANWvx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 17:51:53 -0500
Date: Sat, 14 Jan 2006 17:51:37 -0500
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-git breaks Xorg on em64t
Message-ID: <20060114225137.GB23021@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060114065235.GA4539@redhat.com> <200601141943.28027.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601141943.28027.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2006 at 07:43:27PM +0100, Andi Kleen wrote:
 > On Saturday 14 January 2006 07:52, Dave Jones wrote:
 > > Andi,
 > >  Sometime in the last week something was introduced to Linus'
 > > tree which makes my dual EM64T go nuts when X tries to start.
 > > By "go nuts", I mean it does various random things, seen so
 > > far..
 > > - Machine check. (I'm convinced this isn't a hardware problem
 > >   despite the new addition telling me otherwise :)
 > 
 > Normally it should be impossible to cause machine checks from software
 > on Intel systems.

-git7+ is the only time I've ever seen one on this box.

 > > - Reboot
 > > - Total lockup
 > > - NMI watchdog firing, and then lockup
 > >
 > > I've tried backing out a handful of the x86-64 patches, and
 > > didn't get too far, as some of them are dependant on others,
 > > it quickly became a real mess to try to bisect where exactly it broke.\
 > 
 > Shouldn't be too bad - i did a binary search for something else and it worked 
 > pretty well.

The patches reverted, but I hit problems like modprobe segfaulting during
boot, or reboots during APIC init.

 > > Any ideas for potential candidates to try & back out ?
 > Does it work when you revert all x86-64 changes?

-git6 which was the last one not to include the x86-64 changes boots and runs fine.

I'll try a latest -git with x86-64 backed out when I get a chance.

		Dave

