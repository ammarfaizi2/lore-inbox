Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265837AbUBBWcZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 17:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265863AbUBBWcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 17:32:25 -0500
Received: from smtp06.auna.com ([62.81.186.16]:46830 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S265837AbUBBWcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 17:32:23 -0500
Date: Mon, 2 Feb 2004 23:32:21 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: udev depends on /usr
Message-ID: <20040202223221.GC2748@werewolf.able.es>
References: <20040126215036.GA6906@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040126215036.GA6906@kroah.com> (from greg@kroah.com on Mon, Jan 26, 2004 at 22:50:36 +0100)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.01.26, Greg KH wrote:
> I've released the 015 version of udev.  It can be found at:
>  	kernel.org/pub/linux/utils/kernel/hotplug/udev-015.tar.gz
> 

Little problem ;)
I have some modules in /etc/modprobe.preload. Subject of this mail is
ide-cd.

When ide-cd gets loaded, the kernel/udev chain calls
/etc/udev/scripts/ide-devfs.sh, wich uses 'expr'. I my system
(Mandrake 10) and on a RedHat 9 'expr' lives in /usr/bin, and /usr can
be still unmounted when rc.modules is called...

Solution ? Change udev, change coreutils locations...
Standarisation of what is avaliable from coreutils before /usr ?

TIA

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.6.2-rc2-jam2 (gcc 3.3.2 (Mandrake Linux 10.0 3.3.2-4mdk))
