Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030729AbWI0T5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030729AbWI0T5F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 15:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030731AbWI0T5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 15:57:04 -0400
Received: from ns2.suse.de ([195.135.220.15]:37556 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030729AbWI0T5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 15:57:01 -0400
To: "Om Narasimhan" <om.turyx@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HPET : timer routing setup with Legacy Routing Replacement bit set
References: <6b4e42d10609271046x216e5175g59cb42f12e067c82@mail.gmail.com>
From: Andi Kleen <ak@suse.de>
Date: 27 Sep 2006 21:56:59 +0200
In-Reply-To: <6b4e42d10609271046x216e5175g59cb42f12e067c82@mail.gmail.com>
Message-ID: <p73ac4ljd6c.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Om Narasimhan" <om.turyx@gmail.com> writes:

> Hi,
> I am working with a new bios for a server our company build. I am
> confused about the routing of the timer and arch/x86_64/kernel/time.c
> irq setup.
> 
> HPET specification states that if Legacy routing replacement enable
> bit is set, IRQ0 should not be connected to PIN0 of IOAPIC, and IRQ0
> should not generate any interrupts. But in the kernel code, timer is
> hard coded to irq0 (arch/x86_64/kernel/time.c : time_init(), calls
> setup_irq(0,&irq0). 0 being the irq number)
> 
> My question is, should it not be IRQ2 if HPET is enabled and Legacy
> Routing Replacement bit is enbaled?

Legacy Routing Replacement is currently not supported.

Feel free to contribute a patch supporting it though.

-Andi
