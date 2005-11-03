Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030257AbVKCPRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbVKCPRB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 10:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030293AbVKCPQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 10:16:59 -0500
Received: from main.gmane.org ([80.91.229.2]:10948 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030257AbVKCPQ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 10:16:58 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Rich Walker <rw@shadow.org.uk>
Subject: Re: best way to handle LEDs
Date: Thu, 03 Nov 2005 14:26:28 +0000
Organization: Shadow Robot Company
Message-ID: <m3oe51erjf.fsf@shadow.org.uk>
References: <20051101234459.GA443@elf.ucw.cz> <20051102202622.GN23316@pengutronix.de>
 <20051102211334.GH23943@elf.ucw.cz>
 <20051102213354.GO23316@pengutronix.de>
 <38523.192.168.0.12.1130986361.squirrel@192.168.0.2>
 <20051103081522.GA21663@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 84-45-206-219.no-dns-yet.enta.net
X-Plan: Building the future with general-purpose robots
X-Plan2: mail contact@shadow.org.uk for more details and to help
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:aSmAveNoKqx2CfS/BUracfnxtXc=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> writes:

>
> I also have issues with a generic GPIO layer.  As I mentioned in the
> past, there's serious locking issues with any generic abstraction of
> GPIOs.
>
> 1. You want to be able to change GPIO state from interrupts.  This
>    implies you can not sleep in GPIO state changing functions.
>
> 2. Some GPIOs are implemented on I2C devices.  This means that to
>    change state, you must sleep.
>
> (1) and (2) are incompatible requirements, so you can not offer a
> generic interface for these GPIOs which has a consistent behaviour -
> where users of the interface know whether the function may sleep or
> may be used from interrupt context.
>

So you have a request_gpio API, where you specify usage characteristics
and get back a handle?

cheers, Rich.

-- 
rich walker         |  Shadow Robot Company | rw@shadow.org.uk
technical director     251 Liverpool Road   |
need a Hand?           London  N1 1LX       | +UK 20 7700 2487
www.shadow.org.uk/products/newhand.shtml

