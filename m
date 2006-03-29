Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWC2OFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWC2OFa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 09:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWC2OFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 09:05:30 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53221 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750706AbWC2OF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 09:05:29 -0500
Subject: Re: serial/8250: Platform override of is_real_interrupt
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <8764lxphh8.fsf@sleipner.barco.com>
References: <8764lxphh8.fsf@sleipner.barco.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 29 Mar 2006 15:12:53 +0100
Message-Id: <1143641573.17522.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-03-29 at 14:23 +0200, Peter Korsgaard wrote:
> is_real_interrupt() unfortunately interpretes IRQ0 as meaning no
> interrupt, so performance is kinda crap.

This was discussed some time ago and the answer is "none of the below"

http://lkml.org/lkml/2005/11/21/211

Your hardware platform should be mapping interrupts so that the cookie
dev->irq is not 0 for a valid IRQ.

Alan

