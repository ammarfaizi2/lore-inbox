Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945987AbWBDJun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945987AbWBDJun (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 04:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945993AbWBDJun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 04:50:43 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3341 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1945991AbWBDJum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 04:50:42 -0500
Date: Sat, 4 Feb 2006 09:50:23 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, video4linux-list@redhat.com,
       linux-fbdev-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net, netdev@vger.kernel.org,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: open bugzilla reports
Message-ID: <20060204095023.GA11140@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, video4linux-list@redhat.com,
	linux-fbdev-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net, netdev@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net
References: <20060203151150.3d9aa8b3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203151150.3d9aa8b3.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 03:11:50PM -0800, Andrew Morton wrote:
> serial
> ======
> 
> [Bug 5832] Enabling ACPI Plug and Play in kernels
> 	http://bugzilla.kernel.org/show_bug.cgi?id=5832

This seems to be misfiled.  Why do you think this is a serial bug?
It seems to be talking about parallel ports.

> [Bug 5875] quad RS232 port card detected as 8,
> 	http://bugzilla.kernel.org/show_bug.cgi?id=5875

This seems to be because we have an explicit vendor/device ID listed
in 8250_pci for (according to this bug report) something which isn't
a serial device.  What I don't know is if these vendor/device IDs
also exist for something which is a serial device.  Hence, removing
them could cause more problems than keeping them.  Since it has no
effect other than causing extra ports to appear, this is low priority.

> [Bug 5942] serial driver gives up and we get IRQ3
> 	http://bugzilla.kernel.org/show_bug.cgi?id=5942

No idea what's happening here.  No one else seems to be using IRQ3,
we've disabled the interrupt at the UART, yet we get a stuck IRQ3.
Don't think it's serial related, it just happens that closing the
serial port shows it.

> [Bug 5958] CF bluetooth card oopses machine when
> 	http://bugzilla.kernel.org/show_bug.cgi?id=5958

This isn't a serial bug - it's a bluetooth ldisc bug.  I reported it
to the bluetooth folk back when it first got raised by Pavel.  However,
they seem to be completely disinterested in fixing it.

Unfortunately, there isn't a category for bt crap in bugzilla, otherwise
I'd reassign it.  Please kick the bt folk.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
