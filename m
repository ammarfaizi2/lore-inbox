Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262482AbVBBX06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbVBBX06 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 18:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbVBBX0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 18:26:13 -0500
Received: from digitalimplant.org ([64.62.235.95]:34229 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S262961AbVBBXXn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 18:23:43 -0500
Date: Wed, 2 Feb 2005 15:23:30 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Pavel Roskin <proski@gnu.org>
cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>
Subject: Re: Please open sysfs symbols to proprietary modules
In-Reply-To: <Pine.LNX.4.62.0502021723280.5515@localhost.localdomain>
Message-ID: <Pine.LNX.4.50.0502021520200.1538-100000@monsoon.he.net>
References: <Pine.LNX.4.62.0502021723280.5515@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 2 Feb 2005, Pavel Roskin wrote:

> Hello!
>
> I'm writing a module under a proprietary license.  I decided to use sysfs
> to do the configuration.  Unfortunately, all sysfs exports are available
> to GPL modules only because they are exported by EXPORT_SYMBOL_GPL.
>
> I have found the original e-mail where this change was proposed:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0409.3/0345.html
>
> Patrick writes:
>
> "The users of these functions are all, in most cases, other subsystems,
> which provide a layer of abstraction for the downstream users (drivers,
> etc)."
>
> Maybe it was true in September 2004, but it's not true in February 2005.
> sysfs has become a standard way to make configurable parameters available
> to userspace, just like sysctl and ioctl.
>
> All I want to do is to have a module that would create subdirectories for
> some network interfaces under /sys/class/net/*/, which would contain
> additional parameters for those interfaces.  I'm not creating a new
> subsystem or anything like that.  sysctl is not good because the data is
> interface specific.  ioctl on a socket would be OK, although it wouldn't
> be easily scriptable.  The restriction on sysfs symbols would just force
> me to write a proprietary userspace utility to set those parameters
> instead of using a shell script.
>
> My understanding is that EXPORT_SYMBOL_GPL is only useful for symbols so
> specific to the kernel that the modules that use them would be effectively
> based on GPL code.  But a module providing its internal state to the
> userspace doesn't need to be based on the kernel code in any way.
>
> Please replace every EXPORT_SYMBOL_GPL with EXPORT_SYMBOL in fs/sysfs/*.c

No, thanks. Nothing has changed dramatically enough in 5 months to
necessitate this change, and it's certainly not going to happen for a
single binary driver.

What is wrong with creating a (GPL'd) abstraction layer that exports
symbols to the proprietary modules?

Thanks,


	Pat

