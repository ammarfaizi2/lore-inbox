Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261523AbTAOEdh>; Tue, 14 Jan 2003 23:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261836AbTAOEdh>; Tue, 14 Jan 2003 23:33:37 -0500
Received: from dp.samba.org ([66.70.73.150]:35970 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261523AbTAOEde>;
	Tue, 14 Jan 2003 23:33:34 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Corey Minyard <cminyard@mvista.com>
Cc: linux-kernel@vger.kernel.org, Corey Minyard <minyard@mvista.com>
Subject: Re: IPMI 
In-reply-to: Your message of "Tue, 14 Jan 2003 08:29:33 MDT."
             <3E241ECD.6000108@mvista.com> 
Date: Wed, 15 Jan 2003 14:49:55 +1100
Message-Id: <20030115044228.C33A82C054@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3E241ECD.6000108@mvista.com> you write:
> Does this work, or would you like more detail?
> 
> config IPMI_HANDLER
>        tristate 'IPMI top-level message handler'
>        help
>          This enables the central IPMI message handler, required for IPMI
>          to work.  Note that you must have this enabled to enable any
>          other IPMI things.  IPMI is a standard for managing sensors
>          (temperature, voltage, etc.) in a system.  If you don't know
>          what it is, your system probably doesn't have it and you can
>          ignore this option.  See Documentation/IPMI.txt for more
>          details on the driver.

I don't mean to nitpick, but I want to know whether I need it or not.

Now, if I read this correctly, CONFIG_IPMI would be a more appropriate
name.  But changing the message at least would make it clearer:

	config IPMI_HANDLER
	       tristate 'IPMI support'

Now, the message.  How about this:
       help
	  Intelligent Peripheral Management Interface (IPMI) is a
	  standard for managing sensors (temperature, voltage, etc.)
	  in a system.  Most IA64 and x86 servers shipped since 2002
	  have support for it.  See Documentation/IPMI.txt for more
	  details.  Say "N" unless configuring for a recent x86 or
	  IA64 machine.

Tweak details to suit: maybe IPMI goes furthur back, maybe it's also
on desktops, maybe it's so widespread that the suggested default
should be "Y" for all IA64 and x86.

But the "what to do if you know nothing" is important: people who know
what IPMI is don't need the help message.

Hope that clarifies?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
