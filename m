Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbTFTDwU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 23:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbTFTDwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 23:52:20 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:19329 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S262202AbTFTDwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 23:52:19 -0400
Date: Thu, 19 Jun 2003 23:42:49 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Changes for 2.5.72
Message-ID: <20030619234249.GA31392@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
References: <20030618234418.GC333@neo.rr.com> <20030619093632.A29602@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030619093632.A29602@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 19, 2003 at 09:36:32AM +0100, Russell King wrote:
> It's purpose is trying to ensure that we don't use an interrupt which
> another serial port is using.  Presumably this is because the card does

PnP automatically does this without modification to the rule structure.

> not work, for whatever reason, when it shares interrupts with other serial
> ports.
>

I removed avoid_irq_share because the current pnp code, like the previous, does 
not allow irq sharing.  Also it corrupts the device rule structure by replacing 
it with modified values that may not apply after devices are disabled etc.
Is there a set of conditions I could follow to determine if a serial pnp device 
is capable of irq sharing, and also with which other devices can a capable 
device share an irq?  If so, I could have the resource manager handle this type 
of situation when few irqs are available.

Thanks,
Adam
