Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290289AbSBKT0w>; Mon, 11 Feb 2002 14:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290236AbSBKTY4>; Mon, 11 Feb 2002 14:24:56 -0500
Received: from tele-post-20.mail.demon.net ([194.217.242.20]:32527 "EHLO
	tele-post-20.mail.demon.net") by vger.kernel.org with ESMTP
	id <S290229AbSBKTYh>; Mon, 11 Feb 2002 14:24:37 -0500
Date: Mon, 11 Feb 2002 16:30:59 +0000
From: Nick Craig-Wood <ncw@axis.demon.co.uk>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: what serial driver restructure is planned?
Message-ID: <20020211163059.A22996@axis.demon.co.uk>
In-Reply-To: <11E89240C407D311958800A0C9ACF7D13A768A@EXCHANGE> <20020207102144.B15226@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020207102144.B15226@flint.arm.linux.org.uk>; from linux@arm.linux.org.uk on Thu, Feb 07, 2002 at 10:21:44AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 10:21:44AM +0000, Russell King - ARM Linux wrote:
> It basically started out by pulling 65K worth of the duplicated code out
> of various serial drivers.  Its currently moving towards allowing the
> input layer to talk to serial devices (needed for things like iPAQ
> keyboards and IrDA-based keyboards), as well as allowing things like
> USB serial devices to use the core code.

Could we also have an interface to serial devices which bypass the tty
layer?  Ie a /dev/ttyraw* which just speaks to the serial port without
going through the labyrinthine tty layers?

This would need to keep some basic ioctls for changing baud rate etc.

9 times out of 10 when I reach for /dev/ttyS* that is all I want and
the tty layer is just wasteful and gets in the way of a conceptually
very simple device.

> Some people would also like to see a "serial major" where all serial
> devices live.

Gets my vote.

-- 
Nick Craig-Wood
ncw@axis.demon.co.uk
