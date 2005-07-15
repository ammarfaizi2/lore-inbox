Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263246AbVGOIt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263246AbVGOIt7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 04:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263254AbVGOIt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 04:49:59 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9490 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263246AbVGOItw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 04:49:52 -0400
Date: Fri, 15 Jul 2005 09:49:47 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm1
Message-ID: <20050715094947.E25428@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050715013653.36006990.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050715013653.36006990.akpm@osdl.org>; from akpm@osdl.org on Fri, Jul 15, 2005 at 01:36:53AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2005 at 01:36:53AM -0700, Andrew Morton wrote:
> +uart_handle_sysrq_char-warning-fix.patch
> 
>  Fix a warning

Andrew, this requires a little more fixing than your simple patch.
Several drivers omit 'regs' from the receive handler when sysrq is
not enabled.  Hence, this simple fix on its own will cause compile
failures.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
