Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbVJKXdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbVJKXdk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 19:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbVJKXdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 19:33:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35713 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932354AbVJKXdk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 19:33:40 -0400
Date: Tue, 11 Oct 2005 16:33:18 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Borislav Petkov <bbpetkov@yahoo.de>
cc: Al Viro <viro@ftp.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tgraf@suug.ch,
       pablo@eurodev.net
Subject: Re: [was: Linux v2.6.14-rc4] fix textsearch build warning
In-Reply-To: <20051011230233.GA20187@gollum.tnic>
Message-ID: <Pine.LNX.4.64.0510111629490.14597@g5.osdl.org>
References: <Pine.LNX.4.64.0510101824130.14597@g5.osdl.org>
 <20051011145454.GA30786@gollum.tnic> <20051011205949.GU7992@ftp.linux.org.uk>
 <20051011230233.GA20187@gollum.tnic>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 12 Oct 2005, Borislav Petkov wrote:
> 
> Hm, I think that this is even merged already, at least the exact same one liner
> I sent is in Linus' git (see commit id dd0fc66fb33cd610bc1a5db8a5e232d34879b4d7). By the way, how
> can you see the patch's source by using the commit id? 
>
> git-cat-file "blob" dd0fc66fb33cd610bc1a5db8a5e232d34879b4d7
> says "bad file."

That's because it's not a blob ;)

You can do

	git-cat-file -t dd0fc66

and it will tell you it's a "commit" object. Then do

	git-cat-file commit dd0fc66

and it will show the actual commit internals, including commit info, 
parents and what tree object that commit is associated with.

HOWEVER. What you actually want to see is probably

	git-diff-tree -p --pretty dd0fc66

which shows the commit as "patch" (-p) and a "pretty header" (--pretty).

		Linus
