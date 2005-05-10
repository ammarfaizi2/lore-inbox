Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbVEJCYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbVEJCYS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 22:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVEJCYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 22:24:18 -0400
Received: from fire.osdl.org ([65.172.181.4]:37303 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261463AbVEJCYM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 22:24:12 -0400
Date: Mon, 9 May 2005 19:23:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: 7eggert@gmx.de
Cc: blaisorblade@yahoo.it, jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [patch 1/6] uml: remove elf.h [ compile-fix, for 2.6.12 ]
Message-Id: <20050509192324.14ab86ae.akpm@osdl.org>
In-Reply-To: <E1DVKHF-0004w9-Ua@be1.7eggert.dyndns.org>
References: <42q12-7bE-5@gated-at.bofh.it>
	<42rTb-fj-11@gated-at.bofh.it>
	<E1DVKHF-0004w9-Ua@be1.7eggert.dyndns.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" <7eggert@gmx.de> wrote:
>
>  Andrew Morton <akpm@osdl.org> wrote:
> 
>  > hmm, that's exciting.  How to tell diff and patch to remove a zero-length
>  > file?
> 
>  $ md a b c
>  $ touch a/a
>  $ echo .>c/a
>  $ diff -purN a c
>  diff -purN a/a c/a
>  --- a/a 2005-05-10 04:08:14.000000000 +0200
>  +++ c/a 2005-05-10 04:09:17.972505331 +0200
>  @@ -0,0 +1 @@
>  +.
>  $ diff -purN c b
>  diff -purN c/a b/a
>  --- c/a 2005-05-10 04:09:17.972505331 +0200
>  +++ b/a 1970-01-01 01:00:00.000000000 +0100
>  @@ -1 +0,0 @@
>  -.
>  $ cd a
>  $ patch -p1   # < both patches (c&p)
>  <snip>
>  $ ls -l
>  total 0

That's cheating!
