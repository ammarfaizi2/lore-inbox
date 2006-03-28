Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbWC1WFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbWC1WFg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 17:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWC1WFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:05:36 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24076 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932432AbWC1WFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:05:35 -0500
Date: Tue, 28 Mar 2006 23:05:26 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-mm2
Message-ID: <20060328220525.GB16205@flint.arm.linux.org.uk>
Mail-Followup-To: Kumar Gala <galak@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060328003508.2b79c050.akpm@osdl.org> <9F2A5122-5295-4B86-9AC5-3D002C5FD5D4@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9F2A5122-5295-4B86-9AC5-3D002C5FD5D4@kernel.crashing.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2006 at 03:52:33PM -0600, Kumar Gala wrote:
> When building pmac32_defconfig for arch=powerpc:
> 
> drivers/built-in.o(.text+0x74cd4): In function `pciserial_init_ports':
> : undefined reference to `serial8250_register_port'
> drivers/built-in.o(.text+0x74d88): In function `pciserial_remove_ports':
> : undefined reference to `serial8250_unregister_port'
> drivers/built-in.o(.text+0x74e70): In function  
> `pciserial_suspend_ports':
> : undefined reference to `serial8250_suspend_port'
> drivers/built-in.o(.text+0x74ee0): In function `pciserial_resume_ports':
> : undefined reference to `serial8250_resume_port'
> 
> Need to hunt down why this is happening.

We know why, it's a kconfig oddity - as discussed in the 2.6.16-mm1
thread.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
