Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261861AbVGOHXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbVGOHXQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 03:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbVGOHXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 03:23:16 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60937 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261861AbVGOHWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 03:22:53 -0400
Date: Fri, 15 Jul 2005 08:22:49 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: karl malbrain <karl@petzent.com>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 chrdev_open: serial_core: uart_open
Message-ID: <20050715082249.A23102@flint.arm.linux.org.uk>
Mail-Followup-To: karl malbrain <karl@petzent.com>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <20050714195717.B10410@flint.arm.linux.org.uk> <NDBBKFNEMLJBNHKPPFILMEAJCEAA.karl@petzent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <NDBBKFNEMLJBNHKPPFILMEAJCEAA.karl@petzent.com>; from karl@petzent.com on Thu, Jul 14, 2005 at 04:50:00PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 04:50:00PM -0700, karl malbrain wrote:
> chrdev_open issues a lock_kernel() before calling uart_open.
> 
> It would appear that servicing the blocking open request uart_open goes to
> sleep with the kernel locked.  Would this shut down subsequent access to
> opening "/dev/tty"???

No.  lock_kernel() is automatically released when a process sleeps.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
