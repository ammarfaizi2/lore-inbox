Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266427AbUGOWff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266427AbUGOWff (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 18:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266434AbUGOWfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 18:35:34 -0400
Received: from palrel13.hp.com ([156.153.255.238]:29402 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S266427AbUGOWfd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 18:35:33 -0400
Date: Thu, 15 Jul 2004 15:35:28 -0700
To: Andi Kleen <ak@muc.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, netdev@oss.sgi.com,
       irda-users@lists.sourceforge.net, jt@hpl.hp.com,
       the_nihilant@autistici.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Drop ISA dependencies from IRDA drivers
Message-ID: <20040715223528.GA4645@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <m34qo96x8m.fsf@averell.firstfloor.org> <40F6B547.7050800@pobox.com> <20040715205001.GA2527@muc.de> <40F6F076.2080001@pobox.com> <20040715215552.GA46635@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040715215552.GA46635@muc.de>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2004 at 11:55:52PM +0200, Andi Kleen wrote:
> 
> Anyways, this is only tangential to the original reason for the patch.
> Can you please drop the bogus ISA dependencies. Jean has clearly stated
> that the drivers have nothing to do with ISA itself.

	Andy, I never said that, please quote me accurately. I
personally don't have strong opinions on whether those drivers should
be tagged with CONFIG_ISA or not, but those hardware are definitely
mapped on the ISA bus.

	Also, I just had a report of an user having a problem with the
removal of isa_virt_to_bus on x86-64 :
		http://bugme.osdl.org/show_bug.cgi?id=3073
	Depending on how this bug pans out, we *may* have to revert
the patch and brings back isa_virt_to_bus.

	Regards,

	Jean
