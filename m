Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262573AbUKQW2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbUKQW2O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 17:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262587AbUKQWZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 17:25:17 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:34791 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262579AbUKQWYA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 17:24:00 -0500
Date: Wed, 17 Nov 2004 14:23:40 -0800
From: Greg KH <greg@kroah.com>
To: Colin Leroy <colin@colino.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hotplug_path no longer exported
Message-ID: <20041117222340.GA4494@kroah.com>
References: <20041117203139.7c9f5e95.colin@colino.net> <20041117214824.GA1291@kroah.com> <20041117231253.1ec92e6f.colin@colino.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041117231253.1ec92e6f.colin@colino.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 11:12:53PM +0100, Colin Leroy wrote:
> 
> Dunno. This driver has a reputation of being the worse wlan driver for
> prism2 chipsets out there, but it's the only one supporting USB devices.

Hm, I've heard that rumor before too.  If only someone would get me such
a usb device, maybe that problem could be fixed :)

> With p80211_run_sbin_hotplug doing stuff to call /sbin/hotplug... 
> The one that will write a correct patch to linux-wlan-ng will have to
> figure out the different events they use: "register" (instead of "add"),
> "startup", "shutdown", "resume", "suspend"...

Ick, ick, ick.  It's about time we force them to play nice with the rest
of the kernel and userspace :)

Anyway, the proper fix is to use kobject_hotplug().  They will have to
change their code.  Just one of the many joys of trying to keep a driver
outside of the main kernel tree...

thanks,

greg k-h
