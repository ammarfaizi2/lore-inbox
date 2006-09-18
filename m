Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751725AbWIRO5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725AbWIRO5B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 10:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751742AbWIRO5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 10:57:01 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:10910 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751717AbWIRO5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 10:57:00 -0400
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: David Miller <davem@davemloft.net>, master@sectorb.msk.ru, hawk@diku.dk,
       harry@atmos.washington.edu, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <200609181629.53949.ak@suse.de>
References: <p73k6414lnp.fsf@verdi.suse.de> <p73eju94htu.fsf@verdi.suse.de>
	 <20060918.070905.98863400.davem@davemloft.net>
	 <200609181629.53949.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 18 Sep 2006 16:19:49 +0100
Message-Id: <1158592789.6069.115.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-18 am 16:29 +0200, ysgrifennodd Andi Kleen:
> The only delay this would add would be the queueing time from the NIC
> to the softirq. Do you really think that is that bad?

If you are trying to do things like network record/playback then you
want the minimal delay. There's a reason the original timestamp code
supported the hardware setting the timestamp itself - we actually had a
separare set of logic on a board that was doing the timestamping by
watching the IRQ line of the NIC chip.

Alan

