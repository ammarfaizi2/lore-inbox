Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266839AbTBCPm5>; Mon, 3 Feb 2003 10:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266840AbTBCPm5>; Mon, 3 Feb 2003 10:42:57 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30990 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266839AbTBCPm5>; Mon, 3 Feb 2003 10:42:57 -0500
Date: Mon, 3 Feb 2003 15:52:25 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] vmalloc, kmalloc - 2.4.x
Message-ID: <20030203155225.A5968@flint.arm.linux.org.uk>
Mail-Followup-To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1044285222.2396.14.camel@gregs> <1044285758.2527.8.camel@laptop.fenrus.com> <1044286926.2396.28.camel@gregs>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1044286926.2396.28.camel@gregs>; from gj@pointblue.com.pl on Mon, Feb 03, 2003 at 03:42:06PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2003 at 03:42:06PM +0000, Grzegorz Jaskiewicz wrote:
> > and that
> >         printk("<1>%d\n", TimerIntrpt);
> > you shouldn't use <1> in printk strings ever.
> <1>gives me messages on screen on my box, thats why.
> 
> the same effect is while using kmalloc, just change vmalloc to kmalloc.

#include <linux/kernel.h>

and then use

printk(KERN_CRIT "%d\n", TimerIntrpt);

We have these definitions for a reason. 8)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

