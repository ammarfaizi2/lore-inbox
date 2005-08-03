Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262299AbVHCOo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbVHCOo7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 10:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262295AbVHCOo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 10:44:59 -0400
Received: from xenotime.net ([66.160.160.81]:26281 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S262299AbVHCOo3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 10:44:29 -0400
Date: Wed, 3 Aug 2005 07:44:27 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jesper Juhl <jesper.juhl@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Sean Bruno <sean.bruno@dsl-only.net>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: Documentation - how to apply patches for various trees
In-Reply-To: <200508030840.39852@bilbo.math.uni-mannheim.de>
Message-ID: <Pine.LNX.4.50.0508030742350.489-100000@shark.he.net>
References: <200508022332.21380.jesper.juhl@gmail.com>
 <200508030840.39852@bilbo.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Aug 2005, Rolf Eike Beer wrote:

> Jesper Juhl wrote:
>
> >+Where can I download the patches?
>
> Maybe it would be useful to once again mention that local mirrors should be
> used at least for stable releases and */testing/*.
>
> >+The 2.6.x kernels
> [...]
> >+# moving from 2.6.11 to 2.6.12
> >+$ cd ~/linux-2.6.11			# change to kernel source dir
> >+$ patch -p1 < ../patch-2.6.12		# apply the 2.6.12 patch
>
> patch also nows "-i": patch -p1 -i ../patch-2.6.12
>
> More likely the user will get the patch compressed either with bzip2 or gzip,
> so I think it would be useful to tell once more how to apply such a patch:
>
> bzcat ../patch-2.6.12.bz2 | patch -p1
>
> >+The 2.6.x.y kernels
>
> >+$ cd ~/linux-2.6.12.2			# change into the kernel source dir
> >+$ patch -p1 -R < ../patch-2.6.12.2	# revert the 2.6.12.2 patch
> >+$ patch -p1 < ../patch-2.6.12.3		# apply the new 2.6.12.3 patch
> >+$ cd ..
> >+$ mv linux-2.6.12.2 linux-2.6.12.3	# rename the kernel source dir
>
> The better way would probably be to use interdiff. Another goodie is that
> interdiff knows about -z:
>
> cd ~/linux-2.6.12.2
> interdiff -z ../patch-2.6.12.2.bz2 ../patch-2.6.12.3.gz | patch -p1
>
> This should only be shown as "another way" to do so. Sometimes interdiff get's
> confused and breaks things, although this is very unlikely for the stable
> diffs.

Another (better IMO) solution is to use 'ketchup'.
It knows about all of these revisions/patches and how to download
and apply them AFAIK.
http://www.selenic.com/ketchup/

> >+The -mm kernels
>
> >+ These kernels in
> >+ addition to all the other experimental patches they contain usually also
> >+ contain any changes in the mainline -git kernels available at the time of
> >+ release.
>
> These two "contain"'s that close to each user are likely to confuse. In a
> German text I would but a comma before "in addition" and behind the first
> "contain", don't know what the rules for this are in English.
>
> Eike

-- 
~Randy
