Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263682AbUJ3K3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263682AbUJ3K3O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 06:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263680AbUJ3K3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 06:29:13 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38669 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263682AbUJ3K2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 06:28:23 -0400
Date: Sat, 30 Oct 2004 11:28:18 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alex Williamson <alex.williamson@hp.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] set membase in serial8250_request_port
Message-ID: <20041030112818.C11909@flint.arm.linux.org.uk>
Mail-Followup-To: Alex Williamson <alex.williamson@hp.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1096916062.4510.20.camel@tdi> <20041004220419.C21216@flint.arm.linux.org.uk> <1096926184.4510.54.camel@tdi> <1098111389.30201.7.camel@tdi> <1098991495.2719.8.camel@tdi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1098991495.2719.8.camel@tdi>; from alex.williamson@hp.com on Thu, Oct 28, 2004 at 01:24:55PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 01:24:55PM -0600, Alex Williamson wrote:
>   The iounmap/ioremap path in serial8250_release/request_port is
> terribly unbalanced.  The UPF_IOREMAP flag is used to determine if a
> port gets ioremap'd, but plays no part in whether it gets iounmap'd.
> It's easy to see how an MMIO serial port can be passed through
> uart_set_info and end up with an unmapped membase.  The results is a
> non-functional UART or worse.  I've tried to generate some discussion on
> the proper fix for this, but I haven't succeeded.  I propose the patch
> below as a safe compromise.  An MMIO uart w/ a mapbase, but no membase
> doesn't seem viable to me.  Thanks,

I'm going to be doing a major update to serial today, and these patches
are made rather unnecessary by that.  Thanks for pointing out the problem
anyway.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
