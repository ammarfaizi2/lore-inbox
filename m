Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbVKGDm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbVKGDm6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 22:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbVKGDm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 22:42:58 -0500
Received: from gate.crashing.org ([63.228.1.57]:7401 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932383AbVKGDm5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 22:42:57 -0500
Subject: Re: Fwd: [RFC] IRQ type flags
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1131321802.1212.75.camel@localhost.localdomain>
References: <20051106084012.GB25134@flint.arm.linux.org.uk>
	 <1131316897.1212.61.camel@localhost.localdomain>
	 <20051106221643.GB6274@flint.arm.linux.org.uk>
	 <1131317998.1212.63.camel@localhost.localdomain>
	 <20051106224225.GC6274@flint.arm.linux.org.uk>
	 <1131321802.1212.75.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 07 Nov 2005 14:40:36 +1100
Message-Id: <1131334837.5229.166.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I was thinking that specifying neither would imply 'don't care' or
> 'system default'. That would mean existing drivers just worked and
> driver authors who didnt care need take no specific action.

Not only that, but as I wrote in my other mail, on some archs, the
system already got all the necessary triggers from the firmware and has
setup sane defaults, in which case it's more up to the driver to either
not care or adapt to what was set (some IRQ controllers don't support
all possible settings for example).

I would also expect PCI drivers to always pass default (rather than
explicitly level negative)

Ben.


