Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWJRHj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWJRHj6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 03:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWJRHj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 03:39:58 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:48093 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751302AbWJRHj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 03:39:57 -0400
Date: Wed, 18 Oct 2006 08:39:52 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Greg.Chandler@wellsfargo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Touchscreen hardware hacking/driver hacking.
Message-ID: <20061018073952.GA22967@srcf.ucam.org>
References: <E8C008223DD5F64485DFBDF6D4B7F71D020C5E83@msgswbmnmsp25.wellsfargo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E8C008223DD5F64485DFBDF6D4B7F71D020C5E83@msgswbmnmsp25.wellsfargo.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2006 at 03:30:43PM -0500, Greg.Chandler@wellsfargo.com wrote:

> I've done my homework and found that this HAS to be either serial or usb
> attached according to Fujitsu.

While the fact that Windows uses a PS/2 driver suggests that it's not 
serial, tablet devices are often connected to a UART at a non-legacy 
address. cat /sys/bus/pnp/*/id should give you a list of IDs, one of 
which may look quite obviously different to the others - Wacom devices 
tend to be WAC0004 or something, for instance. If there is one, try 
sticking it in the table in drivers/serial/8250_pnp.c and see if that 
results in a new serial device showing up.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
