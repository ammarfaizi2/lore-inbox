Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVDDLop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVDDLop (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 07:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbVDDLop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 07:44:45 -0400
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:53733 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261223AbVDDLon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 07:44:43 -0400
Subject: Re: [ACPI] Re: [RFC 0/6] S3 SMP support with physcial CPU hotplug
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: David Shaohua <shaohua.li@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI List <acpi-devel@lists.sourceforge.net>, zwane@linuxpower.ca,
       len.brown@intel.com
In-Reply-To: <20050404113129.GA7120@atrey.karlin.mff.cuni.cz>
References: <1112580342.4194.329.camel@sli10-desk.sh.intel.com>
	 <20050403193750.40cdabb2.akpm@osdl.org>
	 <1112608444.3757.17.camel@desktop.cunningham.myip.net.au>
	 <20050404113129.GA7120@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Message-Id: <1112615184.3757.21.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 04 Apr 2005 21:46:24 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again.

On Mon, 2005-04-04 at 21:31, Pavel Machek wrote:
> Hi!
> 
> > > > The patches are against 2.6.11-rc1 with Zwane's CPU hotplug patch in -mm
> > > >  tree.
> > > 
> > > Should I merge that thing into mainline?  It seems that a few people are
> > > needing it.
> > 
> > Perhaps we should address the MTRR issue first.
> > 
> > I've had code in Suspend2 for quite a while (6 months+) that removes the
> > sysdev support for MTRRs and saves and restores them with CPU context,
> > thereby avoiding the smp_call-while-interrupts-disabled issue. Perhaps
> > it would be helpful here?
> 
> This seems like separate issue... I'd prefer not to block this patch.
> 
> MTRRs should be probably handled by some kind of "cpu is going down"
> and "cpu is going up" callbacks... Zwane, do you have any ideas?
> Linklist of handlers should be enough...

What else is it needed for? CpuFreq?

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net

