Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263162AbUCMSoS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 13:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbUCMSoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 13:44:18 -0500
Received: from [80.72.36.106] ([80.72.36.106]:45789 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S263162AbUCMSoQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 13:44:16 -0500
Date: Sat, 13 Mar 2004 19:44:11 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Marek Szuba <scriptkiddie@wp.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4, or what I still don't quite like about the new stable
 branch
In-Reply-To: <S263158AbUCMS0h/20040313182637Z+893@vger.kernel.org>
Message-ID: <Pine.LNX.4.58.0403131932510.22707@alpha.polcom.net>
References: <S263158AbUCMS0h/20040313182637Z+893@vger.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 4. Module autounloading. Is it actually possible? Will it be possible?
> If not, why? The old method of periodically invoking "modprobe -ras" via
> cron doesn't seem to accomplish anything and I really liked the idea of
> keeping only the required modules in memory at any given moment without
> having to log in as root to unload the unneeded ones - after all, if the
> autoloader can only add them what's the point of not going the
> monolithic way? The docs on the new approach towards modules are
> virtually nonexistent in the kernel source package and while I suppose I
> could simply write a script which would scan the list of
> currently-loaded modules for the unused ones and remove them one by one,
> but this approach feels terribly crude comparing with the elegance of
> the old solution. I use module-init-tools-3.0, a serious improvement
> over 0.9.15 if I may say so but, unless I'm thinking about it with
> completely wrong base assumptions, still far from perfect.

As far as I know, the new preffered way of handling modules, is to load 
them when device is detected (hotplug and udev, at boot or later) 
and (optionally) remove when device is removed, not as in older kernels, 
when module was added or removed depending on its use. This way (as 
opposed to monolithic kernel) you can have "generic" kernel by placing 
everything in modules. And what is the point in unloading not currently 
needed modules? They should not use much resources when not needed...
And if you want to put your system to sleep, you must put to sleep all 
devices (in the right order) *including* these not currently used but 
present in the system. If you will not do this, you can probably get big 
crash. So you need loaded module, that knows how to put device to sleep.


Grzegorz Kulewski

