Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263473AbTDDJOQ (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 04:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbTDDJOQ (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 04:14:16 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12293 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263473AbTDDJOJ (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 04:14:09 -0500
Date: Fri, 4 Apr 2003 10:25:35 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: jt@hpl.hp.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: uart_ioctl OOPS with irtty-sir
Message-ID: <20030404102535.A29313@flint.arm.linux.org.uk>
Mail-Followup-To: jt@hpl.hp.com,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20030404013405.GA19446@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030404013405.GA19446@bougret.hpl.hp.com>; from jt@bougret.hpl.hp.com on Thu, Apr 03, 2003 at 05:34:05PM -0800
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 05:34:05PM -0800, Jean Tourrilhes wrote:
> 	Unfortunately, the irtty-sir driver, which is a TTY line
> discipline and a network driver, need to be able to change the RTS and
> DTR line from a kernel thread.

I'd prefer if we added an tty API to allow line disciplines to read/set
the modem control lines to the tty later, rather than having line
disciplines play games with IOCTLs.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

