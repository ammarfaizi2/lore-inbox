Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265219AbUFAU54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265219AbUFAU54 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 16:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265228AbUFAU5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 16:57:55 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:21515 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265218AbUFAU5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 16:57:33 -0400
Date: Tue, 1 Jun 2004 21:57:10 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] 2.6.6 synclinkmp.c
Message-ID: <20040601215710.F31301@flint.arm.linux.org.uk>
Mail-Followup-To: Paul Fulghum <paulkf@microgate.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Dave Jones <davej@redhat.com>
References: <20040527174509.GA1654@quadpro.stupendous.org> <1085769769.2106.23.camel@deimos.microgate.com> <20040528160612.306c22ab.akpm@osdl.org> <1086123061.2171.10.camel@deimos.microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1086123061.2171.10.camel@deimos.microgate.com>; from paulkf@microgate.com on Tue, Jun 01, 2004 at 03:51:02PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2004 at 03:51:02PM -0500, Paul Fulghum wrote:
> In particular, call pci_unregister_driver if driver init fails. This
> is in response to a bug report by Dave Jones.

If pci_register_driver fails, the driver is not, repeat not left
registered.  Therefore it must not be unregistered after failure
to register.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
