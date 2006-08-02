Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbWHBC7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWHBC7k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 22:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWHBC7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 22:59:40 -0400
Received: from cantor.suse.de ([195.135.220.2]:24295 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751084AbWHBC7j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 22:59:39 -0400
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@osdl.org>,
       Ian Pratt <ian.pratt@xensource.com>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Chris Wright <chrisw@sous-sol.org>,
       Christoph Lameter <clameter@sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 8 of 13] Add a bootparameter to reserve high linear address space for hypervisors
References: <0adfc39039c79e4f4121.1154462446@ezr>
	<200608012347.20556.ak@suse.de>
	<1154479684.2570.14.camel@localhost.localdomain>
From: Andi Kleen <ak@suse.de>
Date: 02 Aug 2006 04:59:32 +0200
In-Reply-To: <1154479684.2570.14.camel@localhost.localdomain>
Message-ID: <p73lkq7zvu3.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> writes:
> 
> I only implemented parse_early_param two years ago; maybe it is time for
> i386 to use it...

Problem is that it's too late. Some of the stuff is already needed
in setup_arch. You would need to move it before it first.

Unfortunately touching the order might cause very subtle problem
on other architectures - this tends to be fragile.

-Andi
