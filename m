Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268813AbUHLVm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268813AbUHLVm2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 17:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268807AbUHLVjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 17:39:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12929 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268804AbUHLVeZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 17:34:25 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16667.57829.212177.183803@segfault.boston.redhat.com>
Date: Thu, 12 Aug 2004 17:32:21 -0400
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org,
       Stelian Pop <stelian@popies.net>, jgarzik@pobox.com
Subject: Re: [patch] fix netconsole hang with alt-sysrq-t
In-Reply-To: <20040812211841.GB17907@granada.merseine.nu>
References: <16659.56343.686372.724218@segfault.boston.redhat.com>
	<20040806195237.GC16310@waste.org>
	<16659.58271.979999.616045@segfault.boston.redhat.com>
	<20040806202649.GE16310@waste.org>
	<16667.55966.317888.504243@segfault.boston.redhat.com>
	<20040812211841.GB17907@granada.merseine.nu>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: [patch] fix netconsole hang with alt-sysrq-t; Muli Ben-Yehuda <mulix@mulix.org> adds:

mulix> On Thu, Aug 12, 2004 at 05:01:18PM -0400, Jeff Moyer wrote:
>> So how do you want to deal with this case?  We could do something like:
>> 
>> int cpu = smp_processor_id();

mulix> That doesn't look right, unless I'm missing something, you could get
mulix> preempted here (between the smp_processor_id() and the
mulix> local_irq_save() and end up with 'cpu' pointing to the wrong CPU.

Would a preempt_disable() be too hideous?  Other suggestions?

-Jeff
