Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266780AbRGLVxR>; Thu, 12 Jul 2001 17:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266795AbRGLVw4>; Thu, 12 Jul 2001 17:52:56 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:30226
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S266780AbRGLVws>; Thu, 12 Jul 2001 17:52:48 -0400
Date: Thu, 12 Jul 2001 17:51:17 -0400
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>, Lance Larsh <llarsh@oracle.com>
cc: Brian Strand <bstrand@switchmanagement.com>,
        Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2x Oracle slowdown from 2.2.16 to 2.4.4
Message-ID: <384750000.994974677@tiny>
In-Reply-To: <3B4E173E.74144A96@namesys.com>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, July 13, 2001 01:31:42 AM +0400 Hans Reiser <reiser@namesys.com> wrote:

> Lance, I would appreciate it if you would be more careful to identify that you are using O_SYNC,
> which is a special case we are not optimized for, and which I am frankly skeptical should be used at
> all by an application instead of using fsync judiciously.  It is rare that an application is
> inherently completely incapable of ever having two I/Os not be serialized, and using O_SYNC to force
> every IO to be serialized rather than picking and choosing when to use fsync, well, I have my doubts
> frankly.  If a user really needs every operation to be synchronous, they should buy a system with an
> SSD for the journal from applianceware.com (they sell them tuned to run ReiserFS), or else they are
> just going to go real slow, no matter what the FS does.
> 

There is no reason for reiserfs to be 5 times slower than ext2 at anything ;-)  
Regardless of if O_SYNC is a good idea or not.  I should have optimized the
original code for this case, as oracle is reason enough to do it.

-chris

