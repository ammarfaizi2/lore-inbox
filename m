Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265057AbUFAOA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265057AbUFAOA2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 10:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265067AbUFAOA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 10:00:27 -0400
Received: from pD952C7EB.dip.t-dialin.net ([217.82.199.235]:6606 "EHLO
	router.zodiac.dnsalias.org") by vger.kernel.org with ESMTP
	id S265057AbUFAOAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 10:00:11 -0400
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Enable suspend/resuming of e1000
Date: Tue, 1 Jun 2004 15:54:48 +0200
User-Agent: KMail/1.6.2
References: <200405281404.10538@zodiac.zodiac.dnsalias.org> <200406011541.26425@zodiac.zodiac.dnsalias.org> <20040601135017.GB10040@elf.ucw.cz>
In-Reply-To: <20040601135017.GB10040@elf.ucw.cz>
Cc: linux-kernel@vger.kernel.org
X-Ignorant-User: yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406011554.48333@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 1. Juni 2004 15:50 schrieben Sie:
> What happens if you unload/reload module around suspend?

doesn't work. This was my first attempt. Seems that the pci_save_state, 
pci_disable device is really needed.

> You may want to free_irq in suspend routine and request it back in
> resume.

I also thought about that, however I tried to let e1000_suspend call 
e1000_down everytime, as that calls e1000_irq_disable and free_irq. Than call 
e1000_up in resume, as that does  request_irq e1000_irq_enable. 
This does not work, though. Still no irqs

Alex


-- 
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291
