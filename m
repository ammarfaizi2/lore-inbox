Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbWABAh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWABAh6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 19:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWABAh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 19:37:58 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6930 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932289AbWABAh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 19:37:57 -0500
Date: Mon, 2 Jan 2006 00:37:49 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Reinhard Nissl <rnissl@gmx.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: SysReq & serial console
Message-ID: <20060102003749.GA17132@flint.arm.linux.org.uk>
Mail-Followup-To: Reinhard Nissl <rnissl@gmx.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <43B8696B.2070303@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43B8696B.2070303@gmx.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2006 at 12:44:43AM +0100, Reinhard Nissl wrote:
> So, is it possible to redirect the output of a SysReq command to a 
> serial console?

It is.  A wild guess - it sounds like sysrq requests go via some
tasklet, and because the scheduler has packed up, they don't get
run.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
