Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757569AbWKXCFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757569AbWKXCFp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 21:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757568AbWKXCFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 21:05:45 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:2726 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1757566AbWKXCFo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 21:05:44 -0500
Date: Fri, 24 Nov 2006 13:05:08 +1100
From: David Chinner <dgc@sgi.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: David Chinner <dgc@sgi.com>, Arjan van de Ven <arjan@infradead.org>,
       Ingo Oeser <netdev@axxeo.de>, David Miller <davem@davemloft.net>,
       chatz@melbourne.sgi.com, linux-kernel@vger.kernel.org, xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com, netdev@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: 2.6.19-rc6 : Spontaneous reboots, stack overflows - seems to implicate xfs, scsi, networking, SMP
Message-ID: <20061124020508.GI11034@melbourne.sgi.com>
References: <9a8748490611211551v2ebe88fel2bcf25af004c338a@mail.gmail.com> <20061122.201013.112290046.davem@davemloft.net> <20061123070837.GV11034@melbourne.sgi.com> <200611231416.03387.netdev@axxeo.de> <1164307020.3147.3.camel@laptopd505.fenrus.org> <20061124005528.GF11034@melbourne.sgi.com> <9a8748490611231708w3abf295bw3c007acf5cdcf336@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490611231708w3abf295bw3c007acf5cdcf336@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2006 at 02:08:53AM +0100, Jesper Juhl wrote:
> On 24/11/06, David Chinner <dgc@sgi.com> wrote:
> >On Thu, Nov 23, 2006 at 07:37:00PM +0100, Arjan van de Ven wrote:
> >> On Thu, 2006-11-23 at 14:16 +0100, Ingo Oeser wrote:
> >> > Hi there,
> >> >
> >> > David Chinner schrieb:
> >> > > If the softirqs were run on a different stack, then a lot of these
> >>
> >> softirqs DO run on their own stack!
> >
> >So they run on a separate stack for 4k stacks on x86?
> 
> Yes, with 4K stacks there's sepperate IRQ stack.

Ok, thanks.

> >They don't run on a separate stack for 8k stacks on x86 -
> >Jesper's traces show that - so this may indicate an issue
> >with the methodology used to generate the stack overflow
> >traces inteh first place. i.e. if 4k stacks use a separate
> >stack, then most of the reported overflows are spurious
> >and would not normally occur on 4k stack systems..
> >
> 
> Well, some of the traces show that we were down to ~3K stack free with
> 8K stacks, so ~5K used. Even with 4K stacks and sepperate stack for
> IRQs we will still be uncomfortably close to the edge in those cases.

Sure - i didn't say there wasn't a problem - more just indicating
that most of the traces would not have happened on a 4k stack box so
it's harder to tell which of the traces you posted would actually
lead to an overflow.

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
