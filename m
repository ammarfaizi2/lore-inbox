Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265923AbTIJWq3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 18:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265924AbTIJWq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 18:46:29 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32518 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265923AbTIJWpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 18:45:47 -0400
Date: Wed, 10 Sep 2003 23:45:38 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jon Fairbairn <Jon.Fairbairn@cl.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Omnibook PCMCIA slots unusable after suspend.
Message-ID: <20030910234538.S30046@flint.arm.linux.org.uk>
Mail-Followup-To: Jon Fairbairn <Jon.Fairbairn@cl.cam.ac.uk>,
	linux-kernel@vger.kernel.org
References: <15685.1063228952@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15685.1063228952@cl.cam.ac.uk>; from Jon.Fairbairn@cl.cam.ac.uk on Wed, Sep 10, 2003 at 10:22:32PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 10:22:32PM +0100, Jon Fairbairn wrote:
> In short: I'm using an HP Ombibook 800CT, have started using
> a Carbus PCMCIA network card and am losing the card after
> suspends.

I'm only interested in the 2.6.0-test5 results.

Please run lspci -vvb twice - once when you have just booted
the machine, and once when you resume.


> Sep  4 21:39:10 graffito kernel: Linux Kernel Card Services 3.1.22
> Sep  4 21:39:10 graffito kernel:   options:  [pci] [cardbus] [pm]
> Sep  4 21:39:10 graffito kernel: PCI: Found IRQ 9 for device 00:04.0
> Sep  4 21:39:10 graffito kernel: PCI: Found IRQ 7 for device 00:04.1
> Sep  4 21:39:10 graffito kernel: Yenta IRQ list 0448, PCI irq9
> Sep  4 21:39:10 graffito kernel: Socket status: 30000020
> Sep  4 21:39:10 graffito kernel: Yenta IRQ list 0448, PCI irq7
> Sep  4 21:39:10 graffito kernel: Socket status: 30000006
> 
> but after "apm --suspend" I get the same except:
> 
> Sep  6 23:23:55 graffito kernel: Socket status: 66012d18
> ...
> Sep  6 23:23:55 graffito kernel: Socket status: 2a035c8a

It looks like the cardbus controller configuration wasn't correctly
restored.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
