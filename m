Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbVJQVLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbVJQVLd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 17:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbVJQVLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 17:11:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33501 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932331AbVJQVLc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 17:11:32 -0400
Date: Mon, 17 Oct 2005 14:11:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Andi Kleen <ak@suse.de>, kiran@scalex86.org, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, tglx@linutronix.de, shai@scalex86.org
Subject: Re: x86_64: 2.6.14-rc4 swiotlb broken
In-Reply-To: <20051017134401.3b0d861d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0510171405510.3369@g5.osdl.org>
References: <20051017093654.GA7652@localhost.localdomain> <200510171153.56063.ak@suse.de>
 <20051017153020.GB7652@localhost.localdomain> <200510171743.47926.ak@suse.de>
 <20051017134401.3b0d861d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Oct 2005, Andrew Morton wrote:
> 
> There seem to be a lot of proposed solutions floating about and I fear that
> different people will try to fix this in different ways.  Do we all agree
> that this patch is the correct solution to this problem, or is something
> more needed?

I think this will fix it. 

The naming is horrible, though, and that whole "goal" parameter is 
senseless and ugly.

It should just be a flag on whether we want DMA'able memory or not. That's 
what it _is_, it's just strangely implemented, making the code less 
readable.

Since the patch changes all the users of that third parameter _anyway_, it 
should probably be fixed to just make the parameter sane instead.

		Linus
