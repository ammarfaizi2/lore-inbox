Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268447AbUH3OnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268447AbUH3OnB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 10:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268453AbUH3OnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 10:43:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22734 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268447AbUH3OmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 10:42:18 -0400
Date: Mon, 30 Aug 2004 10:42:11 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Jean-Luc Cooke <jlcooke@certainkey.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: CryptoAPI: schedual while atomic
In-Reply-To: <20040830132453.GG11307@certainkey.com>
Message-ID: <Xine.LNX.4.44.0408301040200.21963-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Aug 2004, Jean-Luc Cooke wrote:

> While I was playing with using the CryptoAPI in /dev/random for my own
> purposes, I noticed that I was getting quite a few "schedual while atomic!"
> console messages.

Where is the code which caused this?  The transforms are safe to use (but
not allocate) in process and softirq contexts.

> Talking with Michal Ludvig, I seem to think that a "!is_atomic()" check
> inside crypto_yield() or passing a flag during crypto_alloc_tfm() would make
> a lot of sense.
> 
> This may be more directed at James Morris, but here it goes:
> 
> Can we have some logic to either check for or turn off crypto_yield()'s in
> crypto/internal.h's crypto_yield() ?

Why?  This should not be needed.


- James
-- 
James Morris
<jmorris@redhat.com>


