Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262670AbVFWIsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262670AbVFWIsq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbVFWIpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:45:50 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18185 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263259AbVFWIXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 04:23:39 -0400
Date: Thu, 23 Jun 2005 09:23:30 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: kus Kusche Klaus <kus@keba.com>
Cc: linux-pcmcia@lists.infradead.org, dahinds@users.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: PCMCIA: Statically linked CF card driver?
Message-ID: <20050623092330.B26836@flint.arm.linux.org.uk>
Mail-Followup-To: kus Kusche Klaus <kus@keba.com>,
	linux-pcmcia@lists.infradead.org, dahinds@users.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <AAD6DA242BC63C488511C611BD51F367323249@MAILIT.keba.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <AAD6DA242BC63C488511C611BD51F367323249@MAILIT.keba.co.at>; from kus@keba.com on Thu, Jun 23, 2005 at 09:39:15AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2005 at 09:39:15AM +0200, kus Kusche Klaus wrote:
> Question:
> * Any chance to get the CF card working in that environment?

It should work anyway, although you'll need to use cardmgr with vanilla
mainline kernels.

> * Any chance to boot from it?

Maybe, maybe not.  Even with Dominik's great work, I suspect that PCMCIA
may suffer the same problem as USB in this respect, and require a delay
before trying to mount the root filesystem.  We'll have to see when folk
start using this.

> Wishes and non-wishes:
> * It would be nice to be able to replace the CF 
>   without rebooting.

That's an interesting one.  Alan Cox may have done some work on IDE to
resolve this, but there seems to be some issue preventing it (and Alan's
other IDE patches) being merged.

> * It can be assumed that the PC card CF adapter 
>   is present during boot.
> * There is no need to support hotplugging of the PC card CF adapter.
>   (i.e. the PC card CF adapter could be treated as a static,
>   builtin device, with its driver linked into the kernel).

The CF adapter is a dumb piece of hardware which just converts the
socket pins from PCMCIA format to CF format.  It's completely
transparent to software.  In fact, software doesn't even know it's
there.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
