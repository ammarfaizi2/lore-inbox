Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317189AbSFKRHZ>; Tue, 11 Jun 2002 13:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317191AbSFKRHY>; Tue, 11 Jun 2002 13:07:24 -0400
Received: from dsl-64-129-133-253.telocity.com ([64.129.133.253]:53009 "EHLO
	skylab.outpostsentinel.com") by vger.kernel.org with ESMTP
	id <S317189AbSFKRHX>; Tue, 11 Jun 2002 13:07:23 -0400
Subject: Re: Break on serial port
From: cfowler <cfowler@outpostsentinel.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020611173520.D3665@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 11 Jun 2002 13:14:36 -0400
Message-Id: <1023815676.6689.35.camel@moses.outpostsentinel.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can not find that ocnfig option anywher in my 2.4.17 tree.  I also
added CONFIG_MAGIC_SYSRQ=y to the top of .config and then did a  make
dep and make bzImage.  Upon boot I did not see a /proc/sys/kernel/sysrq

I did notice this feature in architectures other than i386.

Chris

On Tue, 2002-06-11 at 12:35, Russell King wrote:
> On Tue, Jun 11, 2002 at 11:41:26AM -0400, cfowler wrote:
> > I remeber a while back being able to send a break on serial console. 
> > I've been unable to do this under 2.4.17.  Has this feature been turned
> > off?  Is there a way to turn it back on?
> 
> It works fine here.  Please confirm that:
> 
> 1. your kernel is built with CONFIG_MAGIC_SYSRQ
> 2. cat /proc/sys/kernel/sysrq returns '1'
> 3. the serial console port is being held open by some user program (eg,
>    getty or init)
> 
> If any of the three above are not true, then break<sysrq-key> doesn't work.
> 
> -- 
> Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
>              http://www.arm.linux.org.uk/personal/aboutme.html
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


