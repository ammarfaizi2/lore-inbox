Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263178AbTCSVXw>; Wed, 19 Mar 2003 16:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263182AbTCSVXw>; Wed, 19 Mar 2003 16:23:52 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:46349 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S263178AbTCSVXv>; Wed, 19 Mar 2003 16:23:51 -0500
Date: Wed, 19 Mar 2003 16:29:20 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Torrey Hoffman <thoffman@arnor.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: (2.5.65) Unresolved symbols in modules?
In-Reply-To: <1047948471.12620.9.camel@rohan.arnor.net>
Message-ID: <Pine.LNX.3.96.1030319162125.1795A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Mar 2003, Torrey Hoffman wrote:

> I'm trying 2.5 for the first time.  I am getting hundreds of unresolved
> symbols in (all?) modules.  Note that:
> - I have installed the module-init-tools. 
> - "which depmod" as root says /usr/local/sbin/depmod
> - depmod -V as root says "module-init-tools 0.9.10"
> 
> But make modules_install as root produces:
> 
> [lots of mkdir -p /lib/modules/2.5.65/kernel/...; cp drivers/... .ko
> /lib/modules/2.5.65/kernel/...]
> 
> and then:
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.65; fi
> depmod: *** Unresolved symbols in
> /lib/modules/2.5.65/kernel/drivers/char/lp.ko
> depmod:         parport_read
> depmod:         parport_set_timeout
> depmod:         parport_unregister_device
> ...
> [lots and lots of unresolved symbols in lots of modules]
> 
> What am I doing wrong?  What web page or kernel documentation should I
> be reading?

Did you have init-tools installed in /sbin before? This looks like the
message I saw from an early version of the package rather than the 2.4
version. In any case I think you either have to change the path to run the
correct module tool, or remake and install the tool in the compatible mode
which works with 2.4 or 2.5. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

