Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262728AbUCSO5A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 09:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263002AbUCSO5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 09:57:00 -0500
Received: from mail.shareable.org ([81.29.64.88]:48782 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262728AbUCSO47
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 09:56:59 -0500
Date: Fri, 19 Mar 2004 14:56:55 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Anton Blanchard <anton@samba.org>
Cc: Robert_Hentosh@Dell.com, linux-kernel@vger.kernel.org
Subject: Re: spurious 8259A interrupt
Message-ID: <20040319145655.GE3897@mail.shareable.org>
References: <6C07122052CB7749A391B01A4C66D31E014BEA49@ausx2kmps304.aus.amer.dell.com> <20040319130609.GE2650@mail.shareable.org> <20040319131608.A14431@flint.arm.linux.org.uk> <20040319133942.GA3897@mail.shareable.org> <20040319140455.GB1153@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040319140455.GB1153@krispykreme>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard wrote:
> > Indeed.  But why?  What's the advantage?
> 
> We enable IRQs during IRQ processing on ppc64 for one reason. We set the
> IPI priority higher than normal IRQs so we can service it as soon as
> possible and the calling cpu can move on.

Yes: when there are interrupt priorities, then enabling them at the
CPU and masking them at the controller is required.

Is that the reason for masking 8259 interrupts on x86 Linux?
I.e. are there any special "high priority" interrupts used on x86 Linux?

Otherwise, I don't see why we have the overhead of the extra I/O
operations to mask and unmask them.  I'm sure there's a very good
reason: Linus wouldn't have written or accepted that code unless there
was a very good reason.  But I would love to know what it is!

-- Jamie
