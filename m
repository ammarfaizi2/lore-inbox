Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133011AbRDRQeA>; Wed, 18 Apr 2001 12:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132960AbRDRQdu>; Wed, 18 Apr 2001 12:33:50 -0400
Received: from www.resilience.com ([209.245.157.1]:22989 "EHLO
	www.resilience.com") by vger.kernel.org with ESMTP
	id <S132633AbRDRQdi>; Wed, 18 Apr 2001 12:33:38 -0400
Message-ID: <3ADDC2BB.47C7DF0C@resilience.com>
Date: Wed, 18 Apr 2001 09:37:15 -0700
From: Jeff Golds <jgolds@resilience.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc_lookup not exported
In-Reply-To: <Pine.GSO.4.21.0104172041330.9930-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Tue, 17 Apr 2001, Jeff Golds wrote:
> 
> > Hi folks.
> >
> > I noticed that proc_lookup is not exported in fs/proc/procfs_syms.c but
> > that the function is an external in include/linux/proc_fs.h.
> 
> Not every public function needs to be exported. proc_lookup() is
> shared between different files in fs/proc/, so it can't be made
> static. However, it got no business being used outside of the
> fs/proc and it certainly shouldn't be used in modules.
> 

I don't see why not. I created my own mkdir and rmdir handlers in my
module.  I'd like to use the lookup function that proc supplies instead
of supplying my own, why shouldn't I be allowed to do that?  It's not as
if I am doing something other than what normally happens:  I am
assigning inode_operations::lookup to be proc_lookup.

-Jeff


-- 
Jeff Golds
jgolds@resilience.com
