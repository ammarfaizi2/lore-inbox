Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268312AbTBMWsk>; Thu, 13 Feb 2003 17:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268311AbTBMWsj>; Thu, 13 Feb 2003 17:48:39 -0500
Received: from fed1mtao04.cox.net ([68.6.19.241]:44976 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP
	id <S268310AbTBMWsb>; Thu, 13 Feb 2003 17:48:31 -0500
Date: Thu, 13 Feb 2003 15:58:17 -0700
From: Matt Porter <porter@cox.net>
To: Scott Murray <scottm@somanetworks.com>
Cc: Patrick Mochel <mochel@osdl.org>, Rusty Lynch <rusty@linux.co.intel.com>,
       Dave Jones <davej@codemonkey.org.uk>, wingel@nano-systems.com,
       lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH][RFC] Proposal for a new watchdog interface using sysfs
Message-ID: <20030213155817.B1738@home.com>
References: <Pine.LNX.4.33.0302131317210.1133-100000@localhost.localdomain> <Pine.LNX.4.44.0302131603500.23407-100000@rancor.yyz.somanetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0302131603500.23407-100000@rancor.yyz.somanetworks.com>; from scottm@somanetworks.com on Thu, Feb 13, 2003 at 04:12:28PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2003 at 04:12:28PM -0500, Scott Murray wrote:
> On Thu, 13 Feb 2003, Patrick Mochel wrote:
> > 
> [snip]
> > Create a watchdog timer class. That will contain all watchdog timers, no 
> > matter what bus they are on. 
> > 
> > I apologize for leading you astray with suggesting you treat them as 
> > system devices; I was under the assumption they were more important. :)
> > They should always be in the most accurate place in the tree. Don't worry 
> > about what the user sees; consistency and accuracy are more important..
> 
> I like this idea, since it means my init scripts wouldn't have to dig 
> around looking for watchdog directories/files on various flavours of cPCI 
> CPU cards. :)

Yes, and on embedded SoC devices we have watchdog facilities sitting
on an internal chip bus.  It would be nice to find access points in
a uniform place on any Linux system.  i.e. PCI watchdog on my x86 desktop
is in the same place as the on-chip watchdog on my PPC44x system.

IMHO, anything else would be a logical step backwards from accessing
/dev/watchdog across platforms.

Regards,
-- 
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.
