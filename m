Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbVJKXYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbVJKXYY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 19:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbVJKXYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 19:24:23 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:55755 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932123AbVJKXYX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 19:24:23 -0400
Date: Wed, 12 Oct 2005 00:24:21 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tgraf@suug.ch,
       pablo@eurodev.net
Subject: Re: [was: Linux v2.6.14-rc4] fix textsearch build warning
Message-ID: <20051011232421.GW7992@ftp.linux.org.uk>
References: <Pine.LNX.4.64.0510101824130.14597@g5.osdl.org> <20051011145454.GA30786@gollum.tnic> <20051011205949.GU7992@ftp.linux.org.uk> <20051011230233.GA20187@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051011230233.GA20187@gollum.tnic>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2005 at 01:02:33AM +0200, Borislav Petkov wrote:
> Hm, I think that this is even merged already, at least the exact same one liner
> I sent is in Linus' git (see commit id dd0fc66fb33cd610bc1a5db8a5e232d34879b4d7). By the way, how
> can you see the patch's source by using the commit id? 
; git-cat-file commit dd0fc66fb33cd610bc1a5db8a5e232d34879b4d7
tree 51f96a9db96293b352e358f66032e1f4ff79fafb
parent 3b0e77bd144203a507eb191f7117d2c5004ea1de
author Al Viro <viro@ftp.linux.org.uk> 1128667564 +0100
committer Linus Torvalds <torvalds@g5.osdl.org> 1128808857 -0700

[PATCH] gfp flags annotations - part 1

 - added typedef unsigned int __nocast gfp_t;

 - replaced __nocast uses for gfp flags with gfp_t - it gives exactly
   the same warnings as far as sparse is concerned, doesn't change
   generated code (from gcc point of view we replaced unsigned int with
   typedef) and documents what's going on far better.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>

and no, that's not it.
