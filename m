Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269176AbUHaVMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269176AbUHaVMw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 17:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269190AbUHaVKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 17:10:50 -0400
Received: from fmr12.intel.com ([134.134.136.15]:56013 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S269176AbUHaVJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 17:09:35 -0400
Message-ID: <4134E8EA.9080605@linux.intel.com>
Date: Tue, 31 Aug 2004 16:08:58 -0500
From: James Ketrenos <jketreno@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>
Subject: [Announce] Update on ipw2100, ipw2200, and support for Intel PRO/Wireless
 2915ABG
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It's been a while since I've updated lkml and netdev on the progress of
the ipw projects.  Given the recent announcement by Intel for the
introduction of Intel PRO/Wireless 2915 ABG Network Connection miniPCI
adapter, I thought now was a good time...

First, thanks to everyone that has been contributing, using, testing,
and reporting feedback for the projects described below.  The support
by folks in the community has been terrific -- the drivers wouldn't be
anywhere near as feature rich and stable as they are today if not for
the contributions of everyone.

The ipw2100 project (802.11b) has progressed very well.  We are in the
process of cleaning up the driver for submittal to netdev for eventual
inclusion into the kernel.  The driver currently supports wep, 802.1x,
monitor mode, adhoc, infrastructure, etc.  Suspend/resume isn't quite
functioning yet, but we'll get there soon.  This project is hosted at
http://ipw2100.sf.net.

The ipw2200 project (802.11bg), which was launched back in May, is
quickly catching up to the ipw2100 project in terms of functionality.
It currently supports wep and 802.1x in infrastructure mode.  Currently
it will only associate at B data rates; hooking in the G capabilities
is going on right now.  We'll then tackle adhoc and remaining feature
gaps.  We had been planning on holding off submittal for kernel
inclusion until we were feature complete.  However, several folks have
requested that we accelerate that plan and get it in sooner rather than
later.  To that end we're working to try and get it ready for submittal
along with the ipw2100 project.  This project is hosted at
http://ipw2200.sf.net.

The ipw2100 and ipw2200 projects currently share the 802.11 frame
handling stack for Tx/Rx and some management frame processing.  That
code has been pulled into its own module suite (ieee80211), based on
work from the Host AP project.  That code needs to be resync'd with the
Host AP code (and vice versa where appropriate) so that then all of
those drivers will be able to leverage a single wireless network stack.

Anyway, this brings me to announcing Linux support for the Intel
PRO/Wireless 2915 ABG Network Connection adapter.  As of next week, the
ipw2200 project will also begin supporting the ABG adapter.  From the
driver's perspective, the only change between the two cards is the
addition fo the A radio on the 2915.  So, adding support for the ABG is
just a matter of updating the firmware used by the ipw2200 project,
adding PCI id's, and putting in support for A.  That work will progress
as we continue to bring full support for the ipw2200 project.

At some point in the near future we will rename the ipw2200 project to
something more appropriate to identify it as supporting both the 2200
and 2915 adapters.

Thanks,
James
