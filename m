Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279704AbRJYER0>; Thu, 25 Oct 2001 00:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279706AbRJYERD>; Thu, 25 Oct 2001 00:17:03 -0400
Received: from smtp1.ndsu.NoDak.edu ([134.129.111.146]:30980 "EHLO
	smtp1.ndsu.nodak.edu") by vger.kernel.org with ESMTP
	id <S279704AbRJYEQ6>; Thu, 25 Oct 2001 00:16:58 -0400
Message-ID: <3BD791C6.70200@ndsu.nodak.edu>
Date: Wed, 24 Oct 2001 23:15:02 -0500
From: Reid Hekman <reid.hekman@ndsu.nodak.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011018
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Dan Maas <dmaas@dcine.com>, jamagallon@able.es
Subject: Re: 2.4.13-pre6 breaks Nvidia's kernel module
In-Reply-To: <fa.fm7f5dv.1cn8eg6@ifi.uio.no> <fa.hbvlhav.v369au@ifi.uio.no> <023001c15cf4$4fd5ecc0$1a01a8c0@allyourbase>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Maas wrote:

>>As I see it, that is exactly what should not be done. Lets suppose you are
>>running 2.4.12. You want to upgrade. So you unpack 2.4.13 and build it.
>>If you go now to build nVidia drivers, with the shipped Makefile they
>>still build and install against 2.4.12.
>>
> 
> You don't have to reboot into the new kernel, just do as the README says:
> 
>     If you want to build NVdriver for a system other than the compiling
>     system, then you'll need to run the make as:
> 
>         $ make SYSINCLUDE=/src/kern/my-smp-kernel/include
> 
>     to generate an NVdriver that will work on the kernel whose include
>     files are in /src/kern/my-smp-kernel/include.  This kernel must
>     have been completely configured (make menuconfig dep).
> 
> So you still only need to reboot once when upgrading your kernel.
> 
> The only thing I find annoying is that the kernel's 'make modules_install'
> wipes out /lib/modules/<version>, so when I'm in the compile/debug cycle on
> my own driver I have to keep reinstalling NVdriver.
> 
> Regards,
> Dan


Thanks for the info. I hadn't looked at the makefile myself, but now 
that you mention it do remember the SYSINCLUDE directive from before.

For me personally, I've always booted in runlevel 3, so it's no problem 
for me to recompile NVdriver after the reboot. To each his own I guess.

Regards,
Reid

