Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030528AbVIOQkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030528AbVIOQkq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 12:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030529AbVIOQkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 12:40:46 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45577 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030528AbVIOQkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 12:40:45 -0400
Date: Thu, 15 Sep 2005 17:40:35 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, viro@ZenIV.linux.org.uk,
       Linus Torvalds <torvalds@osdl.org>, linux-arch@vger.kernel.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] killing linux/irq.h
Message-ID: <20050915174035.B26124@flint.arm.linux.org.uk>
Mail-Followup-To: Matthew Wilcox <matthew@wil.cx>,
	Geert Uytterhoeven <geert@linux-m68k.org>, viro@ZenIV.linux.org.uk,
	Linus Torvalds <torvalds@osdl.org>, linux-arch@vger.kernel.org,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <20050909184254.GT9623@ZenIV.linux.org.uk> <Pine.LNX.4.62.0509110949390.30752@numbat.sonytel.be> <20050915163455.GD16698@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050915163455.GD16698@parisc-linux.org>; from matthew@wil.cx on Thu, Sep 15, 2005 at 10:34:55AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 10:34:55AM -0600, Matthew Wilcox wrote:
> On Sun, Sep 11, 2005 at 09:50:38AM +0200, Geert Uytterhoeven wrote:
> > On Fri, 9 Sep 2005 viro@ZenIV.linux.org.uk wrote:
> > > 	We get regular portability bugs when somebody decides to include
> > > linux/irq.h into a driver instead of asm/irq.h.  It's almost always a
> > > wrong thing to do and, in fact, causes immediate breakage on e.g. arm.
> > 
> > Wouldn't it be more logical to make linux/irq.h the preferred include?
> > Usually the linux/* versions are preferred over the asm/* versions.
> 
> There's almost no reason to want <*/irq.h> in the first place.  Almost
> all drivers really want <linux/interrupt.h>

The only exception I can think of is for ARM where we supplement the
Linux interrupt API to deal with our configurable interrupt sources
(high level/low level/rising edge/falling edge triggers) on
certain platform groups.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
