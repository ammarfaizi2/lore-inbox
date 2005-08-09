Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbVHIQOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbVHIQOb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 12:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbVHIQOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 12:14:31 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:20457 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964857AbVHIQO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 12:14:29 -0400
Subject: Re: Soft lockup in e100 driver ?
From: Steven Rostedt <rostedt@goodmis.org>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Jesper Juhl <jesper.juhl@gmail.com>
In-Reply-To: <20050809155504.GP22165@mea-ext.zmailer.org>
References: <20050809133647.GK22165@mea-ext.zmailer.org>
	 <9a87484905080906556d9f531c@mail.gmail.com>
	 <20050809143705.GM22165@mea-ext.zmailer.org>
	 <1123602100.18332.174.camel@localhost.localdomain>
	 <20050809155504.GP22165@mea-ext.zmailer.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 09 Aug 2005 12:14:05 -0400
Message-Id: <1123604045.18332.186.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-09 at 18:55 +0300, Matti Aarnio wrote:

> The fundamental thing is, IT LOCKS UP (for a while), when I do 
> "ifconfig eth0 down" and there is active traffic but the card DIES
> somehow.  Apparently it requires marginal/unreliable hardware to
> happen as well.  (Which for e100 is rather rare.)

This does look like a problem with the e100. I have a SMP machine and
another machine with a e100 card, but not the both together, and I'm not
about to start pulling cards.  Does this only happen in SMP or do you
also see this problem running a UP kernel (you only need to run a UP
kernel on SMP machine to get the same results)? I'm running debian but I
guess I could run the Fedora kernel to see if I can get the same
behavior.

> That is: at first the card dies, then I notice it, and do the ifconfig.
> Then things go _bad_, and recover.  Then I do 'rmmod e100', and
> restart network (which reloads the driver module), and things work
> once again.

So you have something locking up momentarily, then coming back to
normal?  After the rmmod of e100 and bringing back up the network, all
is in order?  Just confirming what you see.

> 
> Fedora kernel sources have this "softlockups" patch file: (size and date)
>    6159 May 12 04:50 linux-2.6.12-detect-softlockups.patch
> 
> That file I can upload, if you want.  Or send in email.
> Rest of the RPM-wrapper CPIO package I would prefer not to...

Did you add that patch yourself, or did it come with an update?  I was
just fiddling with rpms and I can use them too, with the rpm2cpio, it
works nice.  So if you can just point to a link then I'll download it
and try it out.  I found
http://download.fedora.redhat.com/pub/fedora/linux/core/updates/testing/4/i386/kernel-smp-2.6.12-1.1411_FC4.i686.rpm
but this is to 1411 and not to what you showed (1455).

-- Steve


