Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVFDGnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVFDGnN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 02:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVFDGnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 02:43:13 -0400
Received: from fire.osdl.org ([65.172.181.4]:63680 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261266AbVFDGnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 02:43:05 -0400
Date: Fri, 3 Jun 2005 23:42:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: sboyce@blueyonder.co.uk
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.12-rc5/2.6.12-rc5-git8 USB problems
Message-Id: <20050603234258.50c899b6.akpm@osdl.org>
In-Reply-To: <42A0B5BC.8050205@blueyonder.co.uk>
References: <42A0B5BC.8050205@blueyonder.co.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sid Boyce <sboyce@blueyonder.co.uk> wrote:
>
> Everything works OK on 2.6.12-rc4. The joysticks are seen by lsusb and 
> the joystick test programs, but the controls do nothing in 2.6.12-rc5 
> and 2.6.12-rc5-git8.
> # js_demo
> Joystick test program.
> ~~~~~~~~~~~~~~~~~~~~~~
> Joystick 0: "CH PRODUCTS CH FLIGHT SIM YOKE USB "
> Joystick 1: "CH PRODUCTS CH PRO PEDALS USB "
> 
> # jscal /dev/js0
> Joystick has 7 axes and 13 buttons.
> Correction for axis 0 is broken line, precision is 0.
> Coeficients are: 127, 127, 5534751, 5534751
> Correction for axis 1 is broken line, precision is 0.
> Coeficients are: 127, 127, 5534751, 5534751
> Correction for axis 2 is broken line, precision is 0.
> Coeficients are: 127, 127, 5534751, 5534751
> Correction for axis 3 is broken line, precision is 0.
> Coeficients are: 127, 127, 5534751, 5534751
> Correction for axis 4 is broken line, precision is 0.
> Coeficients are: 127, 127, 5534751, 5534751
> Correction for axis 5 is broken line, precision is 0.
> Coeficients are: 0, 0, 536870912, 536870912
> Correction for axis 6 is broken line, precision is 0.
> Coeficients are: 0, 0, 536870912, 536870912
> 

The consensus from Dmitry and Vojtech is that this could be either USB or
an input layer problem, but nothing changed in [UO]HCI or HID between the
two mentioned versions.

So this is more likely a recent regression in the USB code.  Could someone
please grab it while it's fresh?

