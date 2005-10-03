Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbVJCViR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbVJCViR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 17:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbVJCViR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 17:38:17 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:55206 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932442AbVJCViP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 17:38:15 -0400
Subject: Re: what's next for the linux kernel?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Vadim Lobanov <vlobanov@speakeasy.net>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051003210722.GI8548@lkcl.net>
References: <20051002204703.GG6290@lkcl.net>
	 <Pine.LNX.4.63.0510021704210.27456@cuia.boston.redhat.com>
	 <20051002230545.GI6290@lkcl.net>
	 <Pine.LNX.4.58.0510021637260.28193@shell2.speakeasy.net>
	 <20051003005400.GM6290@lkcl.net>
	 <1128367120.26992.44.camel@localhost.localdomain>
	 <20051003210722.GI8548@lkcl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 03 Oct 2005 23:05:45 +0100
Message-Id: <1128377145.26992.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-10-03 at 22:07 +0100, Luke Kenneth Casson Leighton wrote:
>  made?  _cool_.  actual hardware.  new knowledge for me.  do you know
>  of any online references, papers or stuff?  [btw just to clarify:
>  you're saying you have a NUMA bus or you're saying you have an
>  augmented SMP+NUMA+separate-parallel-message-passing-bus er .. thing]

Its a standard current Intel feature. See "mwait" in the processor
manual. The CPUs are also smart enough to do cache to cache transfers.
No special hardware no magic.

And unless I want my messages to cause interrupts and wake events (in
which case the APIC does it nicely) then any locked operation on memory
will do the job just fine. I don't need funky hardware on a system. The
first point I need funky hardware is between boards and that isn't
consumer any more.

Alan

