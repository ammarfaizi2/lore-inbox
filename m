Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136918AbRAHFZj>; Mon, 8 Jan 2001 00:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136916AbRAHFZ3>; Mon, 8 Jan 2001 00:25:29 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:50933 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S136917AbRAHFZT>;
	Mon, 8 Jan 2001 00:25:19 -0500
Date: Mon, 8 Jan 2001 00:25:17 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Robert Wienholt, Jr." <rwienholt@legiontech.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmap.c find_vma(), kernel 2.4.0
In-Reply-To: <Pine.SGI.4.30.0101072347130.1511-100000@legion.wienholt.net>
Message-ID: <Pine.GSO.4.21.0101080024260.2221-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Jan 2001, Robert Wienholt, Jr. wrote:

> Gentlemen,
> 
> 	I was looking through some of the memory management code today and
> came across something that may provide a minor performance boost.  I have
> included a patch below for the 2.4.0 source.
> 
> 	In the find_vma function a cached vma is checked and if that is
> not the requested vma, the linked list (unless there's an avl tree) is
> traversed from the beginning.  My thought was that if the cached vma is
> somewhere in the middle of a "long" list, and the memory address we are
				^^^^^^^^^^
No such thing. If you get many VMAs you get AVL tree and that's what is
used for search.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
