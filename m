Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965014AbWGEUM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbWGEUM7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 16:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965015AbWGEUM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 16:12:59 -0400
Received: from xenotime.net ([66.160.160.81]:16006 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965014AbWGEUM7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 16:12:59 -0400
Date: Wed, 5 Jul 2006 13:15:39 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: David Miller <davem@davemloft.net>
Cc: vonbrand@inf.utfsm.cl, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17 on SPARC64 compile fails
Message-Id: <20060705131539.ba3275d8.rdunlap@xenotime.net>
In-Reply-To: <20060705.113911.112605950.davem@davemloft.net>
References: <200607041417.k64EHNIT009599@laptop11.inf.utfsm.cl>
	<20060705.113911.112605950.davem@davemloft.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Jul 2006 11:39:11 -0700 (PDT) David Miller wrote:

> From: Horst von Brand <vonbrand@inf.utfsm.cl>
> Date: Tue, 04 Jul 2006 10:17:23 -0400
> 
> > Looking at the relevant file, it seems the offending functions are for PCI
> > only (and my SparcStation Ultra 1 sure doesn't have any PCI in it, so this
> > is disabled in the configuration). Maybe the #endif is too early?
> 
> Yes, I'm still thinking how to fix this.

Do you mean a generalized arch-independent fix?

> Turn CONFIG_PCI on as a workaround for now.

Good plan.  With CONFIG_PCI still off and a patch for the above
problem, next CONFIG_PCI=n issue is this one:

/var/linsrc/linux-2617-g24/arch/sparc64/kernel/time.c: In function `clock_probe':
/var/linsrc/linux-2617-g24/arch/sparc64/kernel/time.c:795: error: invalid lvalue in assignment


---
~Randy
