Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265764AbUEZSRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265764AbUEZSRw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 14:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265766AbUEZSRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 14:17:52 -0400
Received: from canuck.infradead.org ([205.233.217.7]:13841 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S265764AbUEZSRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 14:17:51 -0400
Date: Wed, 26 May 2004 14:17:34 -0400
From: hch@infradead.org
To: Andi Kleen <ak@muc.de>
Cc: Ingo Molnar <mingo@elte.hu>, andrea@suse.de, linux-kernel@vger.kernel.org,
       arjanv@redhat.com
Subject: Re: 4k stacks in 2.6
Message-ID: <20040526181734.GA30093@infradead.org>
Mail-Followup-To: hch@infradead.org, Andi Kleen <ak@muc.de>,
	Ingo Molnar <mingo@elte.hu>, andrea@suse.de,
	linux-kernel@vger.kernel.org, arjanv@redhat.com
References: <1ZQpn-1Rx-1@gated-at.bofh.it> <1ZQz8-1Yh-15@gated-at.bofh.it> <1ZRFf-2Vt-3@gated-at.bofh.it> <203Zu-4aT-15@gated-at.bofh.it> <m3aczvxpe6.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3aczvxpe6.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2004 at 03:57:05PM +0200, Andi Kleen wrote:
> Ingo Molnar <mingo@elte.hu> writes:
> >
> > do you realize that the 4K stacks feature also adds a separate softirq
> > and a separate hardirq stack? So the maximum footprint is 4K+4K+4K, with
> 
> A nice combination would be 8K process stacks with separate irq stacks on 
> i386.
> 
> Any chance the CONFIGs for those two could be split? 

Any reason not to enable interrupt stacks unconditionally and leave
the stack size choice to the user?

