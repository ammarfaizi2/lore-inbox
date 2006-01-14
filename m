Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751566AbWANJ3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566AbWANJ3e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 04:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbWANJ3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 04:29:34 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22541 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751164AbWANJ3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 04:29:33 -0500
Date: Sat, 14 Jan 2006 09:29:25 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: tmhikaru@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 'serial' cannot be built as module
Message-ID: <20060114092925.GA9443@flint.arm.linux.org.uk>
Mail-Followup-To: tmhikaru@gmail.com, linux-kernel@vger.kernel.org
References: <20060114092142.GA10844@roll>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060114092142.GA10844@roll>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2006 at 04:21:42AM -0500, tmhikaru@gmail.com wrote:
> I've already tried reporting this to the maintainer in the MAINTAINERS file,
> but received no response (mail originally sent 15'th of november)

My mail server has no record of this for the 15th - it never reached me.
Maybe you mis-copied the address?

> Essentially, the 'serial' module is not, apparently, being built when set as
> modular. I definitely know it's not being installed when I do make
> modules_install.
> 
> However, if I include it in the kernel, it works. The 'symbol' is SERIAL_8250
> according to the help in menuconfig.
> 
> I'd really like to have this fixed, as I try to reduce the size of the
> kernel that I boot, as I have to load the kernel off a floppy disk.

There's nothing which requires fixing.

If you read the help for that option, you will find that it's called
"8250" not "serial".  It also depends on serial_core.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
