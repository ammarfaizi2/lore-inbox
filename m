Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266724AbUGVLcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266724AbUGVLcS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 07:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266772AbUGVLcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 07:32:18 -0400
Received: from tri-e2k.ethz.ch ([129.132.112.23]:25056 "EHLO tri-e2k.ethz.ch")
	by vger.kernel.org with ESMTP id S266724AbUGVLcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 07:32:16 -0400
Message-ID: <40FFA5BD.5000304@pixelized.ch>
Date: Thu, 22 Jul 2004 13:32:13 +0200
From: "Giacomo A. Catenazzi" <cate@pixelized.ch>
User-Agent: Mozilla Thunderbird 0.7 (Windows/20040616)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@fs.tum.de>,
       corbet@lwn.net, bgerst@didntduck.org, linux-kernel@vger.kernel.org
Subject: Re: New dev model (was [PATCH] delete devfs)
References: <40FEEEBC.7080104@quark.didntduck.org> <20040721231123.13423.qmail@lwn.net> <20040721235228.GZ14733@fs.tum.de> <20040722025539.5d35c4cb.akpm@osdl.org> <20040722070453.GA21907@kroah.com>
In-Reply-To: <20040722070453.GA21907@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jul 2004 11:32:14.0745 (UTC) FILETIME=[89706090:01C46FDF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Greg KH wrote:

> On Thu, Jul 22, 2004 at 02:55:39AM -0700, Andrew Morton wrote:
> 
> Users have had the 6-12 month warning about devfs for a while now :)
> And udev is currently available in the latest distro versions of:
> 	- Red Hat
> 	- SuSE
> 	- Gentoo
> 	- Debian
> 	- Mandrake
> 
> While devfs is only supported in Gentoo at this time (and udev fills
> that support issue for those users.)

I've still some bug report of people using home-compiled devfs kernels
on Debian. So people still use it. You say "devfs" is buggy, but
it works on nearly all cases, so people tend not to switch.

The worse is the lack of stable name of devices, in udev too.
I.e. microcode loader (Intel CPU) needs a device, which was so
named (last time I controlled):
   # device name in LANANA / devices.txt
   DEVICE=/dev/cpu/microcode
   # device name in devfsd
   DEVICE2=/dev/misc/microcode
   # device name in udev
   DEVICE3=/dev/microcode

If we a coherent *default* device name scheme, the switching
from a kernel utility to other would be trivial.

ciao
	cate

Note: /dev/cpu/microcode was also created by devfs until
recent 2.4 kernels and the whole 2.6 serie.



> 
> 
>>That being said, mid-2005 would be an appropriate time to remove devfs.  If
>>that schedule pushes things along faster than they would otherwise have
>>progressed, well, good.
> 
> 
> Ok, if people think that would really change anything, I'll wait a year.
> I'm patient :)

