Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265857AbTCFPZo>; Thu, 6 Mar 2003 10:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265667AbTCFPZo>; Thu, 6 Mar 2003 10:25:44 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2063 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265857AbTCFPZm>; Thu, 6 Mar 2003 10:25:42 -0500
Date: Thu, 6 Mar 2003 15:36:11 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.64 - xircom realport no workie well
Message-ID: <20030306153611.C838@flint.arm.linux.org.uk>
Mail-Followup-To: CaT <cat@zip.com.au>, linux-kernel@vger.kernel.org
References: <20030306130340.GA453@zip.com.au> <20030306132904.A838@flint.arm.linux.org.uk> <20030306134746.GE464@zip.com.au> <20030306140945.B838@flint.arm.linux.org.uk> <20030306152036.GA432@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030306152036.GA432@zip.com.au>; from cat@zip.com.au on Fri, Mar 07, 2003 at 02:20:36AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 02:20:36AM +1100, CaT wrote:
> On Thu, Mar 06, 2003 at 02:09:45PM +0000, Russell King wrote:
> > On Fri, Mar 07, 2003 at 12:47:46AM +1100, CaT wrote:
> > > On Thu, Mar 06, 2003 at 01:29:04PM +0000, Russell King wrote:
> > > > Can you check whether the attached patch fixes this for you?  It's more
> > > 
> > > Started compiling it and it just bombed out:
> > > 
> > > drivers/serial/8250_pci.c:1920: `PCI_DEVICE_ID_XIRCOM_RBM56G' undeclared
> > > here (not in a function)
> > > drivers/serial/8250_pci.c:1920: initializer element is not constant
> > > drivers/serial/8250_pci.c:1920: (near initialization for
> > > `serial_pci_tbl[86].device')
> > 
> > Bah.  You need this as well then:
> 
> Applied. It compiles now. Did a reboot into the new kernel and it hangs
> somewhere in the point where it blanks the display but before it
> switches to the framebuffer to display the kernel output messages (hope
> that helps). I have no oops or anything. Just a blank display and no
> disc activity or anything. ctrl-alt-del don't work and I have to turn my
> laptop off in order to reboot.

Hmm.  Did you build 8250 into the kernel, or as a module?  TBH, I'm not
sure how this could have affected the framebuffer driver.  I'll look
harder in a couple of hours though.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

