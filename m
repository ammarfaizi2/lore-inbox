Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267753AbUG3R1C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267753AbUG3R1C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 13:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267759AbUG3R1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 13:27:02 -0400
Received: from omx2-ext.SGI.COM ([192.48.171.19]:62425 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267762AbUG3R0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 13:26:53 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Exposing ROM's though sysfs
Date: Fri, 30 Jul 2004 10:19:02 -0700
User-Agent: KMail/1.6.2
Cc: lkml <linux-kernel@vger.kernel.org>
References: <20040730165339.76945.qmail@web14929.mail.yahoo.com> <200407301010.29807.jbarnes@engr.sgi.com>
In-Reply-To: <200407301010.29807.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407301019.02267.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, July 30, 2004 10:10 am, Jesse Barnes wrote:
> On Friday, July 30, 2004 9:53 am, Jon Smirl wrote:
> > We talked at OLS about exposing adapter ROMs via sysfs. I have some
> > time to work on this but I'm not sure about the right places to hook
> > into the kernel.
>
> How about this patch?

Ok, so it's a little broken, but the idea is to expose the rom as a file 
in /sys/devices/pciDDDD:BB/DDDD:BB:SS:F/rom just like config space.

I think I need to use pci_config_write_byte to enable option ROM address 
decoding, but even then I'm taking a machine check on my test machine, so I'm 
obviously doing something else wrong too.

Jesse
