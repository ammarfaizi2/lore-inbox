Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261780AbVCYUaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbVCYUaX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 15:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbVCYUaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 15:30:23 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24849 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261780AbVCYUaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 15:30:06 -0500
Date: Fri, 25 Mar 2005 20:29:55 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: Remaining u32 vs. pm_message_t fixes
Message-ID: <20050325202955.B12715@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Andrew Morton <akpm@zip.com.au>,
	kernel list <linux-kernel@vger.kernel.org>,
	Greg KH <greg@kroah.com>,
	Nigel Cunningham <ncunningham@linuxmail.org>
References: <20050325102452.GA1352@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050325102452.GA1352@elf.ucw.cz>; from pavel@ucw.cz on Fri, Mar 25, 2005 at 11:24:52AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2005 at 11:24:52AM +0100, Pavel Machek wrote:
> This fixes three remaining places where we put u32 (or worse
> suspend_state_t) into pm_message_t-sized box. As a bonus, PCI_D0 is
> used instead of constant 0. Please apply,

I suspect there's more than that still remaining.  Have you tried

$ grep suspend include/asm-arm -r

?

Also, what about include/linux/device.h's struct device_driver, for
platform device drivers ?

I think there's a significant amount of work still to be done with
the u32 -> pm_message_t conversion before you can even think about
changing pm_message_t to a struct.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
