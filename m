Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131041AbRBWD2A>; Thu, 22 Feb 2001 22:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131261AbRBWD1q>; Thu, 22 Feb 2001 22:27:46 -0500
Received: from delta.Colorado.EDU ([128.138.139.9]:3333 "EHLO ibg.colorado.edu")
	by vger.kernel.org with ESMTP id <S131041AbRBWD1i>;
	Thu, 22 Feb 2001 22:27:38 -0500
Message-Id: <200102230327.UAA452494@ibg.colorado.edu>
To: "Tom Sightler" <ttsig@tuxyturvy.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: PCI oddities on Dell Inspiron 5000e w/ 2.4.x 
In-Reply-To: Your message of Thu, 22 Feb 2001 15:19:15 EST.
In-Reply-To: <200102220719.AAA398825@ibg.colorado.edu> <000201c09d0c$d53a73c0$25040a0a@zeusinc.com> 
Organization: Institute for Behavioral Genetics
              University of Colorado
              Boulder, CO  80309-0447
X-Phone: +1 303 492 2843
X-FAX: +1 303 492 8063
X-URL: http://ibgwww.Colorado.EDU/~lessem/
X-Copyright: All original content is copyright 2001 Jeff Lessem.
X-Copyright: Quoted and non-original content may be copyright the
X-Copyright: original author or others.
Date: Thu, 22 Feb 2001 20:27:31 -0700
From: Jeff Lessem <Jeff.Lessem@Colorado.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In your message of: Thu, 22 Feb 2001 15:19:15 EST, you write:
>I'm a little confused by what you mean when you say PCMCIA modules, are you
>referring to the actual PCMCIA socket drivers themselves?  If so, perhaps

Yes, the i82365 module does not load.

>this is why you have problems and I don't.  Linux 2.4 includes support for
>the Cardbus driver internally, simply make sure you enable Hot Plug support,
>and build PCMCIA and Cardbus support right into the kernel.

I took your advice and used the kernel drivers from 2.4.2.  I built
the Cardbus and i82365 drivers into the kernel.  This shows the exact
same behavior, after a power-on reboot I get:

Yenta IRQ list 06d8, PCI irq11
Socket status: 30000006
Yenta IRQ list 06d8, PCI irq11
Socket status: 30000006

and the wvlan_cs module from the external PCMCIA package loads and
works without problems.  However, after powering off the status
message during boot is:

Yenta IRQ list 0000, PCI irq11
Socket status: 35fb54ce
Yenta IRQ list 0000, PCI irq11
Socket status: 22b1dcee

and though the cardmgr loads it does not respond to card events,
i.e. inserting a card produces *no* effect, there is not a beep, or
any logged messages.  Rebooting with 2.2.17 fixes the problem and
2.4.2 then works again.  It looks to me like something in the PCI bus
isn't setup correctly by the 2.4 kernels, but chasing that down is way
beyond my ability, hence the post to linux-kernel.

--
Jeff Lessem.
