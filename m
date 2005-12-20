Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbVLTWcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbVLTWcx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 17:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbVLTWcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 17:32:53 -0500
Received: from [81.2.110.250] ([81.2.110.250]:25304 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932126AbVLTWcw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 17:32:52 -0500
Subject: Re: About 4k kernel stack size....
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>
In-Reply-To: <1135104210.2952.26.camel@laptopd505.fenrus.org>
References: <20051218231401.6ded8de2@werewolf.auna.net>
	 <43A77205.2040306@rtr.ca> <20051220133729.GC6789@stusta.de>
	 <170fa0d20512200637l169654c9vbe38c9931c23dfb1@mail.gmail.com>
	 <46578.10.10.10.28.1135094132.squirrel@linux1>
	 <Pine.LNX.4.61.0512201202090.27692@chaos.analogic.com>
	 <Pine.LNX.4.64.0512201157140.7859@turbotaz.ourhouse>
	 <Pine.LNX.4.61.0512201316350.27879@chaos.analogic.com>
	 <1135104210.2952.26.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Dec 2005 22:33:28 +0000
Message-Id: <1135118009.25010.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-12-20 at 19:43 +0100, Arjan van de Ven wrote:
> it involves a whole lot, like banning dma from the stack, and to make it
> swapable or kmapped you'd even need to fix all the places that put
> things like wait queues on the stack, as well as many other similar data
> structures. Staying at 4Kb is a lot easier than that ;)

If you look at something like the early unix design books its very deep
into the design of the most basic behaviour and primitives. It would be
possible to fix that in Linux but probably not worth it. The 1 page you
need for stack is now cheap.

I did look at fixing it for ELKS where a big part of the 64K DS space is
kernel stacks but fortunately something useful needed doing instead ;)

Alan

