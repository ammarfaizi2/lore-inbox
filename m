Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbUCCCsl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 21:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbUCCCsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 21:48:41 -0500
Received: from ns.suse.de ([195.135.220.2]:12940 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262333AbUCCCsh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 21:48:37 -0500
To: Peter Williams <peterw@aurema.com>
Cc: linux-kernel@vger.kernel.org, johnl@aurema.com
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <fa.fi4j08o.17nchps@ifi.uio.no.suse.lists.linux.kernel>
	<fa.ctat17m.8mqa3c@ifi.uio.no.suse.lists.linux.kernel>
	<yydjishqw10p.fsf@galizur.uio.no.suse.lists.linux.kernel>
	<40426E1C.8010806@aurema.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 03 Mar 2004 03:48:36 +0100
In-Reply-To: <40426E1C.8010806@aurema.com.suse.lists.linux.kernel>
Message-ID: <p73k7224pdn.fsf@brahms.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams <peterw@aurema.com> writes:

One comment on the patches: could you remove the zillions of numerical Kconfig
options and just make them sysctls? I don't think it makes any sense 
to require a reboot to change any of that. And the user is unlikely
to have much idea yet on what he wants on them while configuring.

I really like the reduced scheduler complexity part of your patch BTW.
IMHO the 2.6 scheduler's complexity has gotten out of hand and it's great
that someone is going into the other direction with a simple basic design.

For more wide spread testing it would be useful if you could do 
a more minimal less intrusive patch with less configuration 
(e.g. only allow tuning via nice, not via other means). This would
be mainly to test your patch on more workloads without any hand tuning,
which is the most important use case.

-Andi
