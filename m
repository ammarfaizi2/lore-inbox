Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbULIQKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbULIQKR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 11:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbULIQKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 11:10:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:34011 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261537AbULIQKN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 11:10:13 -0500
Date: Thu, 9 Dec 2004 08:09:50 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: Re: VM86 interrupt emulation breakage and FIXes for 2.6.x kernel
 series
In-Reply-To: <200412091459.51583.pisa@cmp.felk.cvut.cz>
Message-ID: <Pine.LNX.4.58.0412090801360.31040@ppc970.osdl.org>
References: <200412091459.51583.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 Dec 2004, Pavel Pisa wrote:
> 
> because there is no maintainer specified for VM86 subsystem, I bother you all.
> 
> There is is problem in VM86 emulation code. It returns IRQ_NONE for each
> handler invocation.

Yes. I realized how broken it was when I did the conversion, but I didn't 
have anybody that I knew of that actually _used_ it, so I didn't bother 
trying to fix it.

It's been broken for a long time, even before the IRQ_NONE/IRQ_HANDLED
fixes (the disable/enable counting was out of whack).

Your fix looks fine. You must be one of a _very_ small group of people 
using this. Thanks,

			Linus
