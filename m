Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265106AbUFAQH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265106AbUFAQH2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 12:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265095AbUFAQDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 12:03:46 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:50564 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265037AbUFAQDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 12:03:33 -0400
Date: Tue, 1 Jun 2004 18:03:30 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alexander Gran <alex@zodiac.dnsalias.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Enable suspend/resuming of e1000
Message-ID: <20040601160330.GC1899@atrey.karlin.mff.cuni.cz>
References: <200405281404.10538@zodiac.zodiac.dnsalias.org> <200406011541.26425@zodiac.zodiac.dnsalias.org> <20040601135017.GB10040@elf.ucw.cz> <200406011554.48333@zodiac.zodiac.dnsalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406011554.48333@zodiac.zodiac.dnsalias.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > What happens if you unload/reload module around suspend?
> 
> doesn't work. This was my first attempt. Seems that the pci_save_state, 
> pci_disable device is really needed.
> 
> > You may want to free_irq in suspend routine and request it back in
> > resume.
> 
> I also thought about that, however I tried to let e1000_suspend call 
> e1000_down everytime, as that calls e1000_irq_disable and free_irq. Than call 
> e1000_up in resume, as that does  request_irq e1000_irq_enable. 
> This does not work, though. Still no irqs

Try hooking it to timer interrupt and see if network then works at
least somehow.
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
