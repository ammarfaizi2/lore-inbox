Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbUAMBmj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 20:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbUAMBmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 20:42:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:47307 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263015AbUAMBmi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 20:42:38 -0500
Date: Mon, 12 Jan 2004 17:16:06 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Bart Oldeman <bartoldeman@users.sourceforge.net>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] 2.6.1 (not 2.4.24!) mremap fixes broke shm alias mappings
In-Reply-To: <Pine.LNX.4.44.0401130119490.21515-100000@enm-bo-lt.enm.bris.ac.uk>
Message-ID: <Pine.LNX.4.58.0401121714370.14305@evo.osdl.org>
References: <Pine.LNX.4.44.0401130119490.21515-100000@enm-bo-lt.enm.bris.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Jan 2004, Bart Oldeman wrote:
> 
> We've already been discussing and playing with a cleaner alternative to
> mremap that works too (mmap'ing a file on tmpfs, perhaps via
> shm_open()). It's just that it's difficult to explain to users why DOSEMU
> worked on 2.6.0 and suddenly stopped working with the same configuration
> on 2.6.1.

Oh, please keep on using the mremap(ptr, 0, s) thing to create aliases.  
There's nothing really wrong with it, and as long as we just document it
in the sources, it shouldn't break again.

> -- the consensus amongst DOSEMU developers seems to be that you should
> feel free to disallow this funny old_len==0 case in 2.7 if you like.

It's potentially useful, and if we'll have a backwards compatibility issue 
anyway, there's no reason to remove it.

		Linus
