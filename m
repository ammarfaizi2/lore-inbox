Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWBQWYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWBQWYk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 17:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWBQWYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 17:24:40 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:64467
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751027AbWBQWYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 17:24:39 -0500
Date: Fri, 17 Feb 2006 14:24:30 -0800
From: Greg KH <gregkh@suse.de>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Yasunori Goto <y-goto@jp.fujitsu.com>,
       lhms <lhms-devel@lists.sourceforge.net>
Subject: Re: [PATCH] change memoryX->phys_device from number to symlink [1/2] generic func
Message-ID: <20060217222430.GA14847@suse.de>
References: <43F570B1.7050302@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F570B1.7050302@jp.fujitsu.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 03:44:01PM +0900, KAMEZAWA Hiroyuki wrote:
> This patch is from memory hotplug tree in lhms.
> This patch changes memory_device's phys_device member from just a number
> to symbolic link to the device. AFAIK, phys_device is not used now.
> 
> example)
> $readlink /sys/devices/system/memory/memory10/phys_device
> ../../../../firmware/acpi/namespace/ACPI/_SB/LSB1/MEM3
> 
> This will help memory hotplug shell script.

You should bring this up on the acpi mailing list, as I know Pat Mochel
has redone the whole "acpi in sysfs" thing, so this patch will break
those patches (or his will break yours.)

I suggest you discuss this with him.

good luck,

greg k-h
