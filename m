Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268689AbTGIXQF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 19:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268690AbTGIXQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 19:16:05 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:24498
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S268689AbTGIXQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 19:16:02 -0400
Subject: Re: Fix IDE initialization when we don't probe for interrupts.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
In-Reply-To: <3F0C9251.2010107@pobox.com>
References: <200307092110.h69LAlgG027527@hera.kernel.org>
	 <3F0C9251.2010107@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057793279.7137.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 Jul 2003 00:28:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-09 at 23:08, Jeff Garzik wrote:
> > +		 * Disable device irq if we don't need to
> > +		 * probe for it. Otherwise we'll get spurious
> > +		 * interrupts during the identify-phase that
> > +		 * the irq handler isn't expecting.
> > +		 */
> > +		hwif->OUTB(drive->ctl|2, IDE_CONTROL_REG);
> 
> 
> Yeah, my driver does probing with interrupts disabled, too.
> I'm curious where interrupts are re-enabled, though?

In the command write. BTW note that there are a few devices
out there that dont honour the nIEN stuff.

IDE is such fun

