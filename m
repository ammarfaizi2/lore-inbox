Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269534AbUICSzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269534AbUICSzM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 14:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269456AbUICSzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 14:55:11 -0400
Received: from heimdall.doit.wisc.edu ([144.92.197.159]:60801 "EHLO
	smtp5.wiscmail.wisc.edu") by vger.kernel.org with ESMTP
	id S269764AbUICSro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 14:47:44 -0400
Date: Fri, 03 Sep 2004 18:47:23 +0000
From: John Lenz <lenz@cs.wisc.edu>
Subject: Re: [PATCH 2.6.8.1 0/2] leds: new class for led devices
In-reply-to: <20040903120634.GK6985@lug-owl.de>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: linux-kernel@vger.kernel.org, Kalin KOZHUHAROV <kalin@thinrope.net>
Message-id: <1094237243l.7429l.1l@hydra>
MIME-version: 1.0
X-Mailer: Balsa 2.2.4
Content-type: text/plain; Format=Flowed; DelSp=Yes; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-Spam-Score: 
X-Spam-Report: IsSpam=no, Probability=7%, Hits=__CD 0, __CT 0, __CTE 0,
 __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_VERSION 0,
 __SANE_MSGID 0
X-Spam-PmxInfo: Server=avs-1, Version=4.7.0.111621, Antispam-Engine: 2.0.0.0,
 Antispam-Data: 2004.9.2.3, SenderIP=146.151.41.63
References: <1094157190l.4235l.2l@hydra> <ch8tdd$1uf$1@sea.gmane.org>
 <20040903120634.GK6985@lug-owl.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/04 07:06:34, Jan-Benedict Glaw wrote:
> On Fri, 2004-09-03 13:54:04 +0900, Kalin KOZHUHAROV <kalin@thinrope.net>
> wrote in message <ch8tdd$1uf$1@sea.gmane.org>:
> > John Lenz wrote:
> > >This is an attempt to provide an alternative to the current arm
> > >specific led interface.  This arm interface does not integrate well
> > >with the device model and sysfs.
> > I am just curious, but what specific hardware devices can be controlled
> > with this?
> 
> For example, the smaller VAX computers offer 8 LEDs which show system
> status during IPL. After boot finished, the OS may use them...
> 
> > >function : a read/write attribute that sets the current function of
> > > timer : the led blinks on and off on a timer
> > > idle : the led turns off when the system is idle and on when not idle
> > > power : the led represents the current power state
> > > user : the led is controlled by user space
> 
> Is idle/timer/power hardware-controlled (eg. by a secondary processor,
> direct chipset implementation) or is switching on/off controlled by
> kernel (eg. heartbeat, IO and ethernet for the LEDs you can find on some
> PA-RISC machines)?

Right now the kernel is in sole control.  The device I am testing this on  
is a Sharp Zaurus SL5500, which has two leds that by default are used to  
light when new mail arrives and if the power is plugged in.

A read-only interface should probably be added?

The function stuff was intended to be controlled by the kernel, but I think  
now that I should just remove this and let userspace do it.  If we just  
allow userspace an easy way to turn the leds on and off (and stuff like  
power state is available elsewhere in sysfs) a simple shell script could  
turn the led to show the power state.

John


