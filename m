Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264830AbUD2Uxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264830AbUD2Uxx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 16:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264850AbUD2Uu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 16:50:59 -0400
Received: from modemcable166.48-200-24.mc.videotron.ca ([24.200.48.166]:33225
	"EHLO xanadu.home") by vger.kernel.org with ESMTP id S264830AbUD2Utq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 16:49:46 -0400
Date: Thu, 29 Apr 2004 16:49:45 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Tim Bird <tim.bird@am.sony.com>
cc: linux kernel <linux-kernel@vger.kernel.org>,
       <linux-arm-kernel@lists.arm.linux.org.uk>, <linux-mips@linux-mips.org>,
       <linux-sh-ctl@m17n.org>,
       CE Linux Developers List <celinux-dev@tree.celinuxforum.org>
Subject: Re: CONFIG_XIP_ROM vs. CONFIG_XIP_KERNEL
In-Reply-To: <40915265.2050906@am.sony.com>
Message-ID: <Pine.LNX.4.44.0404291644170.30657-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2004, Tim Bird wrote:

> I'm looking at some sources for kernel Execute-in-place (XIP).
> 
> I see references to CONFIG_XIP_ROM and CONFIG_XIP_KERNEL,
> in different architecture branches of the same kernel
> source tree.
> 
> Is this difference merely the result of inconsistent
> usage, or is there a functional difference between
> these two options?

It's the result of me deciding CONFIG_XIP_ROM wasn't totally appropriate ...  

> I can imagine that CONFIG_XIP_ROM is intended only to
> handle XIP in ROM, and that CONFIG_XIP_KERNEL possibly
> handles additional cases like XIP in flash.  However,
> before jumping to that conclusion I thought I would
> ask if there is some intention behind the different
> config names.

... so I renamed it to CONFIG_XIP_KERNEL.  Especially since there is also 
XIPable user space which also can be stored in ROM (or flash).  So please 
disregard CONFIG_XIP_ROM and use CONFIG_XIP_KERNEL.  Whether ROM or Flash is 
used is rather irrelevant to the code this option is linked to.


Nicolas

