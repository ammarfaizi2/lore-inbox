Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263051AbTHaXCM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 19:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263053AbTHaXCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 19:02:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:8387 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263051AbTHaXCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 19:02:07 -0400
Date: Sun, 31 Aug 2003 16:01:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Zach, Yoav" <yoav.zach@intel.com>
cc: akpm@osdl.org, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: non-readable binaries - binfmt_misc 2.6.0-test4
In-Reply-To: <2C83850C013A2540861D03054B478C0601CF64C8@hasmsx403.iil.intel.com>
Message-ID: <Pine.LNX.4.44.0308311552570.28947-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 1 Sep 2003, Zach, Yoav wrote:
>
> The proposed patch solves a problem for interpreters that need to
> execute a non-readable file, which cannot be read in userland. To handle
> such cases the interpreter must have the kernel load the binary on its
> behalf.

I don't like the security issues here. Sure, you "trust" the interpreter, 
and clearly only root can set the flag, but to me that just makes me 
wonder why the interpreter itself can't be a simple suid wrapper that does 
the mapping rather than having it done in kernel space..

		Linus


