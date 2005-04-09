Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbVDIXZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVDIXZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 19:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbVDIXXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 19:23:45 -0400
Received: from cmailg1.svr.pol.co.uk ([195.92.195.171]:53511 "EHLO
	cmailg1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id S261415AbVDIXV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 19:21:56 -0400
Message-Id: <200504092321.j39NLk003976@blake.inputplus.co.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Petr Baudis <pasky@ucw.cz>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>, Ingo Molnar <mingo@elte.hu>,
       Dave Jones <davej@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: more git updates.. 
In-Reply-To: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> 
Date: Sun, 10 Apr 2005 00:21:46 +0100
From: Ralph Corderoy <ralph@inputplus.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

> Btw, the NUL-termination makes this really easy to use even in shell
> scripts, ie you can do
> 
> 	diff-tree <sha1> <sha1> | xargs -0 do_something
> 
> and you'll get each line as one nice argument to your "do_something"
> script. So a do_diff could be based on something like
> 
> 	#!/bin/sh

Watch out for when xargs invokes do_something more than once and the `<'
is parsed by a different one than the `>'.  A `while read ...; do ...
done' would avoid that, but wouldn't like the NULs instead of LFs.

Cheers,


Ralph.

