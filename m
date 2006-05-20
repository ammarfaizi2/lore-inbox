Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbWETQ1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWETQ1f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 12:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWETQ1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 12:27:34 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:6157 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751411AbWETQ1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 12:27:34 -0400
Date: Sat, 20 May 2006 18:25:29 +0200
From: Willy Tarreau <willy@w.ods.org>
To: George Nychis <gnychis@cmu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cannot load *any* modules with 2.4 kernel
Message-ID: <20060520162529.GT11191@w.ods.org>
References: <446F3F6A.9060004@cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <446F3F6A.9060004@cmu.edu>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, May 20, 2006 at 12:10:18PM -0400, George Nychis wrote:
> Hi,
> 
> I boot two kernels, a 2.6.9 kernel and just recently built a 2.4.32 kernel
> 
> In the 2.4.32 kernel I have =y for:
> CONFIG_MODULES
> CONFIG_MODVERSIONS
> CONFIG_KMOD
> 
> I then build my kernel, with some modules, install the modules, and boot
> my 2.4.32 kernel successfully
> 
> when i do lsmod, it is completely empty, no modules are loaded.  This
> only happens for my 2.4.32 kernel though, modules load fine in 2.6.9

What's your modutils version ?  -> lsmod -V
You must use modutils and not modules-utils under 2.4, and I suspect
that if you jumped back from 2.6 to 2.4, you might not have the right
package. Note that modules-utils contains a wrapper to call the right
modutils when you are running 2.4, so you should really do lsmod -V
when running 2.4.

> If i try to manually insert with insmod or modprobe, i get unresolved
> external symbols for things that I am sure should be resolved... for
> example, i get unresolved external symbol for printk
> 
> I'll give some other common unresolved smybols and maybe someone can
> point me in the right direction of what else i need to specify to you
> guys so that you can help me out further.
> 
> prinkt
> add_timer
> dev_mc_add
> CardServices
> kfree
> cpu_raise_softirq
> free_irq
> kmalloc
> 
> Thanks!
> George

Regards,
Willy

