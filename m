Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130004AbRBYXrO>; Sun, 25 Feb 2001 18:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130017AbRBYXrF>; Sun, 25 Feb 2001 18:47:05 -0500
Received: from asbestos.linuxcare.com.au ([203.17.0.30]:60155 "EHLO halfway")
	by vger.kernel.org with ESMTP id <S130004AbRBYXqt>;
	Sun, 25 Feb 2001 18:46:49 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New net features for added performance 
In-Reply-To: Your message of "25 Feb 2001 00:48:35 BST."
             <oupsnl3k5gs.fsf@pigdrop.muc.suse.de> 
Date: Sun, 25 Feb 2001 22:49:39 +1100
Message-Id: <E14WzgK-00023V-00@halfway>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <oupsnl3k5gs.fsf@pigdrop.muc.suse.de> you write:
> Jeff Garzik <jgarzik@mandrakesoft.com> writes:
> 
> > Advantages:  A de-allocation immediately followed by a reallocation is
> > eliminated, less L1 cache pollution during interrupt handling. 
> > Potentially less DMA traffic between card and host.
> > 
> > Disadvantages?
> 
> You need a new mechanism to cope with low memory situations because the 
> drivers can tie up quite a bit of memory (in fact you gave up unified
> memory management). 

Also, you still need to "clean" the skb (it can hold device and nfct
references).

Rusty.
--
Premature optmztion is rt of all evl. --DK
