Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbVHaKTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbVHaKTr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 06:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbVHaKTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 06:19:47 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19984 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932073AbVHaKTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 06:19:46 -0400
Date: Wed, 31 Aug 2005 11:19:40 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Rahul Tank <rahul5311@yahoo.co.in>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: serial port multiplexing
Message-ID: <20050831111940.F26480@flint.arm.linux.org.uk>
Mail-Followup-To: Rahul Tank <rahul5311@yahoo.co.in>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20050825122045.57008.qmail@web8401.mail.in.yahoo.com> <20050831111048.E26480@flint.arm.linux.org.uk> <20050831101610.GB27695@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050831101610.GB27695@lug-owl.de>; from jbglaw@lug-owl.de on Wed, Aug 31, 2005 at 12:16:10PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 at 12:16:10PM +0200, Jan-Benedict Glaw wrote:
> On Wed, 2005-08-31 11:10:48 +0100, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > On Thu, Aug 25, 2005 at 01:20:45PM +0100, Rahul Tank wrote:
> > >     I am a newbee tryinging for serial port
> > > multiplexing. Currently my driver supports for one
> > > port
> > > (/dev/ttyS0). However i want to use the same physical
> > > port for 2 virtual ports.I am NOT sending two type of
> > > data simultaneously. I want to first reigister my
> > > driver for /dev/ttyS0. When the kernel  has booted ,i
> > > want to disable it. Then i want to enable the driver
> > > to register for say /dev/ttyS1.
> > >   in short i don't want the console to have controle
> > > over the serial port.
> > 
> > Try setting the kernel message level to zero after boot.  That
> > will prevent the kernel from displaying any further messages to
> > that serial port, except when a serious problem (eg, oops) occurs.
> 
> Alternatively, IIRC one of the printk-nullifying patches were taken
> some time ago. You should be able to eleminate any printk()s through
> kernel configuration in the embedded menu.

Yes, except I believe the OP wants to see the initial kernel messages,
and then want to shut the kernel up once it has booted.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
