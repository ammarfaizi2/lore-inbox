Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265839AbUBBWoX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 17:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265843AbUBBWoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 17:44:23 -0500
Received: from mail.kroah.org ([65.200.24.183]:42693 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265839AbUBBWoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 17:44:22 -0500
Date: Mon, 2 Feb 2004 14:44:19 -0800
From: Greg KH <greg@kroah.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: udev depends on /usr
Message-ID: <20040202224419.GA1158@kroah.com>
References: <20040126215036.GA6906@kroah.com> <20040202223221.GC2748@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202223221.GC2748@werewolf.able.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 02, 2004 at 11:32:21PM +0100, J.A. Magallon wrote:
> 
> On 2004.01.26, Greg KH wrote:
> > I've released the 015 version of udev.  It can be found at:
> >  	kernel.org/pub/linux/utils/kernel/hotplug/udev-015.tar.gz
> > 
> 
> Little problem ;)
> I have some modules in /etc/modprobe.preload. Subject of this mail is
> ide-cd.
> 
> When ide-cd gets loaded, the kernel/udev chain calls
> /etc/udev/scripts/ide-devfs.sh, wich uses 'expr'. I my system
> (Mandrake 10) and on a RedHat 9 'expr' lives in /usr/bin, and /usr can
> be still unmounted when rc.modules is called...
> 
> Solution ? Change udev, change coreutils locations...

How about, don't rely on ide-devfs.sh as you are trying valiantly to
hold on to a dieing naming scheme that is not LSB compliant?  :)

Seriously, I don't know.

thanks,

greg k-h
