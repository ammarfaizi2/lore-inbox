Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275025AbTHGCsE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 22:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275061AbTHGCsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 22:48:03 -0400
Received: from 206-158-102-129.prx.blacksburg.ntc-com.net ([206.158.102.129]:31720
	"EHLO wombat.ghz.cc") by vger.kernel.org with ESMTP id S275025AbTHGCsB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 22:48:01 -0400
Message-ID: <3F31BDA3.7040700@ghz.cc>
Date: Wed, 06 Aug 2003 22:46:59 -0400
From: Charles Lepple <clepple@ghz.cc>
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2: unable to suspend (APM)
References: <20030806231519.H16116@flint.arm.linux.org.uk>
In-Reply-To: <20030806231519.H16116@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

> I'm trying to test out APM on my laptop (in order to test some PCMCIA
> changes), but I'm hitting a brick wall.  I've added the device_suspend()
> calls for the SAVE_STATE, DISABLE and the corresponding device_resume()
> calls into apm's suspend() function.  (this is needed so that PCI
> devices receive their notifications.)

Are those calls required even if the corresponding driver is not 
compiled into the kernel? That is, would an unconfigured Yenta prevent 
the PCI bus from going to sleep?

> However, APM is refusing to suspend.  I'm seeing the following kernel
> messages:

Looks awfully familiar:

http://marc.theaimsgroup.com/?t=105949038200001&r=1&w=2

I saw a regression between 2.5.31 and 2.5.32, but couldn't pin the 
problem down any further. I haven't looked too far into the driver model 
power management code, but I don't think it's in apm.c.

Also saw your post about the 3c59x cardbus adapter. I can't recall ever 
being able to suspend the machine with that card inserted (including 
under 2.4-- I always had to eject the card before suspend or hibernate). 
Not sure if that's the exact model I have, but the name sounds similar.

-- 
Charles Lepple <ghz.cc!clepple>
http://www.ghz.cc/charles/

