Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263561AbUAPA2f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 19:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263622AbUAPA2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 19:28:34 -0500
Received: from smtp2.fre.skanova.net ([195.67.227.95]:29160 "EHLO
	smtp2.fre.skanova.net") by vger.kernel.org with ESMTP
	id S263561AbUAPA0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 19:26:22 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@colin2.muc.de>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, jh@suse.cz,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add noinline attribute
References: <20040114083114.GA1784@averell>
	<Pine.LNX.4.58.0401141519260.4500@evo.osdl.org>
	<20040115074834.GA38796@colin2.muc.de>
	<Pine.LNX.4.58.0401151448200.2597@evo.osdl.org>
From: Peter Osterlund <petero2@telia.com>
Date: 16 Jan 2004 01:26:10 +0100
In-Reply-To: <Pine.LNX.4.58.0401151448200.2597@evo.osdl.org>
Message-ID: <m2u12wn3h9.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Wed, 15 Jan 2004, Andi Kleen wrote:
> > 
> > That's fine for me. In fact I did this some time ago on x86-64 when I 
> > ran into similar problems. Here's a port of the x86-64 sort function.
> 
> Ugh. Can't we just make this be generic code (and that means calling it in
> the module loading code too..)?
> 
> As to bubble sort (which is fine for something that is 99% sorted anyway),
> isn't it better to continue pushing the entry down when you find something 
> out of order? That way you don't have to repeat the whole scan, you just 
> continue with the next entry once the unsorted entry has percolated to its 
> place (ie keep entries "0..n-1" sorted at all times). That should make the 
> code cleaner too.

Yes, that algorithm is called insertion sort and is already
implemented in the ppc arch.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
