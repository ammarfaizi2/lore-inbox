Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267358AbUHJAKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267358AbUHJAKg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 20:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267359AbUHJAKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 20:10:36 -0400
Received: from mail.kroah.org ([69.55.234.183]:37816 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267358AbUHJAKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 20:10:33 -0400
Date: Mon, 9 Aug 2004 17:10:16 -0700
From: Greg KH <greg@kroah.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] hotplug resource limitation
Message-ID: <20040810001016.GC7131@kroah.com>
References: <41177703.5070202@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41177703.5070202@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 03:07:15PM +0200, Hannes Reinecke wrote:
> Hi all,
> this is the second patch to implement hotplug resource limitation 
> (relative to 2.6.7-rc2-mm2).
> 
> In some cases it is preferrable to adapt the number of concurrent 
> hotplug processes on the fly in addition to set the number statically 
> during boot.

Why?  This should be "auto-tuning".  We don't want to provide
yet-another-knob-for-people-to-tweak-from-userspace, right?

> Additionally, it might be required to disable hotplug / 
> kmod event delivery altogether for debugging purposes (e.g. if a module 
> loaded automatically is crashing the machine).

Ugh, that's just not a good thing at all.  You can do that by running:
	echo /bin/true > /proc/sys/kernel/hotplug
today if you have to.  I don't like the ability to stop the kernel from
running properly, like this patch allows you to.

thanks,

greg k-h
