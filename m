Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318526AbSGZVxJ>; Fri, 26 Jul 2002 17:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318530AbSGZVxJ>; Fri, 26 Jul 2002 17:53:09 -0400
Received: from cpe-24-221-212-80.co.sprintbbd.net ([24.221.212.80]:44017 "EHLO
	servidor.linux-ha.org") by vger.kernel.org with ESMTP
	id <S318526AbSGZVxI>; Fri, 26 Jul 2002 17:53:08 -0400
Message-ID: <3D41C544.9090702@unix.sh>
Date: Fri, 26 Jul 2002 15:55:16 -0600
From: Alan Robertson <alanr@unix.sh>
Organization: IBM Linux Technology Center
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Isabelle, Francois" <Francois.Isabelle@ca.kontron.com>
Cc: "Linux-Ha (E-mail)" <linux-ha@muc.de>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Handling NMI in a kernel module
References: <5009AD9521A8D41198EE00805F85F18F219A7E@sembo111.teknor.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Isabelle, Francois wrote:
> Is it possible to request_nmi() the way you can request_irq() from a kernel
> driver on the i386 arch?
> 
> Our hardware watchdog is dual stage and can generate NMI on first stage ,
> our cPCI handle switch can also be used for Hot swap request via NMI.
> I'ld like to make use of this, I noticed cpqhealth module already
> implemented some nmi handling but this driver is close sourced.
> 
> Should we patch in i386/kernel/traps.c to add a callback to our stuff in
> unkown_nmi_error().
> 
> I'ld like my driver to register a callback there, what about maintaining a
> list of user callback functions which could be registered via:
>  
> request_nmi(int option, void (*hander)(void *dev_id, struct pt_regs *regs),
> unsigned long flags, const char *dev_name, void *dev_id);
> 
> where option could take meaning such as
>  - prepend   : place at start of nmi callback functions
>  - append    : place at end of nmi callback functions 
>  - truncate : replace callback chain
> 
> Is there any standard mecanism to implement such features( dual stage
> watchdog ) ?

We've created a separate mailing list to talk about enhancements to the 
watchdog driver API.  Dual stage watchdog is on the list.  It's pretty quiet 
now, but perhaps now that summer is winding down, we can get started again...


Info on the list is here:  	
	http://lists.tummy.com/mailman/listinfo/watchdogng



	-- Alan Robertson
	   alanr@unix.sh

