Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750926AbWELFsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbWELFsf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 01:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWELFsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 01:48:35 -0400
Received: from mail.gmx.de ([213.165.64.20]:9453 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750926AbWELFse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 01:48:34 -0400
X-Authenticated: #14349625
Subject: Re: swapping and oom-killer: gfp_mask=0x201d2, order=0
From: Mike Galbraith <efault@gmx.de>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200605111514.45503.a1426z@gawab.com>
References: <200605111514.45503.a1426z@gawab.com>
Content-Type: text/plain
Date: Fri, 12 May 2006 07:48:30 +0200
Message-Id: <1147412910.8432.14.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-11 at 15:14 +0300, Al Boldi wrote:
> The current mm behaviour in 2.6, during physical memory exhaustion, expresses 
> itself as an oom-killing spree, while the kernel could have resorted to 
> swapping.
> 
> Is there a reason why oom-killing is currently preferred over swapping?

Looks to me like you booted with mem=8m, and these allocations are
failing because every page the page allocator tried to issue were marked
as being reserved.  The SysRq-M output shows that it did try to swap as
it limped along.

My box won't get past a black screen hang with less than mem=24m, so I'm
kinda surprised you got far enough to even add swap.

	-Mike

