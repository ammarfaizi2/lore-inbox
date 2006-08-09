Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWHINSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWHINSZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 09:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWHINSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 09:18:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30444 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750761AbWHINSY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 09:18:24 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060809094516.GA17993@infradead.org> 
References: <20060809094516.GA17993@infradead.org>  <20060807115537.GA15253@in.ibm.com> <20060807120024.GD15253@in.ibm.com> <20060808162559.GB28647@infradead.org> <20060809094311.GA20050@in.ibm.com> 
To: Christoph Hellwig <hch@infradead.org>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       linux-kernel@vger.kernel.org,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Jim Keniston <jkenisto@us.ibm.com>, linux-arch@vger.kernel.org
Subject: Re: [PATCH 2/3] Kprobes: Define retval helper 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 09 Aug 2006 14:16:04 +0100
Message-ID: <26750.1155129364@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> > > Good idea.  You should add parentheses around regs, otherwise the C
> > > preprocessor might bite users.  Also the shouting name is quite ugly.
> > > In fact it should probably go to asm/system.h or similar and not have
> > > a kprobes name - it just extracts the return value from a struct pt_regs
> > > after all.
> > 
> > Done! How does this look? I added it to asm/ptrace.h so it lives along
> > with the instruction_pointer() definition.

I presume we don't care about return values that span multiple registers - for
instance if you return a 64-bit value on i386 it'll wind up in EDX:EAX.

David
