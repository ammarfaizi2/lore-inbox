Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266911AbRG1QSX>; Sat, 28 Jul 2001 12:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266919AbRG1QSN>; Sat, 28 Jul 2001 12:18:13 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:4593 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S266907AbRG1QSC>;
	Sat, 28 Jul 2001 12:18:02 -0400
Date: Sat, 28 Jul 2001 12:18:02 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Mason <mason@suse.com>
cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [RFC] using writepage to start io
In-Reply-To: <76740000.996336108@tiny>
Message-ID: <Pine.GSO.4.21.0107281210460.11772-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Sat, 28 Jul 2001, Chris Mason wrote:

> 
> Hello everyone,
> 
> This is an rfc only, as the code has only been _lightly_ tested.  I'll
> do more tests/benchmarks next week.
> 
> This patch changes fs/buffer.c to use writepage to start i/o,
> instead of writing buffers directly.  It also changes refile_buffer
> to mark the page dirty when marking buffers dirty.

->writepage() unlocks the page upon completion. How do you deal with that?

