Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265766AbUEZSYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265766AbUEZSYw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 14:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265767AbUEZSYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 14:24:52 -0400
Received: from colin2.muc.de ([193.149.48.15]:30483 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S265766AbUEZSYv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 14:24:51 -0400
Date: 26 May 2004 20:24:50 +0200
Date: Wed, 26 May 2004 20:24:50 +0200
From: Andi Kleen <ak@muc.de>
To: hch@infradead.org, Andi Kleen <ak@muc.de>, Ingo Molnar <mingo@elte.hu>,
       andrea@suse.de, linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: 4k stacks in 2.6
Message-ID: <20040526182450.GA16219@colin2.muc.de>
References: <1ZQpn-1Rx-1@gated-at.bofh.it> <1ZQz8-1Yh-15@gated-at.bofh.it> <1ZRFf-2Vt-3@gated-at.bofh.it> <203Zu-4aT-15@gated-at.bofh.it> <m3aczvxpe6.fsf@averell.firstfloor.org> <20040526181734.GA30093@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040526181734.GA30093@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2004 at 02:17:34PM -0400, hch@infradead.org wrote:
> On Wed, May 26, 2004 at 03:57:05PM +0200, Andi Kleen wrote:
> > Ingo Molnar <mingo@elte.hu> writes:
> > >
> > > do you realize that the 4K stacks feature also adds a separate softirq
> > > and a separate hardirq stack? So the maximum footprint is 4K+4K+4K, with
> > 
> > A nice combination would be 8K process stacks with separate irq stacks on 
> > i386.
> > 
> > Any chance the CONFIGs for those two could be split? 
> 
> Any reason not to enable interrupt stacks unconditionally and leave
> the stack size choice to the user?

It will probably still break some other patches, like debuggers.

Given that the kernel is supposed to be stable I would not change
it unconditionally in 2.6. Maybe in 2.7.

-Andi
