Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbVDJLit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbVDJLit (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 07:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbVDJLit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 07:38:49 -0400
Received: from fmr24.intel.com ([143.183.121.16]:23021 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261476AbVDJLis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 07:38:48 -0400
Date: Sun, 10 Apr 2005 04:38:21 -0700
From: tony.luck@intel.com
Message-Id: <200504101138.j3ABcLh12907@unix-os.sc.intel.com>
To: Christopher Li <lkml@chrisli.org>
Cc: Junio C Hamano <junkio@cox.net>, Linus Torvalds <torvalds@osdl.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: more git updates..
In-Reply-To: <20050410070646.GD13853@64m.dyndns.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <7vhdifcbmo.fsf@assigned-by-dhcp.cox.net> <20050410055340.GB13853@64m.dyndns.org> <7v7jjbc755.fsf@assigned-by-dhcp.cox.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>handle by pure rename only plus the extra delta. The current git don't
>have per file change history. From git's point of view some file deleted
>and the other file appeared with same content.
>
>It is the top level SCM to handle that correctly.
>Rename a directory will be even more fun.

But from a git perspective it will be very efficient.  Imagine that
Linus decides to rename arch/i386 as arch/x86 ... at the git repository
level this just requires a changeset, a new top level tree, and a new
tree for the arch directory showing that i386 changed to x86.  That's
all ... every files below that didn't change, so the blobs for the files
are all the same.

-Tony
