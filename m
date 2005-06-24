Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262967AbVFXBD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262967AbVFXBD2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 21:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262969AbVFXBD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 21:03:28 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:31225 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S262967AbVFXBDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 21:03:07 -0400
Message-ID: <42BB5BC3.7000902@namesys.com>
Date: Thu, 23 Jun 2005 18:02:59 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Masover <ninja@slaphack.com>
CC: Horst von Brand <vonbrand@inf.utfsm.cl>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl> <42BB31E9.50805@slaphack.com>
In-Reply-To: <42BB31E9.50805@slaphack.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover wrote:

>
>
> But, there are some things Reiser does better and faster than ext3, even
> if you don't count file-as-directory and other toys.  There's nothing
> ext3 does better than Reiser, unless you count the compatibility with
> random bootloaders and low-level tools.

In fairness, there are some things that I am aware of.  In Reiser4 fsync
performance needs optimizing, truly random modifications and anything
else that write twice logging is best for needs optimizing, workloads
dominated by dirtying more mmap'd pages than can fit into RAM need
optimizing.

>
> >>                                               Not everyone will want
> >>to reformat at once, but as the reiser4 code matures and proves itself
> >>(even more than it already has),
>
>
> >I for one have seen mainly people with wild claims that it will make
> their
> >machines much faster, and coming back later asking how they can recover
> >their thrashed partitions...
>
>
> You know how many I've had thrashed on Reiser4?  Two.  The first one was
> with a VERY early alpha/beta, and the second one was when I dropped a
> laptop and the disk failed.
>
> And it does make certain things faster.  For one thing, "emerge sync" on
> Gentoo is twice to four times as fast, and /usr/portage is 75% as big,
> as on ReiserFS (3).

Wow.  You know, Nikita complains about my benchmarks, but what I usually
hear from users is that their performance when they use their favorite
app is mostly similar to my benchmarks.

I would be really happy if our compression code was working before we
went in.  Half the space and thus twice the speed to disk.  Edward could
use some help with it.  If only we could work on that plus fsync plus
mmap dirtying plus random modification optimized journaling rather than
these flamefests. 

Hans
