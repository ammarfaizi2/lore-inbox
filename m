Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261796AbUKPUhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbUKPUhx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 15:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbUKPUf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 15:35:57 -0500
Received: from outbound04.telus.net ([199.185.220.223]:11718 "EHLO
	priv-edtnes51.telusplanet.net") by vger.kernel.org with ESMTP
	id S261778AbUKPUSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 15:18:47 -0500
Subject: Re: Boot failure, 2.6.10-rc2
From: Bob Gill <gillb4@telusplanet.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0411162025180.24131@yvahk01.tjqt.qr>
References: <1100632116.4388.9.camel@localhost.localdomain>
	 <Pine.LNX.4.53.0411162025180.24131@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Tue, 16 Nov 2004 13:19:05 -0700
Message-Id: <1100636345.4388.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-16 at 20:36 +0100, Jan Engelhardt wrote:
> >Hi.  When booting 2.6.10-rc2, I get
> >Warning: unable to open an initial console
> >(and the boot process then stalls).
> >
> >My system has the following already configured:
> >crw-------  1 bob root 5, 1 Nov 16 10:10 /dev/console
> 
> Are you sure /dev/console exists when the kernel boots?
> (It is thy duty to ask this...)
> 
> I wonder, because there is no configurator (menuconfig) option to en-/disable
> the driver for /dev/console -- it's *always* in. In 2.6.8, and I have not seen
> any changes to drivers/char/tty_io.c:tty_init() - where it is added - in
> further kernels yet.
> 
> >My kernel configuration includes the following:
> >CONFIG_UNIX98_PTYS=y
> >CONFIG_LEGACY_PTYS=y
> >CONFIG_LEGACY_PTY_COUNT=256

> But to be on the safe side, enable:
> 
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> 
OK, another part of my standard build script (which is now failing to
boot) includes:
#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_COMPUTONE is not set
...
> As I read from kernel/printk.c, the console= parameter seems to set up a
> -serial line-, also see Documentation/serial-console.txt and
> kernel-parameters.txt.
> 

> How, after all, did you run into this error? Directly after upgrading (if
> applicable)?
No, the standard (old) kernel that comes with Fedora Core 3 is working
ok, but I prefer to run my own custom kernels.  The official Fedora line
is that it's wrong to build your own kernel, and you are silly for
wanting to do so, but I like to build/run them anyway.
> 
> 
> Jan Engelhardt

Thanks for your reply though.  Your question as to whether /dev/console
exists at boot time is making me question whether /dev/console exists at
boot time.
-- 
Bob Gill <gillb4@telusplanet.net>

