Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267454AbUG2QRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267454AbUG2QRM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 12:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267594AbUG2QPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 12:15:24 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:32774 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S268342AbUG2QMK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 12:12:10 -0400
Date: Thu, 29 Jul 2004 18:12:03 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: dpf-lkml@fountainbay.com, jmorris@redhat.com, linux-kernel@vger.kernel.org,
       aeb@cwi.nl
Subject: Re: [PATCH] Delete cryptoloop
Message-ID: <20040729161203.GB4008@pclin040.win.tue.nl>
References: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com> <20040721230044.20fdc5ec.akpm@osdl.org> <4411.24.6.231.172.1090470409.squirrel@24.6.231.172> <20040722014649.309bc26f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040722014649.309bc26f.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2004 at 01:46:49AM -0700, Andrew Morton wrote:

> Your points can be simplified to "I don't use cryptoloop, but someone else
> might" and "we shouldn't do this in a stable kernel".
> 
> Well, I want to hear from "someone else".  If removing cryptoloop will
> irritate five people, well, sorry.  If it's 5,000 people, well maybe not.
> 
> Yes, I buy the "stable kernel" principle, but here we have an example where
> it conflicts with the advancement of the kernel, and we need to make a
> judgement call.
> 
> Actually, my most serious concern with cryptoloop is the claim that it is
> insufficiently secure.  If this is true then we'd be better off removing
> the feature altogether rather than (mis)leading our users into thinking
> that their data is secure.

The above sounds wrong / misguided.

First: "(mis)leading our users into thinking that their data is secure".
Security is not a yes/no matter. There are degrees of protection against
various possible attacks.

Second: This seems to be a discussion about cryptoloop vs dm-crypt.
But dm-crypt has the same weaknesses as cryptoloop, so from a crypto
point of view there is zero reason to switch.

If there is a reason to switch it must be elegance and correctness and
robustness of kernel implementation, together with the idea that we
do not need more than one kernel implementation of roughly speaking
the same concept. Not crypto, but just loop vs dm arguments.

Third: Announcing a date for the demise of cryptoloop seems a bit premature
at a point in time when dm-crypt is not quite usable yet.

I have the impression that cryptoloop and/or loop-aes presently are used by
more than your 5000 users.

James Morris wrote:

# Jari Ruusu ... Fruhwirth Clemens ...

So far, every time I checked the details Jari Ruusu has been right.
In the present discussion Fruhwirth Clemens showed an amazing lack
of understanding of cryptography. His threat model seems limited to
things like "chosen plaintext attack" etc.
But there are so many entirely different attacks.

# Part of the reason for dropping cryptoloop is to help dm-crypt
# mature more quickly.

A very strange reason. But maybe it fits in with dropping the idea
of a stable kernel.

# I've had some off-list email on the security of dm-crypt, and it seems
# that it does need some work.  We need to get the security right more than
# we need to worry about these other issues.

Yes.

Andries
