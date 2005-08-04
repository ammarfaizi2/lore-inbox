Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261660AbVHDAd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbVHDAd6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 20:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbVHDAd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 20:33:58 -0400
Received: from [202.136.32.45] ([202.136.32.45]:65171 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S261660AbVHDAd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 20:33:57 -0400
From: Grant Coady <lkml@dodo.com.au>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Rolf Eike Beer <eike-kernel@sf-tec.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Steven Rostedt <rostedt@goodmis.org>,
       Sean Bruno <sean.bruno@dsl-only.net>, Lee Revell <rlrevell@joe-job.com>,
       Bodo Eggert <7eggert@gmx.de>, Gene Heskett <gene.heskett@verizon.net>,
       "H. Peter Anvin" <hpa@zytor.com>, David Brown <dmlb2000@gmail.com>,
       Puneet Vyas <vyas.puneet@gmail.com>,
       Richard Hubbell <richard.hubbell@gmail.com>, webmaster@kernel.org
Subject: Re: Documentation - how to apply patches for various trees
Date: Thu, 04 Aug 2005 10:33:31 +1000
Organization: www.scatter.mine.nu
Reply-To: lkml@dodo.com.au
Message-ID: <vbn2f1do8pph1qvlfb6n73nci19c51ukue@4ax.com>
References: <200508022332.21380.jesper.juhl@gmail.com> <200508032251.07996.jesper.juhl@gmail.com> <Pine.LNX.4.58.0508031400390.3258@g5.osdl.org> <200508032328.07727.jesper.juhl@gmail.com>
In-Reply-To: <200508032328.07727.jesper.juhl@gmail.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jesper,
On Wed, 3 Aug 2005 23:28:06 +0200, Jesper Juhl <jesper.juhl@gmail.com> wrote:

I like it, just a little concerned about confusing new user with too 
many alternative patching methods up front...

>+ This (as usual with Linux and other UNIX like operating systems) can be
>+done in several different ways.
>+In all the examples below I feed the file (in uncompressed form) to patch
>+via stdin using the following syntax:
>+	patch -p1 < path/to/patch-x.y.z
>+
>+but patch can also get the name of the file to use via the -i argument, like
>+this:
>+	patch -p1 -i path/to/patch-x.y.z
>+
>+If your patch file is compressed with gzip or bzip2 and you don't want to
>+uncompress it before applying it, then you can feed it to patch like this
>+instead:

	cat path/to/patch-x.y.z.gz | patch -p1
>+	zcat path/to/patch-x.y.z.gz | patch -p1
>+	bzcat path/to/patch-x.y.z.bz2 | patch -p1

In a howto, I'd prefer  _one_ consistent method to reduce the 
reader's confusion.  

The above trio of commands serves me well over many years' kernel 
patching, and it is trivial to up-arrow, home, change compression 
method, retry ... when my fingers get ahead of my mind :)


Experience users recognise the intent of the commands and use their 
favourite method instead, almost without thinking.


Spelling:

s/uncompression/decompression/
s/adviced/advised/
s/bandwith/bandwidth/

Cheers,
Grant.

