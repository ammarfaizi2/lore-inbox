Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131472AbRDZTGN>; Thu, 26 Apr 2001 15:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135206AbRDZTGD>; Thu, 26 Apr 2001 15:06:03 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:261 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S131472AbRDZTFw>; Thu, 26 Apr 2001 15:05:52 -0400
Date: Thu, 26 Apr 2001 15:00:38 -0400
From: Chris Mason <mason@suse.com>
To: Alexander Viro <viro@math.psu.edu>, Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
Message-ID: <235100000.988311638@tiny>
In-Reply-To: <Pine.GSO.4.21.0104261421050.15385-100000@weyl.math.psu.edu>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, April 26, 2001 02:24:26 PM -0400 Alexander Viro
<viro@math.psu.edu> wrote:

> 
> 
> On Thu, 26 Apr 2001, Andrea Arcangeli wrote:
> 
>> correct. I bet other fs are affected as well btw.
> 
> If only... block_read() vs. block_write() has the same race. I'm going
> through the list of all wait_on_buffer() users right now.
> 

Looks like reiserfs has it too when allocating tree blocks, but it should
be harder to hit.  The fix should be small but it will take me a bit to
make sure it doesn't affect the rest of the balancing code.

-chris

