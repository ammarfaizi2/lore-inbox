Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269346AbUIYOz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269346AbUIYOz6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 10:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269347AbUIYOz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 10:55:57 -0400
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:50877 "EHLO
	certainkey.com") by vger.kernel.org with ESMTP id S269357AbUIYOzl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 10:55:41 -0400
Date: Sat, 25 Sep 2004 10:54:44 -0400
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: linux@horizon.com
Cc: jmorris@redhat.com, cryptoapi@lists.logix.cz, tytso@mit.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [PROPOSAL/PATCH] Fortuna PRNG in /dev/random
Message-ID: <20040925145444.GW28317@certainkey.com>
References: <20040924023413.GH28317@certainkey.com> <20040924214230.3926.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040924214230.3926.qmail@science.horizon.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 09:42:30PM -0000, linux@horizon.com wrote:
> > What if I told the SHA-1 implementation in random.c right now is weaker
> > than those hashs in terms of collisions?  The lack of padding in the
> > implementation is the cause.  HASH("a\0\0\0\0...") == HASH("a") There
> > are billions of other examples.
> 
> EXCUSE me?  

...

> I could argue it's a design flaw to *include* the padding.

I was trying to point out a flaw in Ted's logic.  He said "we've recently
discoverd these hashs are weak because we found collsions.  Current
/dev/random doesn't care about this."

I certainly wasn't saying padding was a requirment.  But I was trying to
point out that the SHA-1 implementaion crrently in /dev/random by design is
collision vulnerable.  Collision resistance isn't a requirment for it's
purposes obviously.

Guess my pointing this out is a lost cause.

JLC

