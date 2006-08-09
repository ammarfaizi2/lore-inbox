Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbWHIPTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbWHIPTF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 11:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbWHIPTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 11:19:05 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:13022 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750749AbWHIPTB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 11:19:01 -0400
Date: Wed, 9 Aug 2006 20:50:18 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Jim Keniston <jkenisto@us.ibm.com>, linux-arch@vger.kernel.org
Subject: Re: [PATCH 2/3] Kprobes: Define retval helper
Message-ID: <20060809152018.GA17486@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <20060809094516.GA17993@infradead.org> <20060807115537.GA15253@in.ibm.com> <20060807120024.GD15253@in.ibm.com> <20060808162559.GB28647@infradead.org> <20060809094311.GA20050@in.ibm.com> <26750.1155129364@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26750.1155129364@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 02:16:04PM +0100, David Howells wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > > > Good idea.  You should add parentheses around regs, otherwise the C
> > > > preprocessor might bite users.  Also the shouting name is quite ugly.
> > > > In fact it should probably go to asm/system.h or similar and not have
> > > > a kprobes name - it just extracts the return value from a struct pt_regs
> > > > after all.
> > > 
> > > Done! How does this look? I added it to asm/ptrace.h so it lives along
> > > with the instruction_pointer() definition.
> 
> I presume we don't care about return values that span multiple registers - for
> instance if you return a 64-bit value on i386 it'll wind up in EDX:EAX.

Yes. This helper is mostly to address the common case, not the 64-bit
one.

Ananth
