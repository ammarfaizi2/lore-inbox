Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265259AbUBBXBI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 18:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265271AbUBBXBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 18:01:08 -0500
Received: from smtp09.auna.com ([62.81.186.19]:55481 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S265259AbUBBXBF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 18:01:05 -0500
Date: Tue, 3 Feb 2004 00:01:04 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Greg KH <greg@kroah.com>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: udev depends on /usr
Message-ID: <20040202230104.GA8686@werewolf.able.es>
References: <20040126215036.GA6906@kroah.com> <20040202223221.GC2748@werewolf.able.es> <20040202224419.GA1158@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040202224419.GA1158@kroah.com> (from greg@kroah.com on Mon, Feb 02, 2004 at 23:44:19 +0100)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.02.02, Greg KH wrote:
> On Mon, Feb 02, 2004 at 11:32:21PM +0100, J.A. Magallon wrote:
> > 
> > On 2004.01.26, Greg KH wrote:
> > > I've released the 015 version of udev.  It can be found at:
> > >  	kernel.org/pub/linux/utils/kernel/hotplug/udev-015.tar.gz
> > > 
> > 
> > Little problem ;)
> > I have some modules in /etc/modprobe.preload. Subject of this mail is
> > ide-cd.
> > 
> > When ide-cd gets loaded, the kernel/udev chain calls
> > /etc/udev/scripts/ide-devfs.sh, wich uses 'expr'. I my system
> > (Mandrake 10) and on a RedHat 9 'expr' lives in /usr/bin, and /usr can
> > be still unmounted when rc.modules is called...
> > 
> > Solution ? Change udev, change coreutils locations...
> 
> How about, don't rely on ide-devfs.sh as you are trying valiantly to
> hold on to a dieing naming scheme that is not LSB compliant?  :)
> 

Thaks. I don't even have devfs support in my kernel...

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.6.2-rc2-jam2 (gcc 3.3.2 (Mandrake Linux 10.0 3.3.2-4mdk))
