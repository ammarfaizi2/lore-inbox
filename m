Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264066AbTGKQJS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 12:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbTGKQJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 12:09:17 -0400
Received: from fed1mtao01.cox.net ([68.6.19.244]:29126 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S264066AbTGKQJI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 12:09:08 -0400
Date: Fri, 11 Jul 2003 09:23:45 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Message-ID: <20030711162345.GW17433@ip68-0-152-218.tc.ph.cox.net>
References: <20030711140219.GB16433@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030711140219.GB16433@suse.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 03:02:19PM +0100, Dave Jones wrote:

> Known gotchas.
> ~~~~~~~~~~~~~~
> Certain known bugs are being reported over and over. Here are the
> workarounds.
> - Blank screen after decompressing kernel?
>   Make sure your .config has
>   CONFIG_INPUT=y, CONFIG_VT=y, CONFIG_VGA_CONSOLE=y and CONFIG_VT_CONSOLE=y
>   A lot of people have discovered that taking their .config from 2.4 and
>   running make oldconfig to pick up new options leads to problems, notably
>   with CONFIG_VT not being set.

/boot/config-$(uname -r) will be looked at before arch/$(ARCH)/defconfig
potentially leading to some of the above (i.e. CONFIG_FB=y
CONFIG_FB_CONSOLE (or so) unset) if you don't look at every menu /
submenu in menuconfig / xconfig, and even more awkward results if cross
compiling for another arch.

-- 
Tom Rini
http://gate.crashing.org/~trini/
