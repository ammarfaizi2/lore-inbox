Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbVCYJHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbVCYJHx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 04:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVCYJHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 04:07:53 -0500
Received: from mail.renesas.com ([202.234.163.13]:8645 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S261554AbVCYJHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 04:07:43 -0500
Date: Fri, 25 Mar 2005 18:07:36 +0900 (JST)
Message-Id: <20050325.180736.1021580554.takata.hirokazu@renesas.com>
To: rmk+lkml@arm.linux.org.uk
Cc: takata@linux-m32r.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Bitrotting serial drivers
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20050324121746.A4189@flint.arm.linux.org.uk>
References: <20050319172101.C23907@flint.arm.linux.org.uk>
	<20050324.191424.233669632.takata.hirokazu@renesas.com>
	<20050324121746.A4189@flint.arm.linux.org.uk>
X-Mailer: Mew version 3.3 on XEmacs 21.4.17 (Jumbo Shrimp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+lkml@arm.linux.org.uk>
Date: Thu, 24 Mar 2005 12:17:46 +0000
> On Thu, Mar 24, 2005 at 07:14:24PM +0900, Hirokazu Takata wrote:
> > Could you please accept the following patch?
> 
> Probably, but I'd like to have a reply to my comments below first.
> 
> > diff -ruNp a/include/asm-m32r/serial.h b/include/asm-m32r/serial.h
> > --- a/include/asm-m32r/serial.h	2004-12-25 06:35:40.000000000 +0900
> > +++ b/include/asm-m32r/serial.h	2005-03-24 17:25:05.812651363 +0900
> 
> Can m32r accept PCMCIA cards?  If so, this may mean that 8250.c gets
> built, which will use this file to determine where it should look for
> built-in 8250 ports.
> 
> If this file is used to describe non-8250 compatible ports, you could
> end up with a nasty mess.  Therefore, I recommend that you do not use
> asm-m32r/serial.h to describe your SIO ports.

I understand.

You mean I have to keep 8250.c buildable for PCMCIA serial cards, 
if I make use of both m32r_sio and 8250 compatible drivers at a time, right?

> Instead, since these definitions are private to your own driver, you
> may consider moving them into the driver, or a header file closely
> associated with your driver in drivers/serial.

I will try to move these definitions into the m32r_sio driver.
Please just a moment, I have no time to do it now...

Thank you.

-- Takata
