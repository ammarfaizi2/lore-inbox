Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135822AbRDZS0G>; Thu, 26 Apr 2001 14:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135853AbRDZSZ5>; Thu, 26 Apr 2001 14:25:57 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:61625 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135822AbRDZSZt>;
	Thu, 26 Apr 2001 14:25:49 -0400
Date: Thu, 26 Apr 2001 14:24:26 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <20010426201236.W819@athlon.random>
Message-ID: <Pine.GSO.4.21.0104261421050.15385-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Apr 2001, Andrea Arcangeli wrote:

> correct. I bet other fs are affected as well btw.

If only... block_read() vs. block_write() has the same race. I'm going
through the list of all wait_on_buffer() users right now.

