Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268527AbUJVXHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268527AbUJVXHe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 19:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268295AbUJVXEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 19:04:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:47519 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268278AbUJVXC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 19:02:56 -0400
Date: Fri, 22 Oct 2004 16:02:09 -0700
From: Greg KH <greg@kroah.com>
To: Ari Pollak <aripollak@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: udev doesn't add a device for one of my partitions under 2.6.9
Message-ID: <20041022230209.GA26748@kroah.com>
References: <clbgip$63d$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <clbgip$63d$1@sea.gmane.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 01:39:01PM -0400, Ari Pollak wrote:
> Hi,
> 
> I'm currently running kernel 2.6.9 with udev 0.034 and Debian's hotplug 
> 0.0.20040329-15. I'm assuming this is a device driver bug and not a udev 
> or hotplug bug because I'm pretty sure this worked fine in 2.6.8.1.
> My only hard drive on my IBM Thinkpad T41 has a primary partition, a 
> logical partition, and an extended partition (hda1, hda2, and hda5). 
> Both /dev/hda1 and /dev/hda2 show up as devices, but /dev/hda5 doesn't 
> show up at all. If I create the /dev/hda5 manually with mknod, accessing 
> it works fine. Below is the IDE-related output from dmesg on system 
> startup, the output from lspci, and my kernel config.

Does /sys/block/hda/ show partition the partition you are missing?  If
not, there's no way that udev could know to create it.

thanks,

greg k-h
