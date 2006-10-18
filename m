Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751471AbWJRMNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbWJRMNu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 08:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbWJRMNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 08:13:50 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:62852 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751471AbWJRMNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 08:13:49 -0400
Subject: Re: [PATCH] Undeprecate the sysctl system call
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Cal Peake <cp@absolutedigital.net>, Andrew Morton <akpm@osdl.org>,
       Randy Dunlap <rdunlap@xenotime.net>, Jan Beulich <jbeulich@novell.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <p737iyxdfiz.fsf@verdi.suse.de>
References: <453519EE.76E4.0078.0@novell.com>
	 <20061017091901.7193312a.rdunlap@xenotime.net>
	 <Pine.LNX.4.64.0610171401130.10587@lancer.cnet.absolutedigital.net>
	 <1161123096.5014.0.camel@localhost.localdomain>
	 <20061017150016.8dbad3c5.akpm@osdl.org>
	 <Pine.LNX.4.64.0610171853160.25484@lancer.cnet.absolutedigital.net>
	 <m1wt6y70kg.fsf@ebiederm.dsl.xmission.com>
	 <1161169330.9363.11.camel@localhost.localdomain>
	 <p737iyxdfiz.fsf@verdi.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Oct 2006 13:15:41 +0100
Message-Id: <1161173741.9363.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-10-18 am 13:33 +0200, ysgrifennodd Andi Kleen:
> You call that numerical name space neat?  IMHO it was a totally bogus
> idea. There is already a perfectly fine file system name space, why
> add another one?

The sysctl number space came first and when it appeared it was neat

> Anyways, imho the right solution is to remove the numerical
> sysctl infrastructure (including most of sysctl.h), but keep
> sys_sysctl() with a small mapping table that maps the few
> numerical sysctls (mostly KERN_VERSION) that are actually used to 
> path names internally. The rest should be ENOSYS.

More work for less compatibility, that doesn't sound very clever.

Alan

