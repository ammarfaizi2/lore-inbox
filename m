Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750983AbVKWPTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbVKWPTV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 10:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbVKWPTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 10:19:21 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:37645 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750789AbVKWPTU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 10:19:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TH5LXiZKZ+U6Q8rEYRvsn3J1XWAppqSSK/By9CaEIkeOkqx6Dq7FNB2Lgq5XSqvntPATh1CSx0RO2vIBhpx/5iTOU8q2NNDbImezBaDmAYk5lle1NQe6frI+cFkLX2S8Ki9yxpvnHNoFdHVVvdXad8k30kOvyg/kQBlkWtmmcqE=
Message-ID: <9e4733910511230719h67fa96bdxdeb654aa12f18e67@mail.gmail.com>
Date: Wed, 23 Nov 2005 10:19:19 -0500
From: Jon Smirl <jonsmirl@gmail.com>
To: Vojtech Pavlik <vojtech@suse.cz>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>, rmk+lkml@arm.linux.org.uk
Subject: Re: Christmas list for the kernel
In-Reply-To: <20051123150349.GA15449@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com>
	 <20051122204918.GA5299@kroah.com>
	 <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com>
	 <20051123121726.GA7328@ucw.cz>
	 <9e4733910511230643j64922738p709fecd6c86b4a95@mail.gmail.com>
	 <20051123150349.GA15449@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> On Wed, Nov 23, 2005 at 09:43:58AM -0500, Jon Smirl wrote:
> > My system has:
> > 2 serial
> >
> > In /sys/bus/platform/devices I see this:
> > serial8250
> > shouldn't there be entries for all of the legacy devices?
> >
> > In /dev
> > ttyS0
> > ttyS1
> > ttyS2
> > ttyS3
>
> You're basically confused about serial ports.  The kernel serial devices
> whether or not hardware is found, to allow programs such as setserial to
> function.
>
> If you disagree with that, there'll be an equal number of people who
> have serial cards that need setserial who will in turn disagree with
> you.

This is confusing...

Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A

/sys/bus/platform/devices/serial8250
[jonsmirl@jonsmirl serial8250]$ ls
bus  driver  power  tty:ttyS0  tty:ttyS1  tty:ttyS2  tty:ttyS3  uevent
[jonsmirl@jonsmirl serial8250]$


--
Jon Smirl
jonsmirl@gmail.com
