Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263349AbTE3HxU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 03:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263354AbTE3HxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 03:53:20 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:5024 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S263349AbTE3HxC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 03:53:02 -0400
From: Rusty Russell <rusty@au1.ibm.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] sx tty_driver add .owner field remove MOD_INC_DEC_USE_COUNT 
In-reply-to: Your message of "Thu, 29 May 2003 14:35:10 MST."
             <12430000.1054244110@w-hlinder> 
Date: Fri, 30 May 2003 18:05:24 +1000
Message-Id: <20030530080556.EC79C17DE1@ozlabs.au.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <12430000.1054244110@w-hlinder> you write:
> --On Thursday, May 29, 2003 12:02:50 PM -0700 Greg KH <greg@kroah.com> wrote:
> 
> > 
> > Ick, this patch should be reverted, it should not be removing
> > sx_hungup() for no reason.  I think Hanna agrees with this.
> 
> Yup. Sorry. Not sure what happened there. Here is the patch
> to replace the sx_hangup function. This is based off 2.5.70-bk3
> and I have compiled it but dont have the hardware to test it.

Yes, but I don't think you need to put back the comment about
decrementing use counts 8)

> +/* I haven't the foggiest why the decrement use count has to happen
> +   here. The whole linux serial drivers stuff needs to be redesigned.
> +   My guess is that this is a hack to minimize the impact of a bug
> +   elsewhere. Thinking about it some more. (try it sometime) Try
> +   running minicom on a serial port that is driven by a modularized
> +   driver. Have the modem hangup. Then remove the driver module. Then
> +   exit minicom.  I expect an "oops".  -- REW */

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
