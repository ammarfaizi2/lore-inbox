Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132552AbRDWXG4>; Mon, 23 Apr 2001 19:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132516AbRDWXFt>; Mon, 23 Apr 2001 19:05:49 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:2257 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S132537AbRDWXDq>;
	Mon, 23 Apr 2001 19:03:46 -0400
Message-ID: <3AE4B4D1.A4A17FD6@mandrakesoft.com>
Date: Mon, 23 Apr 2001 19:03:45 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.4.4.3: 3rdparty driver support for kbuild
In-Reply-To: <12679.988066656@ocs3.ocs-net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> On Sun, 15 Apr 2001 05:25:24 -0400,
> Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
> >The attached patch, against kernel 2.4.4-pre3, adds a feature I call
> >"3rd-party support."
> 
> Already covered by my 2.5 makefile rewrite[1] which has explicit
> support for third party kernel source.  Shadow trees are designed
> specifically to handle this problem.  I don't see the point of adding a
> script which will only be used in 2.4, especially when the vendors
> would have to change their tarball format for 2.5 formats.
> 
> (3) The kernel is constructed from multiple source trees and built in a
>     separate object tree.

I don't see how multiple source trees can be merged automatically with
100% accuracy.  

What happens when you build with linus-tree, xfs-tree, and
reiserfs-tree, and both XFS and reiserfs touch struct file_operations,
in conflicting ways?  It takes human intervention to figure that stuff
out and resolve such conflicts.

If you support multiple source trees -> single build tree, it sounds
like are you trying to integrate cvs/diff/similar into the kernel build
system, which is whacky...

	Jeff



-- 
Jeff Garzik      | The difference between America and England is that
Building 1024    | the English think 100 miles is a long distance and
MandrakeSoft     | the Americans think 100 years is a long time.
                 |      (random fortune)
