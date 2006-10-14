Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422808AbWJNSxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422808AbWJNSxf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 14:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422807AbWJNSxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 14:53:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59026 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422808AbWJNSxe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 14:53:34 -0400
Date: Sat, 14 Oct 2006 11:53:25 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Shawn Starr <shawn.starr@rogers.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Junio C Hamano <junkio@cox.net>
Subject: Re: bzip2 tarball 2.6.19-rc2 packaged wrong?
In-Reply-To: <200610132336.21392.shawn.starr@rogers.com>
Message-ID: <Pine.LNX.4.64.0610141146070.3952@g5.osdl.org>
References: <200610132336.21392.shawn.starr@rogers.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 13 Oct 2006, Shawn Starr wrote:
>
> Linus, something in git  broke the prepackaged tarball/bzip2 generation?

Sorry, yes.

I switched over my "release-script" that generates the tar-balls and 
patches to use the new syntax for "git tar-tree" (now "git archive"), and 
I screwed up by not having the slash in the prefix.

The old git-tar-tree would add the slash to the prefix automatically, 
git-archive does not. Which is arguably a bug in git-archive. Oh, well.

I'll re-generate the tar-file.

		Linus
