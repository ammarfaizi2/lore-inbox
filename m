Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267459AbTACIPk>; Fri, 3 Jan 2003 03:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267463AbTACIPk>; Fri, 3 Jan 2003 03:15:40 -0500
Received: from dp.samba.org ([66.70.73.150]:2768 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267459AbTACIPj>;
	Fri, 3 Jan 2003 03:15:39 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Wang, Stanley" <stanley.wang@intel.com>
Cc: "Zhuang, Louis" <louis.zhuang@intel.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: Kernel module version support. 
In-reply-to: Your message of "Fri, 03 Jan 2003 14:47:23 +0800."
             <957BD1C2BF3CD411B6C500A0C944CA2601F11711@pdsmsx32.pd.intel.com> 
Date: Fri, 03 Jan 2003 19:14:12 +1100
Message-Id: <20030103082410.8063E2C25B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <957BD1C2BF3CD411B6C500A0C944CA2601F11711@pdsmsx32.pd.intel.com> you
 write:
> Hi, Rusty

> There is a example that could explain why I want the module structure's
> pointer.

> If we want to place kernel probes on all PIO instrcutions of a
> device driver for debuging purpose, only knowing symbol's address is
> not enough. We need the base address of .text section.  How do you
> think about this example ?

I don't know where the .text section is anymore, once the module is
loaded.  And just the .text section might not be enough on some archs.

I think it would be cleaner to have a userspace program which parses
the module, figures out how it is laid out in memory (this will be
arch specific!) and then (using the base address from /proc/modules)
tells the kernel "insert a probe at address 0xc1234567".  This should
be far more flexible, I think.

Thoughts?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
