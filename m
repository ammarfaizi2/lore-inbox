Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbVLXPJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbVLXPJp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 10:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbVLXPJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 10:09:45 -0500
Received: from mail.dvmed.net ([216.237.124.58]:26310 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750767AbVLXPJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 10:09:44 -0500
Message-ID: <43AD64AB.2070306@pobox.com>
Date: Sat, 24 Dec 2005 10:09:31 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: Linus Torvalds <torvalds@osdl.org>, Ayaz Abdulla <AAbdulla@nvidia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>
Subject: Re: [PATCH] forcedeth: fix random memory scribbling bug
References: <43AD4ADC.8050004@colorfullife.com>
In-Reply-To: <43AD4ADC.8050004@colorfullife.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Manfred Spraul wrote: > Two critical bugs were found in
	forcedeth 0.47: > - TSO doesn't work. > - pci_map_single() for the rx
	buffers is called with size==0. This bug > is critical, it causes
	random memory corruptions on systems with an iommu. > > Below is a
	minimal fix for both bugs, for inclusion into 2.6.15. > TSO will be
	fixed properly in the next version. > Tested on x86-64. > >
	Signed-Off-By: Manfred Spraul <manfred@colorfullife.com> [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> Two critical bugs were found in forcedeth 0.47:
> - TSO doesn't work.
> - pci_map_single() for the rx buffers is called with size==0. This bug 
> is critical, it causes random memory corruptions on systems with an iommu.
> 
> Below is a minimal fix for both bugs, for inclusion into 2.6.15.
> TSO will be fixed properly in the next version.
> Tested on x86-64.
> 
> Signed-Off-By: Manfred Spraul <manfred@colorfullife.com>

1) Why does forcedeth require a non-standard calculation for each 
pci_map_single() call?

2) I have requested multiple times that you avoid MIME...

3) Why disable TSO completely?  It sounds like it should default to off, 
then permit enabling via ethtool.

	Jeff



