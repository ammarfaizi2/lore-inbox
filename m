Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261825AbSJNFnO>; Mon, 14 Oct 2002 01:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261844AbSJNFnO>; Mon, 14 Oct 2002 01:43:14 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:6776 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261825AbSJNFnN>; Mon, 14 Oct 2002 01:43:13 -0400
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Greg KH <greg@kroah.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Dave Jones <davej@codemonkey.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Summit support for 2.5 [0/4]
References: <Pine.LNX.4.44.0210132145210.4554-100000@chaos.physics.uiowa.edu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 Oct 2002 23:46:24 -0600
In-Reply-To: <Pine.LNX.4.44.0210132145210.4554-100000@chaos.physics.uiowa.edu>
Message-ID: <m1adlhlgi7.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> writes:

> On Sun, 13 Oct 2002, Greg KH wrote:
> 
> > +ifeq ($(CONFIG_SUMMIT),y)
> > +MACHINE	= mach-summit
> >  endif
> >  
> > Can make handle reassigning a variable?
> 
> Sure.
> 
> You could even do
> 
> 	machine-y 			:= mach-generic
> 	machine-$(CONFIG_SUMMIT)	:= mach-summit
> 	...
> 	MACHINE				:= $(machine-y)

Cool.  With a setup that clean I think I can break the multiple firmware
code out easily as well.

        firmware-y			:= firmware-pcbios
        firmware-$(CONFIG_LINUXBIOS)	:= firmware-linuxbios
        ...
        FIRMWARE			:= $(firmware-y)

I had it broken out cleanly earlier, but everyone was concentrating
on other things and I just haven't been able to get back to that
stuff until this week.  It will be a little tight coming in under
the wire with working code but we will see.

Unless someone has some objections...

Eric
