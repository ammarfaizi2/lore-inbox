Return-Path: <linux-kernel-owner+w=401wt.eu-S1422778AbWLUOts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422778AbWLUOts (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 09:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422788AbWLUOts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 09:49:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52244 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422778AbWLUOtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 09:49:47 -0500
Subject: Re: Mutex debug lock failure [was Re: Bad gcc-4.1.0 leads to
	Power4 crashes... and power5 too, actually
From: Ingo Molnar <mingo@redhat.com>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Anton Blanchard <anton@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, mingo@elte.hu
In-Reply-To: <20061221010319.GE16860@austin.ibm.com>
References: <20061220004653.GL5506@austin.ibm.com>
	 <1166579210.4963.15.camel@otta> <20061220211931.GB16860@austin.ibm.com>
	 <1166650134.6673.9.camel@localhost.localdomain>
	 <20061220230342.GC16860@austin.ibm.com>
	 <1166656195.6673.23.camel@localhost.localdomain>
	 <20061220234647.GD16860@austin.ibm.com> <20061221003658.GB3048@krispykreme>
	 <20061221010319.GE16860@austin.ibm.com>
Content-Type: text/plain
Date: Thu, 21 Dec 2006 15:41:39 +0100
Message-Id: <1166712099.8869.16.camel@earth>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-20 at 19:03 -0600, Linas Vepstas wrote:
> Same kernel runs fine on power5. Although it does have patches
> applied, those very same patches boot fine when applied to a slightly
> older kernel (2.6.19-rc4).  I haven't been messing with buids or 
> pci config space (at least not intentionaly).
> 
> I'll try again with an unpatched, unmodified kernel.

there have been a number of fixes to lockdep recently - could you try
the kernel/lockdep.c file from latest -mm, does that fail too?

one possibility would be a chain-hash collision.

	Ingo

