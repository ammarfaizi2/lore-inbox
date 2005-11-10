Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750979AbVKJOsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbVKJOsy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 09:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbVKJOsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 09:48:54 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41233 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750973AbVKJOsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 09:48:53 -0500
Date: Thu, 10 Nov 2005 14:48:47 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andreas Schwab <schwab@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Broken __get_unaligned from <asm-generic/unaligned.h>
Message-ID: <20051110144847.GA28700@flint.arm.linux.org.uk>
Mail-Followup-To: Andreas Schwab <schwab@suse.de>,
	linux-kernel@vger.kernel.org
References: <jevez0h8ea.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jevez0h8ea.fsf@sykes.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2005 at 03:42:05PM +0100, Andreas Schwab wrote:
> __get_unaligned can't cope with const-qualified types:
> 
> drivers/char/vc_screen.c: In function 'vcs_write':
> drivers/char/vc_screen.c:422: error: assignment of read-only variable 'val'
> drivers/char/vc_screen.c:422: error: assignment of read-only variable 'val'
> drivers/char/vc_screen.c:422: error: assignment of read-only variable 'val'
> drivers/char/vc_screen.c:422: error: assignment of read-only variable 'val'

What if get_unaligned is used with a u64 / long long type (which it is)?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
