Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317499AbSHCICA>; Sat, 3 Aug 2002 04:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317497AbSHCICA>; Sat, 3 Aug 2002 04:02:00 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61453 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316548AbSHCIB7>; Sat, 3 Aug 2002 04:01:59 -0400
Date: Sat, 3 Aug 2002 09:05:23 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: axel@hh59.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
       tytso@mit.edu
Subject: Re: Linux 2.5.30: [SERIAL] build fails at 8250.c
Message-ID: <20020803090523.A22424@flint.arm.linux.org.uk>
References: <200208030020.RAA05695@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208030020.RAA05695@baldur.yggdrasil.com>; from adam@yggdrasil.com on Fri, Aug 02, 2002 at 05:20:28PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2002 at 05:20:28PM -0700, Adam J. Richter wrote:
> On Sat, 3 Aug 2002 01:12:10 +0100, Russell King wrote:
> >Ok, here's a fix for the 8250.c build problem (please don't send it
> >to Linus; I've other changes that'll be going via BK and patch to
> >lkml pending):
> >
> >--- orig/drivers/serial/8250.c  Fri Aug  2 21:13:31 2002
> >+++ linux/drivers/serial/8250.c Sat Aug  3 00:28:47 2002
> >@@ -31,7 +31,8 @@
> > #include <linux/console.h>
> > #include <linux/sysrq.h>
> > #include <linux/serial_reg.h>
> >-#include <linux/serialP.h>
> >+#include <linux/circ_buf.h>
> >+#include <linux/serial.h>
> > #include <linux/delay.h>
> > 
> > #include <asm/io.h>
> 
> 	Your patch still results in a compilation error for me.
> It looks like 8250.c needs <linux/serialP.h> for ALPHA_KLUDGE_MCR:

Your quote above didn't include the patch for 8250.h which was in my
mail directly after 8250.c.  Did you specifically miss it for a reason?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

