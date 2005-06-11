Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVFKEQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVFKEQx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 00:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbVFKEQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 00:16:51 -0400
Received: from animx.eu.org ([216.98.75.249]:20928 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261467AbVFKEQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 00:16:20 -0400
Date: Sat, 11 Jun 2005 00:11:36 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: kaweth fails to work on 2.6.12-rc[56]
Message-ID: <20050611041136.GA5617@animx.eu.org>
Mail-Followup-To: Oliver Neukum <oliver@neukum.org>,
	linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20050608021140.GA28524@animx.eu.org> <200506080859.27857.oliver@neukum.org> <20050608104217.GA29490@animx.eu.org> <200506081308.39450.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506081308.39450.oliver@neukum.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
> Am Mittwoch, 8. Juni 2005 12:42 schrieb Wakko Warner:
> > > have you tried recompiling with debug enabled?
> > > It does show the status codes in the interrupt handler.
> > 
> > I have not. ?My keyboard and mouse (on a hub) are plugged in beside the
> > kaweth device so they would be on the same interrupt.
> 
> Sorry, I should be more specific. It will print out the error codes
> internal to the USB layer which are meaningful even if interrupts are shared.
> Also, are you seeing tx errors in the error count?

Unless I did something wrong, it's apparently not in the USB subsystem.

I have 2.6.12-rc3 and rc4 compiled.  Same config file on a test system.
again, rc3 works, rc4 does not.  I booted rc3 and force loaded the usb
modules from rc4 into rc3.  It tainted the kernel, but it worked.

I booted into rc4.  I do have ACPI compiled so I added acpi=off.  This did
not work, same problem as before.  I left a ping running, the usb controller
was on IRQ 9.  The test system is an old NEC notebook with an Intel chipset
(thus uhci-hcd usb1.1).  I plugged in a Belkin USB2.0 cardbus card (USB1.1
is serviced by ohci-hcd) and plugged the ethernet adapter into that.  Same
problem.

As far as controllers, ALL except 1 (The cardbus USB2.0) has been some
version of Intel.  I have tested this on 4 different systems with the same
results.  An MSI 6163 board, a Supermicro X5DA8 board, a Dell Inspiron 8100,
and the NEC Versa FX.  The Supermicro is running SMP, but I doubt that
matters.

At this time, it's late.  I'll see about reverting files from rc4 back to
rc3 to see which one causes it to work again.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
