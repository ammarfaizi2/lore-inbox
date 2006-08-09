Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030466AbWHIEiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030466AbWHIEiN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 00:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030467AbWHIEiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 00:38:13 -0400
Received: from ns2.suse.de ([195.135.220.15]:9694 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030466AbWHIEiM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 00:38:12 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Jim Keniston <jkenisto@us.ibm.com>
Subject: Re: [PATCH 2/3] Kprobes: Define retval helper
References: <20060807115537.GA15253@in.ibm.com>
	<20060807120024.GD15253@in.ibm.com>
	<20060808162559.GB28647@infradead.org>
From: Andi Kleen <ak@suse.de>
Date: 09 Aug 2006 06:37:59 +0200
In-Reply-To: <20060808162559.GB28647@infradead.org>
Message-ID: <p738xlyo76g.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Mon, Aug 07, 2006 at 05:30:24PM +0530, Ananth N Mavinakayanahalli wrote:
> > From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> > 
> > Add the KPROBE_RETVAL macro to help extract the return value on
> > different architectures, while using function-return probes.
> 
> Good idea.  You should add parentheses around regs, otherwise the C
> preprocessor might bite users.  Also the shouting name is quite ugly.
> In fact it should probably go to asm/system.h or similar

The other macros like this (instruction_pointer etc) are in asm/ptrace.h

-Andi
