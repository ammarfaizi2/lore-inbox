Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261775AbVGUP4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbVGUP4z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 11:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbVGUP4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 11:56:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52109 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261775AbVGUP4z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 11:56:55 -0400
Date: Fri, 22 Jul 2005 01:56:13 +1000
From: Andrew Morton <akpm@osdl.org>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm1 - breaks DRI
Message-Id: <20050722015613.67a32450.akpm@osdl.org>
In-Reply-To: <200507210737.41539.tomlins@cam.org>
References: <20050715013653.36006990.akpm@osdl.org>
	<200507210737.41539.tomlins@cam.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson <tomlins@cam.org> wrote:
>
>> ----------  Forwarded Message  ----------
>> 
>> Subject: Re: Xorg and RADEON (dri disabled)
>> Date: Wednesday 20 July 2005 21:25
>> From: Ed Tomlinson <tomlins@cam.org>
>> To: debian-amd64@lists.debian.org
>> Cc: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
>> 
>> On Wednesday 20 July 2005 21:13, Michal Schmidt wrote:
>> > Ed Tomlinson wrote:
>> > > Hi,
>> > > 
>> > > With Xorg I get:
>> > > 
>> > > (==) RADEON(0): Write-combining range (0xd0000000,0x8000000)
>> > > drmOpenDevice: node name is /dev/dri/card0
>> > > drmOpenDevice: open result is -1, (No such device)
>> > > drmOpenDevice: open result is -1, (No such device)
>> > > drmOpenDevice: Open failed
>> > > drmOpenDevice: node name is /dev/dri/card0
>> > > drmOpenDevice: open result is -1, (No such device)
>> > > drmOpenDevice: open result is -1, (No such device)
>> > > drmOpenDevice: Open failed
>> > > drmOpenByBusid: Searching for BusID pci:0000:01:00.0
>> > > drmOpenDevice: node name is /dev/dri/card0
>> > > drmOpenDevice: open result is 7, (OK)
>> > > drmOpenByBusid: drmOpenMinor returns 7
>> > > drmOpenByBusid: drmGetBusid reports pci:0000:01:00.0
>> > > (II) RADEON(0): [drm] loaded kernel module for "radeon" driver
>> > > (II) RADEON(0): [drm] DRM interface version 1.2
>> > > (II) RADEON(0): [drm] created "radeon" driver at busid "pci:0000:01:00.0"
>> > > (II) RADEON(0): [drm] added 8192 byte SAREA at 0xffffc20000411000
>> > > (II) RADEON(0): [drm] drmMap failed
>> > > (EE) RADEON(0): [dri] DRIScreenInit failed.  Disabling DRI.
>> > > 
>> > > And glxgears reports 300 frames per second.  How do I get dri back?  It
>> > > was working fine with XFree.  The XF86Config-4 was changed by the upgrade
>> > > dropping some parms in the Device section.  Restoring them has no effect
>> > > on the problem.
>> 
>> > What kernel do you use? I get the same behaviour with 2.6.13-rc3-mm1, 
>> > but it works with 2.6.13-rc3.
>> 
>> I also use 2.6.13-rc3-mm1.  Will try with a previous version an report to lkml if
>> it works.
>> 
>
> I just tried 13-rc2-mm1 and dri is working again. Its reported to also work
> with 13-rc3.

Useful info, thanks.

>  What in mm1 is apt to be breaking dri?

Faulty kernel programming ;)

I assume that the failure to open /dev/dri/card0 only happens in rc3-mm1?

Could you compare the dmesg output for 2.6.13-rc3 versus 2.6.13-rc3-mm1? 
And double-check the .config settings: occasionally config options will be
renamed and `make oldconfig' causes things to get acidentally disabled.
