Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262882AbVA2Ijc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbVA2Ijc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 03:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262883AbVA2Ijc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 03:39:32 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:34755 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262882AbVA2Ija (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 03:39:30 -0500
Date: Fri, 28 Jan 2005 23:55:09 -0500
From: Christopher Li <chrisl@vmware.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: compat ioctl for submiting URB
Message-ID: <20050129045509.GC12806@64m.dyndns.org>
References: <20050128212304.GA11024@64m.dyndns.org> <m1llaclp6s.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1llaclp6s.fsf@muc.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2005 at 07:33:31AM +0100, Andi Kleen wrote:
> 
> Looks reasonable from a first look.
> 
> Issues:
> - Should use CONFIG_COMPAT, not x86-64 specific symbols

Agree.

> - Why can't you set URB_COMPAT transparently in the emulation
> layer?  Then existing applications would hopefully work without
> changes, right?

The existing application is don't need to set the USB_COMPAT flag.
It is use internally to track the URB is submit from 32 bit user
space. I guess I don't have to use that flag.

> 
> You may also want to preserve the __user casts, otherwise
> Al Viro and other sparse users will be unhappy.

I did try. Which place are you referring to? I guess miss some of
it.

Chris

> 
> Thanks for attacking this long standing problem.
> 
> -Andi
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
