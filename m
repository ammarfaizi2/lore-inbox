Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbVI1NmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbVI1NmV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 09:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbVI1NmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 09:42:21 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:43167 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750965AbVI1NmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 09:42:20 -0400
Date: Wed, 28 Sep 2005 06:42:03 -0700
From: Paul Jackson <pj@sgi.com>
To: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
Cc: kurosawa@valinux.co.jp, taka@valinux.co.jp, magnus.damm@gmail.com,
       dino@in.ibm.com, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Subject: Re: [PATCH][BUG] fix memory leak on reading cpuset files after
 seeking beyond eof
Message-Id: <20050928064203.2a76b090.pj@sgi.com>
In-Reply-To: <20050928092558.61F6170041@sv1.valinux.co.jp>
References: <20050908225539.0bc1acf6.pj@sgi.com>
	<20050909.203849.33293224.taka@valinux.co.jp>
	<20050909063131.64dc8155.pj@sgi.com>
	<20050910.161145.74742186.taka@valinux.co.jp>
	<20050910015209.4f581b8a.pj@sgi.com>
	<20050926093432.9975870043@sv1.valinux.co.jp>
	<20050927013751.47cbac8b.pj@sgi.com>
	<20050927113902.C78A570046@sv1.valinux.co.jp>
	<20050928092558.61F6170041@sv1.valinux.co.jp>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takahiro-san wrote:
> I fixed the bug.  Sorry for my previous incomplete patch.
> The following patch is against linux-2.6.14-rc2.

The patch looks perfect.  But it needs a good opening comment and
Subject.

The header comment of the patch needs to be just the words that should
go in the source control (git) log comment, for someone to read to
understand this patch, years from now, when they have long since
forgotten our little email thread here.  Andrew Morton's and Linus
Torvalds's automatic patch handling tools just pull that comment out,
unedited, and put it into the log of changes for the kernel/cpuset.c
file, when they accept a patch.

The Subject needs to be a good name for the patch.  I always use a
short phrase starting with the word "cpuset" if it is a cpuset patch.
If it is a fix, Andrew seems to enjoy having the word 'fix' as the
last word of the Subject.  The tools of Andrew and Linus will take that
exact Subject line, trim off whatever is inside the '[...]', replace
spaces with hyphens '-', and use that for the name of the patch file.

Directly include Andrew or Linus in the Cc list, if you want them
to apply the patch.  They might notice the patch even if you don't Cc
them, but it is less certain in that case.

Ah - one cute trick - I hand edited the pathname of the file that shows
in the first two lines of the actual patch, to show the release of Linux
"linux-2.6.14-rc2" you worked against.  I hope I didn't break the patch
by hand editing it.  If I were good, I would send the patch just to
myself first, and make sure it still applied. But I am lazy and over
confident.

See also the following three documents, on how to submit patches
to the Linux kernel:

     1) Documentation/SubmittingPatches, a file in the kernel source
     2) Andrew Morton's "The Perfect Patch", available at:
          http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt
     3) Jeff Garzik's "Linux kernel patch submission format", at:
          http://linux.yyz.us/patch-format.html

I will resend this patch with a suitable header comment and Subject
in a few minutes. You will easily see what I mean when you see my next
message.

The header comment on what I will resend now will be quite short,
as this is an easy patch to explain.  The header comments on most of
the patches I send are much longer -- probably too long, but Andrew
seems reluctant to complain about comments that are too long.  He
is much more likely to complain if they are too short.

Excellent work.  Thank-you.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
