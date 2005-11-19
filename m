Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbVKSFwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbVKSFwb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 00:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbVKSFwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 00:52:31 -0500
Received: from mail.kroah.org ([69.55.234.183]:30888 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750930AbVKSFwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 00:52:30 -0500
Date: Fri, 18 Nov 2005 21:37:01 -0800
From: Greg KH <greg@kroah.com>
To: yiding_wang@agilent.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: question about driver built-in kernel
Message-ID: <20051119053701.GA31259@kroah.com>
References: <08A354A3A9CCA24F9EE9BE13600CFBC5032F842D@wcosmb07.cos.agilent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08A354A3A9CCA24F9EE9BE13600CFBC5032F842D@wcosmb07.cos.agilent.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 06:57:38PM -0700, yiding_wang@agilent.com wrote:
> Thanks Greg! 
> 
> Got everything straighten up.
>  
> 1, replaced init_module() by __init init_module to avoid kernel build conflict.
> 2, arranged correct sequence in Makefile to load two drivers in proper order.
> 
> Now it looks the pci bus register accessing has problem. If loaded as
> module, everything works fine. If build in kernel, it always failed at
> the spot driver resetting the chip through register during the kernel
> loading. It seems the pci base address mapping or something related
> has problem. Is there any difference for ioremap call between the
> kernel loading and after system is up? Is anything special on pci
> device register accessing during the kernel booting, compare with
> after system boot up?

Do you have a pointer to your source code, so we can look at it to see
what is wrong?

thanks,

greg k-h
