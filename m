Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262991AbSJGLwU>; Mon, 7 Oct 2002 07:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262992AbSJGLwU>; Mon, 7 Oct 2002 07:52:20 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53255 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262991AbSJGLwT>; Mon, 7 Oct 2002 07:52:19 -0400
Date: Mon, 7 Oct 2002 12:57:55 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: simon@baydel.com, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: The end of embedded Linux?
Message-ID: <20021007125755.A5381@flint.arm.linux.org.uk>
References: <20021005.212832.102579077.davem@redhat.com> <1033923206.21282.28.camel@irongate.swansea.linux.org.uk> <3DA16A9B.7624.4B0397@localhost> <20021007.033644.85392050.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021007.033644.85392050.davem@redhat.com>; from davem@redhat.com on Mon, Oct 07, 2002 at 03:36:44AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 03:36:44AM -0700, David S. Miller wrote:
>    No one else can run these drivers so 
>    how could I expect someone else to maintain them ?
> 
> This is a common misconception.

Double that.  There are lots of drivers for embedded ARM stuff that
should probably be in the tree, but because they typically add
architecture specific crap to drivers to modify the IO support
the weird and wonderful way the hardware designer has come up with
to connect the device.  Examples of this are cs89x0.c and smc9192.c.

I've tried to coerce people in Alans suggested direction (hiding
the architecture specific stuff behind inb and friends) but That
Doesn't Work because embedded people will not do this.

They'd rather keep their changes external.  And thus, they stay
external.

The conventional "you will do it this way or else your patch will
not be merged" approach taken by Alan and others just doesn't bite
in the embedded world I'm afraid.  Experience has proven this over
and over again.

And as final proof, the solution taken by two embedded companies is
to develop two completely separate cs89x0 driver from the existing one
(and then pick one/merge them) rather than fixing stuff in the way
suggested by Alan.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

