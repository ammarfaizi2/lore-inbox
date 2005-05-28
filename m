Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262720AbVE1Mwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbVE1Mwr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 08:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262724AbVE1Mwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 08:52:47 -0400
Received: from c-24-91-86-110.hsd1.ma.comcast.net ([24.91.86.110]:1284 "EHLO
	linuxfarms.com") by vger.kernel.org with ESMTP id S262720AbVE1Mwo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 08:52:44 -0400
Date: Sat, 28 May 2005 08:55:32 -0400 (EDT)
From: Arthur Perry <kernel@linuxfarms.com>
To: Tyler Eaves <tyler@cg2.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE DMA with SATA, 2.6 kernels
In-Reply-To: <1117080313.4446.12.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0505280852170.19950@tiamat.linuxfarms.com>
References: <1117080313.4446.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 May 2005, Tyler Eaves wrote:

> My system is an Athlon64 3000+ running on a Via KT800 board. Distro is
> Ubuntu 5.04, running the Ubuntu AMD64-k8 2.6.11 kernel. However, I've
> seen this problem with several other distros and various kernels, so it
> seems to be a kernel issue.
>
> Disk Setup:
>
> /dev/sda is a 200GB Maxtor SATA drive containing /boot,/, and swap
> /dev/hda is a DVD-ROM/CD-RW driver (IDE)
> /dev/hdc is a 160GB Maxtor IDE drive containing ThatOtherOS(TM)
>
> The SATA drive works superbly, in UDMA133 mode. No complaints there.
> However, it appears that the generic IDE driver grabs the IDE drives
> before the Via driver can get them. This prevents me from using DMA on
> those drivers, so, for instance, ripping CDs is really painful. I can
> rip at about 2x on a good day, versus 40x+ ripping in Exact Audio Copy
> under XP.



Art Perry writes:
See the man page for the utility hdparm.
The VIA driver should know how to apply the UDA modes to the chipset, as 
long as the drives do also support the modes.
If the kernel did not auto configure the chipset to this mode, simply tell 
it to with the hdparm utility.
Hope this helps.



>
> You can find the relevant portion of my dmesg (and hdparm) at
> http://cg2.org/dmesg.txt
>
> Any assistance would be very much appreciated.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


Arthur Perry
Linux Systems/Software Architect, 7+ yrs
Tech Mktng Task Force
non-disclosed corporate association

Disclaimer:
"The contents of this email do not necessarily reflect
      the views of my non-disclosed corporate association" ;)

