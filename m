Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964993AbVJ0IIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbVJ0IIs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 04:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbVJ0IIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 04:08:48 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1551 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964993AbVJ0IIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 04:08:47 -0400
Date: Thu, 27 Oct 2005 09:08:39 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jarek <jarek@macro-system.com.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dumb muliport serial cards not supported in 2.6.13.4 ???
Message-ID: <20051027080839.GA3235@flint.arm.linux.org.uk>
Mail-Followup-To: Jarek <jarek@macro-system.com.pl>,
	linux-kernel@vger.kernel.org
References: <1130397258.13942.14.camel@jarek.macro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130397258.13942.14.camel@jarek.macro>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2005 at 09:14:18AM +0200, Jarek wrote:
> Hi all!
> 
> 	I've PCM 3643, 8 port dumb multiport serial card from Advantech.
> 	This card works nice with 2.6.12 but with 2.6.13.4 I can see only two
> ports!
> 	This is dumb 8250 (exactly: 16550A) multiport board. In 2.6.12 I've the
> following settings:
> 
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_SERIAL_8250_NR_UARTS=4
> CONFIG_SERIAL_8250_EXTENDED=y
> CONFIG_SERIAL_8250_MANY_PORTS=y
> CONFIG_SERIAL_8250_SHARE_IRQ=y
> CONFIG_SERIAL_8250_MULTIPORT=y
> CONFIG_SERIAL_8250_RSA=y
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> 
> I've tried to setup same in 2.6.13.4, but it claims:
> .config:761: trying to assign nonexistent symbol SERIAL_8250_MULTIPORT
> 
> I suspect that this is the problematic setting but there is nothing
> about this in any Changelog.
> 
> What should I do ?

Please send the kernel messages from this kernel so we can see what's
going on.  (this would be useful whatever.)

At a guess you need to increase CONFIG_SERIAL_8250_NR_UARTS.  It now
represents the _total_ number of ports.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
