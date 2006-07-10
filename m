Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422765AbWGJSqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422765AbWGJSqh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 14:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422763AbWGJSqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 14:46:37 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:51920
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1422762AbWGJSqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 14:46:36 -0400
Date: Mon, 10 Jul 2006 11:47:17 -0700 (PDT)
Message-Id: <20060710.114717.44959528.davem@davemloft.net>
To: auke-jan.h.kok@intel.com
Cc: jgarzik@pobox.com, pavel@ucw.cz, yi.zhu@intel.com,
       jketreno@linux.intel.com, netdev@vger.kernel.org,
       linville@tuxdriver.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] do not allow IPW_2100=Y or IPW_2200=Y
From: David Miller <davem@davemloft.net>
In-Reply-To: <44B29C8A.8090405@intel.com>
References: <20060710152032.GA8540@elf.ucw.cz>
	<44B2940A.2080102@pobox.com>
	<44B29C8A.8090405@intel.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Auke Kok <auke-jan.h.kok@intel.com>
Date: Mon, 10 Jul 2006 11:29:30 -0700

> Jeff Garzik wrote:
> > Pavel Machek wrote:
> >> Kconfig currently allows compiling IPW_2100 and IPW_2200 into kernel
> >> (not as a module). Unfortunately, such configuration does not work,
> >> because these drivers need a firmware, and it can't be loaded by
> >> userspace loader when userspace is not running.
> > 
> > False, initramfs...
> 
> which would warrant some extra documentation in Kconfig explaining that this 
> driver needs initramfs with firmware for it to work when compiled in the 
> kernel. A link to the ipw2x00 documentation might also help.

Besides, the initramfs runs long after the driver init routine
runs which is when the firmware needs to be available.
