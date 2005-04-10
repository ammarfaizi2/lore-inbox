Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbVDJRbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVDJRbu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 13:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbVDJRbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 13:31:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40130 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261528AbVDJRbn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 13:31:43 -0400
Date: Sun, 10 Apr 2005 13:31:29 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Petr Baudis <pasky@ucw.cz>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>, Ingo Molnar <mingo@elte.hu>,
       Dave Jones <davej@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: more git updates..
In-Reply-To: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.61.0504101326210.16675@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Apr 2005, Linus Torvalds wrote:

> I've rsync'ed the new git repository to kernel.org, it should all be there
> in /pub/linux/kernel/people/torvalds/git.git/ (and it looks like the
> mirror scripts already picked it up on the public side too).

GCC 4 isn't very happy.  Mostly sign changes, but also something
that looks like a real error:

gcc -g -O3 -Wall   -c -o fsck-cache.o fsck-cache.c
fsck-cache.c: In function 'main':
fsck-cache.c:59: warning: control may reach end of non-void function 'fsck_tree' being inlined
fsck-cache.c:62: warning: control may reach end of non-void function 'fsck_commit' being inlined

I assume that fsck_tree and fsck_commit should complain loudly
if they ever get to that point - but since I'm not quite sure
there's no patch, sorry.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
