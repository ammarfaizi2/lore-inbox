Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132214AbRCVWJt>; Thu, 22 Mar 2001 17:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132216AbRCVWJa>; Thu, 22 Mar 2001 17:09:30 -0500
Received: from mg03.austin.ibm.com ([192.35.232.20]:27520 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S132214AbRCVWJX>; Thu, 22 Mar 2001 17:09:23 -0500
Message-ID: <3ABA7777.E2198DE9@austin.ibm.com>
Date: Thu, 22 Mar 2001 16:06:47 -0600
From: Dave Kleikamp <shaggy@austin.ibm.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/ioctl-number.txt
In-Reply-To: <Pine.GSO.4.21.0103221648380.5619-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Thu, 22 Mar 2001, Dave Kleikamp wrote:
> 
> > Linus,
> > I would like to reserve a block of 32 ioctl's for the JFS filesystem.
> 
> Details, please? More specifically, what kind of objects are these ioctls
> applied to?

I don't have all the details worked out yet, but the utilities to extend
and defragment the filesystem will operate on a live volume, so the
utilities will need to talk to the filesystem to move blocks, extend the
block map, etc.

The utilities will probably open the root directory and apply the ioctls
to it, unless there is a better way to do it.

-- 
David Kleikamp
IBM Linux Technology Center
