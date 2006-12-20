Return-Path: <linux-kernel-owner+w=401wt.eu-S1030278AbWLTTGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030278AbWLTTGH (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 14:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbWLTTGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 14:06:07 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4002 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030278AbWLTTGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 14:06:06 -0500
Date: Wed, 20 Dec 2006 19:05:57 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Add support for Korenix 16C950-based PCI cards
Message-ID: <20061220190557.GA13129@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20061213144546.GA23951@dyn-67.arm.linux.org.uk> <20061220133310.GA28555@pazke.donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061220133310.GA28555@pazke.donpac.ru>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 04:33:10PM +0300, Andrey Panin wrote:
> On 347, 12 13, 2006 at 02:45:46PM +0000, Russell King wrote:
> > Linus, Andrew,
> > 
> > This patch adds initial support to 8250-pci for the Korenix Jetcard PCI
> > serial cards.  The JC12xx cards are standard RS232-based serial cards
> > utilising the Oxford 16C950 device.
> > 
> > The JC14xx are RS422/RS485-based cards, but in order for these to be
> > supported natively, we will need additional tweaks to the 8250 layers
> > so we can specify some values for the 950's registers.  Hence, these
> > two entries are commented out.
> 
> IIRC 16c950 just need two bits in ACR set properly. Will attached patch 
> do the trick ?

I, too, also have a patch which does something similar.  I'm going to
hold off on that until post 2.6.20 though, especially as I have no
way to test it.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
