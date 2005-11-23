Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbVKWQCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbVKWQCT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 11:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbVKWQCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 11:02:18 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:41883 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1751150AbVKWQCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 11:02:17 -0500
Date: Wed, 23 Nov 2005 17:02:33 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>, rmk+lkml@arm.linux.org.uk
Subject: Re: Christmas list for the kernel
Message-ID: <20051123160231.GC6970@stiffy.osknowledge.org>
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com> <20051122204918.GA5299@kroah.com> <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com> <20051123121726.GA7328@ucw.cz> <9e4733910511230643j64922738p709fecd6c86b4a95@mail.gmail.com> <20051123150349.GA15449@flint.arm.linux.org.uk> <9e4733910511230719h67fa96bdxdeb654aa12f18e67@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910511230719h67fa96bdxdeb654aa12f18e67@mail.gmail.com>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.15-rc2-marc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jon Smirl <jonsmirl@gmail.com> [2005-11-23 10:19:19 -0500]:

> On 11/23/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > On Wed, Nov 23, 2005 at 09:43:58AM -0500, Jon Smirl wrote:
> > > My system has:
> > > 2 serial
> > >
> > > In /sys/bus/platform/devices I see this:
> > > serial8250
> > > shouldn't there be entries for all of the legacy devices?
> > >
> > > In /dev
> > > ttyS0
> > > ttyS1
> > > ttyS2
> > > ttyS3
> >
> > You're basically confused about serial ports.  The kernel serial devices
> > whether or not hardware is found, to allow programs such as setserial to
> > function.
> >
> > If you disagree with that, there'll be an equal number of people who
> > have serial cards that need setserial who will in turn disagree with
> > you.
> 
> This is confusing...
> 
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
> serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> 
> /sys/bus/platform/devices/serial8250
> [jonsmirl@jonsmirl serial8250]$ ls
> bus  driver  power  tty:ttyS0  tty:ttyS1  tty:ttyS2  tty:ttyS3  uevent
> [jonsmirl@jonsmirl serial8250]$
> 

Mine looks like this.

* Why is the seconf line for ttyS1 missing (as you have one above)?
* What does these 'too much work' messages mean? Must have been come
  in lately...

marc@stiffy:~$ dmesg | grep -i serial
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: too much work for irq3
serial8250: too much work for irq3
serial8250: too much work for irq3
serial8250: too much work for irq3
serial8250: too much work for irq3
marc@stiffy:~$ ls /sys/bus/platform/devices/serial8250/
insgesamt 0
    832 drwxr-xr-x 3 root root    0 2005-11-23 16:57 ./
     12 drwxr-xr-x 7 root root    0 2005-11-23 09:21 ../
2452535 lrwxrwxrwx 1 root root    0 2005-11-23 16:58 bus -> ../../../bus/platform/
2452533 lrwxrwxrwx 1 root root    0 2005-11-23 16:58 driver -> ../../../bus/platform/drivers/serial8250/
    833 drwxr-xr-x 2 root root    0 2005-11-23 09:21 power/
2452534 lrwxrwxrwx 1 root root    0 2005-11-23 16:58 tty:ttyS1 -> ../../../class/tty/ttyS1/
2452536 --w------- 1 root root 4096 2005-11-23 09:20 uevent
marc@stiffy:~$

Marc
