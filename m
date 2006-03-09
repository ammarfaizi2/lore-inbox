Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751528AbWCIVHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbWCIVHj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 16:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbWCIVHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 16:07:39 -0500
Received: from a34-mta02.direcpc.com ([66.82.4.91]:36057 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S1751528AbWCIVHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 16:07:38 -0500
Date: Thu, 09 Mar 2006 16:06:47 -0500
From: Ben Collins <bcollins@ubuntu.com>
Subject: SMP on UP (Was Re: State of the Linux PCI and PCI Hotplug	Subsystems
 for	2.6.16-rc5)
In-reply-to: <1141937556.13319.64.camel@mindpipe>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1141938407.4406.4.camel@grayson>
Organization: Ubuntu
MIME-version: 1.0
X-Mailer: Evolution 2.5.92
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <20060306223545.GA20885@kroah.com>
 <20060308222652.GR4006@stusta.de> <20060308225029.GA26117@suse.de>
 <Pine.LNX.4.64.0603081502350.32577@g5.osdl.org>
 <20060308231851.GA26666@suse.de>
 <Pine.LNX.4.64.0603081528040.32577@g5.osdl.org> <20060309184010.GA4639@irc.pl>
 <Pine.LNX.4.64.0603091137180.18022@g5.osdl.org>
 <1141935002.6072.40.camel@grayson> <1141937556.13319.64.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 15:52 -0500, Lee Revell wrote:
> On Thu, 2006-03-09 at 15:10 -0500, Ben Collins wrote:
> > The difference between our 2.6.15 386 and 686 kernels is actually pretty
> > huge. The 386 is M486, and UP, while our 686 kernel is M686, and SMP.
> > The SMP is also complicated by our use of the SMP-alternatives patch,
> > but I believe I had this user test with this disabled (kernel command
> > line option that leaves all the SMP code intact for testing). It didn't
> > alter the problem. 
> 
> Ubuntu doesn't provide a UP 686 kernel?
> 
> Isn't there a performance hit running an SMP kernel on UP?

This is a little off-topic to the original thread, so trimming CC and
changing subject.

As mentioned above, we have the SMP-alternatives patch, which will
basically convert SMP related code (lock op's and some atomic
operations) to UP, on-the-fly (at boot for the kernel, and at load for
modules). It's not 100% the same as running a UP kernel, but it comes
close enough that it allows us to distribute fewer kernels. This equates
to less load on us and our users.

I don't want to start this whole thread over again, so check back in the
linux-kernel archives for the SMP alternatives patch thread.

-- 
Ubuntu     - http://www.ubuntu.com/
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
SwissDisk  - http://www.swissdisk.com/

