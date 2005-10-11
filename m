Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbVJKXi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbVJKXi3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 19:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbVJKXi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 19:38:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60290 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932362AbVJKXi2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 19:38:28 -0400
Date: Tue, 11 Oct 2005 16:38:14 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Borislav Petkov <bbpetkov@yahoo.de>
cc: Al Viro <viro@ftp.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tgraf@suug.ch,
       pablo@eurodev.net
Subject: Re: [was: Linux v2.6.14-rc4] fix textsearch build warning
In-Reply-To: <Pine.LNX.4.64.0510111629490.14597@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0510111634070.14597@g5.osdl.org>
References: <Pine.LNX.4.64.0510101824130.14597@g5.osdl.org>
 <20051011145454.GA30786@gollum.tnic> <20051011205949.GU7992@ftp.linux.org.uk>
 <20051011230233.GA20187@gollum.tnic> <Pine.LNX.4.64.0510111629490.14597@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 11 Oct 2005, Linus Torvalds wrote:
> 
> HOWEVER. What you actually want to see is probably
> 
> 	git-diff-tree -p --pretty dd0fc66
> 
> which shows the commit as "patch" (-p) and a "pretty header" (--pretty).

Oh, and in the (more common) case when you don't actually know the commit 
ID, just the file that was changed, do

	git-whatchanged -p include/linux/textsearch.h

which shows only the commits (and the _parts_ of those commits) that 
change that particular file (or list of files: you don't have to limit 
yourself to just one file - you can track a whole directory or an 
arbitrary list of files/directories).

And no, my tree doesn't contain your patch. My tree just contains Al's 
first part, that added the typedef and replaced the existing users of 
"unsigned int __nocast gfp_mask" to use that typedef.

I'll merge the full series after 2.6.14..

			Linus
