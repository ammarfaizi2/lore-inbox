Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbULABNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbULABNZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 20:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbULABMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 20:12:55 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:37536 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261252AbULABKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 20:10:39 -0500
Date: Wed, 1 Dec 2004 02:10:46 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Benoit Boissinot <bboissin@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Mike Kirk <mike.kirk@sympatico.ca>
Subject: Re: 2.6.10-rc2-mm3 [was: Re: 2.6.9-rc2: "kernel BUG at mm/rmap.c:473!"]
Message-ID: <20041201011046.GY4365@dualathlon.random>
References: <20041130150639.GA11294@ens-lyon.fr> <Pine.LNX.4.44.0412010028460.3344-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0412010028460.3344-100000@localhost.localdomain>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2004 at 12:49:39AM +0000, Hugh Dickins wrote:
> The atomic counter underflow in do_exit does suggest corruption
> elsewhere than in transcode's page table (though I'm not at all
> sure that is corrupt) - as always, it is worth giving memtest86
> a thorough run to check your memory.

Transcode should be 99% cpu bound in userspace and it shouldn't be
kernel intensive at all. It's one of the few desktop apps 99% cpu bound,
in turn the reasoning that the cpu is overheating sounds reasonable to
me. It might also be using sse2 to compress faster etc...
