Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265038AbUFANud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265038AbUFANud (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 09:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265050AbUFANud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 09:50:33 -0400
Received: from gprs214-153.eurotel.cz ([160.218.214.153]:14464 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265038AbUFANua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 09:50:30 -0400
Date: Tue, 1 Jun 2004 15:50:17 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alexander Gran <alex@zodiac.dnsalias.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Enable suspend/resuming of e1000
Message-ID: <20040601135017.GB10040@elf.ucw.cz>
References: <200405281404.10538@zodiac.zodiac.dnsalias.org> <200406011504.40549@zodiac.zodiac.dnsalias.org> <20040601132429.GA5926@elf.ucw.cz> <200406011541.26425@zodiac.zodiac.dnsalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406011541.26425@zodiac.zodiac.dnsalias.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Problem with interrupts? Look if /proc/interrupts increase when you
> > ping it. You may want to try "noapic".
> > 									Pavel
> 
> it doesn't, apic is disabled, as my thinkpad does (did, have to recheck that 
> with a more recent kernel, though) not work with apic enabled.

What happens if you unload/reload module around suspend?

You may want to free_irq in suspend routine and request it back in
resume.

								Pavel

-- 
934a471f20d6580d5aad759bf0d97ddc
