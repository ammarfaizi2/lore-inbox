Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264175AbUD0Pfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264175AbUD0Pfv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 11:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264184AbUD0Pfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 11:35:50 -0400
Received: from mail.kroah.org ([65.200.24.183]:58778 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264175AbUD0Pfl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 11:35:41 -0400
Date: Mon, 26 Apr 2004 16:55:55 -0700
From: Greg KH <greg@kroah.com>
To: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Pcihpd-discuss] [RFC] New sysfs tree for hotplug
Message-ID: <20040426235555.GC24536@kroah.com>
References: <20040415170939.0ff62618.tokunaga.keiich@jp.fujitsu.com> <20040416223436.GB21701@kroah.com> <20040423211816.152dc326.tokunaga.keiich@jp.fujitsu.com> <20040423200751.GA7990@kroah.com> <20040426145808.4ed2a7b0.tokunaga.keiich@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040426145808.4ed2a7b0.tokunaga.keiich@jp.fujitsu.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2004 at 02:58:08PM +0900, Keiichiro Tokunaga wrote:
> 
> I think it depends on a hotplug driver that is invoked when writing to
> a "eject" file.  In the board case, a board hotplug driver (I'm making) 
> handles those CPUs, memory, and PCI slots on the board.  So my
> story for board hotplug is:
> 
>   - user checks/knows what resources are on the board (dependency)
>   - user writes to the "eject" file of the board properly (invocation)

Why not make a program that does all of this from userspace?  It would
turn off the proper CPUs, memory, and pci slots for a specific "board".
Otherwise you are going to have to either:
	- hook the current CPU, memory, and pci hotplug code to allow it
	  to be called from within the kernel
	- have your kernel code write to a the sysfs files from within
	  kernelspace.

Neither of which are acceptable things :(

thanks,

greg k-h
