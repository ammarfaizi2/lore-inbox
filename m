Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265373AbTCCX5E>; Mon, 3 Mar 2003 18:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265711AbTCCX5E>; Mon, 3 Mar 2003 18:57:04 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32529 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265373AbTCCX5C>; Mon, 3 Mar 2003 18:57:02 -0500
Date: Tue, 4 Mar 2003 00:07:27 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Mikael Pettersson <mikpe@user.it.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.63: Can't handle class_mask in drivers/serial/8250_pci
Message-ID: <20030304000727.A3898@flint.arm.linux.org.uk>
Mail-Followup-To: Mikael Pettersson <mikpe@user.it.uu.se>,
	linux-kernel@vger.kernel.org
References: <200303032334.h23NYf6X012570@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200303032334.h23NYf6X012570@harpo.it.uu.se>; from mikpe@user.it.uu.se on Tue, Mar 04, 2003 at 12:34:41AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 04, 2003 at 12:34:41AM +0100, Mikael Pettersson wrote:
> Compiling 2.5.63 with PCI enabled and SERIAL_8250 as a module
> generates these warnings from scripts/file2alias:do_pci_entry(),
> via scripts/modpost:
> 
> *** Warning: Can't handle class_mask in drivers/serial/8250_pci:0001
> *** Warning: Can't handle class_mask in drivers/serial/8250_pci:0002
> *** Warning: Can't handle class_mask in drivers/serial/8250_pci:0004
> *** Warning: Can't handle class_mask in drivers/serial/8250_pci:0008
> *** Warning: Can't handle class_mask in drivers/serial/8250_pci:FFFF00
> *** Warning: Can't handle class_mask in drivers/serial/8250_pci:FFFF00
> *** Warning: Can't handle class_mask in drivers/serial/8250_pci:FFFF00
> 
> Non-fatal, but something's obviously not right.
> 
> Who maintains drivers/serial/, Theodore Ts'o or Russell King?

Me, but the entries are correct.  If we're unable to support a class
mask of 0xffff00, a fair amount of stuff is going to break, since it'll
match the programming interface byte as well.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

