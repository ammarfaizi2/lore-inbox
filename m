Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135443AbRDRWn0>; Wed, 18 Apr 2001 18:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135450AbRDRWnQ>; Wed, 18 Apr 2001 18:43:16 -0400
Received: from www.resilience.com ([209.245.157.1]:41171 "EHLO
	www.resilience.com") by vger.kernel.org with ESMTP
	id <S135443AbRDRWm4>; Wed, 18 Apr 2001 18:42:56 -0400
Message-ID: <3ADE194C.ED9C1CAA@resilience.com>
Date: Wed, 18 Apr 2001 15:46:36 -0700
From: Jeff Golds <jgolds@resilience.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc_lookup not exported
In-Reply-To: <Pine.GSO.4.21.0104181747460.15153-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Wed, 18 Apr 2001, Jeff Golds wrote:
> 
> > I don't see why not. I created my own mkdir and rmdir handlers in my
> > module.  I'd like to use the lookup function that proc supplies instead
> > of supplying my own, why shouldn't I be allowed to do that?  It's not as
> > if I am doing something other than what normally happens:  I am
> > assigning inode_operations::lookup to be proc_lookup.
> 
> Use ramfs as a model; procfs is not well-suited for that sort of work.
> 

I don't want to cause trouble, but it sure seems like the kernel source
tree could be better organized.  For example, in every C application I
have seen, global header files specify interfaces into the relevant
module and local header files are for intramodule use only.  In the
Linux kernel tree, ALL the header files are global, thus, you can't
easily tell what things are exported and what is not as you can't just
look at the header file.  Isn't this against what open source is about: 
Requiring inside knowledge about the code?

I don't understand why local header files are not used.  It's easy to
prevent people from using the wrong functions, simply make a script that
checks to see if people are including the local header files from other
modules and return an error if they are.  This could be checked at build
time.

Maybe this is all old news, I am rather new to the Linux kernel, but
perhaps this is something that could be addressed in future (2.5?)
versions of the kernel.

-Jeff

-- 
Jeff Golds
jgolds@resilience.com
