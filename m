Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261934AbTABOzj>; Thu, 2 Jan 2003 09:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261963AbTABOzi>; Thu, 2 Jan 2003 09:55:38 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:58603 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S261934AbTABOzi>;
	Thu, 2 Jan 2003 09:55:38 -0500
Date: Fri, 3 Jan 2003 02:03:58 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marc Giger <gigerstyle@gmx.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Power off a SMP Box
Message-Id: <20030103020358.2c0e6714.sfr@canb.auug.org.au>
In-Reply-To: <20030102135350.24315441.gigerstyle@gmx.ch>
References: <20030102135350.24315441.gigerstyle@gmx.ch>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jan 2003 13:53:50 +0100 Marc Giger <gigerstyle@gmx.ch> wrote:
>
> My "problem" is that my Dual-Box won't power off itself after a shutdown.

Has it ever?  What kernel version are you trying this on?

> I tried with 
> 
> apm=smp-power-off	//no effect
> apm=power-off		//this one oopses on boot

This second should work on any kernel since early 2000.

However, there are many SMP machines that cannot be powered off
using APM.  APM is not defined for SMP machines, and the result
you got is why APM is not enabled easily on SMP boxes.

> Has someone a hint for me?

You could try ACPI in (very) recent kernels.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
