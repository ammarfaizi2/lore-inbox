Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266322AbUAOAVA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 19:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266329AbUAOAVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 19:21:00 -0500
Received: from gprs214-23.eurotel.cz ([160.218.214.23]:30338 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266322AbUAOAUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 19:20:42 -0500
Date: Thu, 15 Jan 2004 01:19:29 +0100
From: Pavel Machek <pavel@suse.cz>
To: George Anzinger <george@mvista.com>
Cc: Greg KH <greg@kroah.com>, Matt Mackall <mpm@selenic.com>,
       "Amit S. Kale" <amitkale@emsyssoft.com>, Andrew Morton <akpm@osdl.org>,
       jim.houston@comcast.net, discuss@x86-64.org, ak@suse.de,
       shivaram.upadhyayula@wipro.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [discuss] Re: kgdb for x86_64 2.6 kernels
Message-ID: <20040115001928.GD308@elf.ucw.cz>
References: <000e01c3d476$2ebe03a0$4008720a@shivram.wipro.com> <200401101611.53510.amitkale@emsyssoft.com> <400237F0.9020407@mvista.com> <200401122020.08578.amitkale@emsyssoft.com> <40046296.1050702@mvista.com> <20040114063155.GF28521@waste.org> <4005A03A.40409@mvista.com> <20040114232631.GB9983@kroah.com> <4005D8A5.3010002@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4005D8A5.3010002@mvista.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>Right.  I had hoped that we might one day be able to use the USB and I am 
> >>sure there are others.
> >
> >
> >Raw USB?  Or some kind of USB to serial device?
> >
> >Remember, USB needs interrupts to work, see the kdb patches for the mess
> >that people have tried to go through to send usb data without interrupts
> >(doesn't really work...)
> 
> I gave up on USB when I asked the following questions:
> 1. How many different HW USB master devices need to be supported (i.e. 
> appear on your normal line of MBs)? (answer, too many)
> 2. Can I isolate a USB port from the kernel so that it does not even know 
> it is there? (answer: NO)
> 
> What I want is a USB port that is completely coded in kgdb software (keeps 
> Heisenberg out).  It would be a polled device except for the ^C (or 
> equivalent) interrupt.
> 
> We, of course, have the same issues with the eth interface.  Far too much 
> of the rest of the kernel is involved in the communications with it.  Also 
> there are way to many interfaces to code each one seperatly, thus the 
> current effort using a good deal of the kernel to remove all that special 
> code.  Of course Heisenberg and all his friends and relations are taking up 
> residence in that code :)  Might not be too bad except that his uncle is 
> Murphy.

I believe that usb only has UHCI, OHCI and EHCI drivers, the rest are
devices, but ?HCI is evil enough that ethernet looks like "nice and
easy" interface.

BTW it is not using that much of eth infrastructure, just the
driver. It should be possible to dedicate one ethernet to kgdb,
only...

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
