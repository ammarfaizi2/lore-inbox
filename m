Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262731AbUKESGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbUKESGr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 13:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262733AbUKESGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 13:06:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:59357 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262731AbUKESGg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 13:06:36 -0500
Date: Fri, 5 Nov 2004 10:05:13 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Kay Sievers <kay.sievers@vrfy.org>,
       rml@novell.com, linux-kernel@vger.kernel.org, len.brown@intel.com,
       acpi-devel@lists.sourceforge.net
Subject: Re: 2.6.10-rc1-mm3: ACPI problem due to un-exported hotplug_path
Message-ID: <20041105180513.GA32007@kroah.com>
References: <20041105001328.3ba97e08.akpm@osdl.org> <20041105164523.GC1295@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041105164523.GC1295@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 05:45:23PM +0100, Adrian Bunk wrote:
> The following error (compin from Linus' tree) is caused by the fact that 
> hotplug_path is no longer EXPORT_SYMBOL'ed:
> 
> 
> <--  snip  -->
> 
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.10-rc1-mm3; fi
> WARNING: /lib/modules/2.6.10-rc1-mm3/kernel/drivers/acpi/container.ko needs unknown symbol hotplug_path
> 
> <--  snip  -->

Hm, must be an -mm specific change that is causing this.  I don't see
this in the current tree.

Len, why would any ACPI code be wanting to get access to hotplug_path
directly?

thanks,

greg k-h
