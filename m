Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312331AbSCYGlt>; Mon, 25 Mar 2002 01:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312325AbSCYGlj>; Mon, 25 Mar 2002 01:41:39 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:36526 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S312320AbSCYGlb>; Mon, 25 Mar 2002 01:41:31 -0500
Date: Sun, 24 Mar 2002 22:40:34 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrew Morton <akpm@zip.com.au>, Rogier Wolff <R.E.Wolff@BitWizard.nl>
cc: Linus Torvalds <torvalds@transmeta.com>, yodaiken@fsmlabs.com,
        Andi Kleen <ak@suse.de>, Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
Message-ID: <654911292.1017009632@[10.10.2.3]>
In-Reply-To: <3C9E46BD.D0BEEB2A@zip.com.au>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Frankly, all the discussion I've seen about altering page sizes
> threatens to add considerable complexity for very dubious gains.

If we don't mix page sizes, but just increase the default from
4k, does this still add a lot of complexity in your eyes? I can't
see why it would ... ?

> If someone can point at a real-world workload and say "we suck",
> and we can't fix that suckage without altering the page size then
> would that person please come forth.

I believe one of the traditional problems stated for this case is
the amount of virtual address space taken up by all the struct pages
for a machine with large amounts of memory (32-64Gb). At the moment, 
the obvious choice of architecture is still 32 bit, but maybe AMD 
Hammer will fix this ... Unless someone has a plan to move all those
up into highmem as well ....

M.

