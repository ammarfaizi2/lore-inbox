Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262097AbVBSWie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbVBSWie (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 17:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbVBSWib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 17:38:31 -0500
Received: from mail.kroah.org ([69.55.234.183]:57237 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262097AbVBSWiF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 17:38:05 -0500
Date: Sat, 19 Feb 2005 14:37:11 -0800
From: Greg KH <greg@kroah.com>
To: Mickey Stein <yekkim@pacbell.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c.h: Fix another gcc 4.0 compile failure
Message-ID: <20050219223711.GB12713@kroah.com>
References: <42177048.2000109@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42177048.2000109@pacbell.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2005 at 08:58:48AM -0800, Mickey Stein wrote:
> From: Mickey Stein
>  Versions:   linux-2.6.11-rc4-bk7, gcc4 (GCC) 4.0.0 20050217 (latest fc 
> rawhide from 19Feb DL)
> 
>  gcc4 cvs seems to dislike "include/linux/i2c.h file":
> 
>  Error msg:   include/linux/i2c.h:{55,194} error: array type has 
> incomplete element type
> 
>  A. Daplas has recently done a workaround for this on another header 
> file. A thread discussing this
>  can be found by following the link below:
> 
>  http://gcc.gnu.org/ml/gcc/2005-02/msg00053.html
> 
>  The patch changes the array declaration from "struct x y[]" format to 
> "struct x *y".
>  I realize its only a workaround, but the gcc guys seem to be aware of 
> this.
>  ** Note: I'm a noob at this, so feel free to make chopped liver out of 
> this if its incorrect.
>  patch below is also attached since I'm not sure formatting survives 
> the cut&paste.

The patch looks sane, but before I apply it, care to also fix up all of
the function pointers that are affected by this patch?  Also the
i2c_transfer() function itself should be changed (not just the header
file.)

thanks,

greg k-h
