Return-Path: <linux-kernel-owner+w=401wt.eu-S1030252AbXADXAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbXADXAa (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 18:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030257AbXADXAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 18:00:30 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:52877 "EHLO gaz.sfgoth.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030252AbXADXA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 18:00:28 -0500
Date: Thu, 4 Jan 2007 15:21:06 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, Eric Sandeen <sandeen@redhat.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [UPDATED PATCH] fix memory corruption from misinterpreted bad_inode_ops return values
Message-ID: <20070104232106.GK35756@gaz.sfgoth.com>
References: <20070104105430.1de994a7.akpm@osdl.org> <Pine.LNX.4.64.0701041104021.3661@woody.osdl.org> <20070104191451.GW17561@ftp.linux.org.uk> <Pine.LNX.4.64.0701041127350.3661@woody.osdl.org> <20070104202412.GY17561@ftp.linux.org.uk> <20070104215206.GZ17561@ftp.linux.org.uk> <20070104223856.GA79126@gaz.sfgoth.com> <Pine.LNX.4.64.0701041428510.3661@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701041428510.3661@woody.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Thu, 04 Jan 2007 15:21:07 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Well, that probably would work, but it's also true that returning a 64-bit 
> value on a 32-bit platform really _does_ depend on more than the size.

Yeah, obviously this is restricted to the signed-integer case.  My point
was just that you could have the compiler figure out which variant to pick
for loff_t automatically.

> "let's not play tricks with function types at all".

I think I agree.  The real (but harder) fix for the wasted space issue
would be to get the toolchain to automatically combine functions that
end up compiling into identical assembly.

-Mitch
