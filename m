Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263494AbRFFIsL>; Wed, 6 Jun 2001 04:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263703AbRFFIr4>; Wed, 6 Jun 2001 04:47:56 -0400
Received: from green.csi.cam.ac.uk ([131.111.8.57]:2284 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S263494AbRFFIrl>; Wed, 6 Jun 2001 04:47:41 -0400
Date: Wed, 6 Jun 2001 09:43:30 +0100 (BST)
From: James Sutherland <jas88@cam.ac.uk>
X-X-Sender: <jas88@green.csi.cam.ac.uk>
To: Chris Wedgwood <cw@f00f.org>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        "David S. Miller" <davem@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, <bjornw@axis.com>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: Missing cache flush.
In-Reply-To: <20010606112419.A24800@metastasis.f00f.org>
Message-ID: <Pine.SOL.4.33.0106060942160.14836-100000@green.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Jun 05, 2001 at 07:01:28PM +0200, Jamie Lokier wrote:
>
>     Whether this works depends on the cache line replacement policy.
>     It will always work with LRU, for example, and probably
>     everything else that exists.  But it is not guaranteed, is it?

LFU, if used, wouldn't be flushed by this trick... Potentially, you could
have a slice of kernel interrupt handler sitting in a cache line, having
been accessed $BIG_NUMBER times... (Does anything actually use this
approach, though???)


James.

