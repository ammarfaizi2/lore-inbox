Return-Path: <linux-kernel-owner+w=401wt.eu-S1751178AbWLMVqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWLMVqS (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 16:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWLMVqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 16:46:18 -0500
Received: from gate.crashing.org ([63.228.1.57]:42212 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751178AbWLMVqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 16:46:17 -0500
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <Pine.LNX.4.64.0612131252300.5718@woody.osdl.org>
References: <20061213195226.GA6736@kroah.com>
	 <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org>
	 <20061213203113.GA9026@suse.de>
	 <Pine.LNX.4.64.0612131252300.5718@woody.osdl.org>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 08:46:01 +1100
Message-Id: <1166046361.11914.198.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Btw: there's one driver we _know_ we want to support in user space, and 
> that's the X kind of direct-rendering thing. So if you can show that this 
> driver infrastructure actually makes sense as a replacement for the DRI 
> layer, then _that_ would be a hell of a convincing argument.

And even X is trying to move away from that at least partially... With
the DRI driver handling IRQs and processing command buffers... except
for cards with multiple hardware contexts, but then, we are in a case
similar to Infiniband where the HW is -designed- to have specific areas
mapped into user space, and there is still a kernel driver to arbitrate,
decide who gets what, establish those mappings, etc...

Thus X isn't even a good example :-)

Ben.


