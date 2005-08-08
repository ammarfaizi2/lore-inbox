Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbVHHXxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbVHHXxt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 19:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbVHHXxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 19:53:49 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:49383 "EHLO
	taverner.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S932366AbVHHXxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 19:53:48 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: understanding Linux capabilities brokenness
Date: Mon, 8 Aug 2005 23:53:33 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <dd8r9s$eqn$1@taverner.CS.Berkeley.EDU>
References: <20050808211241.GA22446@clipper.ens.fr> <20050808223238.GA523@clipper.ens.fr>
Reply-To: daw-usenet@taverner.CS.Berkeley.EDU (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.CS.Berkeley.EDU 1123545213 15191 128.32.168.222 (8 Aug 2005 23:53:33 GMT)
X-Complaints-To: news@taverner.CS.Berkeley.EDU
NNTP-Posting-Date: Mon, 8 Aug 2005 23:53:33 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Madore  wrote:
>This does not tell me, then, why CAP_SETPCAP was globally disabled by
>default, nor why passing of capabilities across execve() was entirely
>removed instead of being fixed.

I do not know of any good reason.  Perhaps the few folks who knew enough
to fix it properly didn't feel like bothering; it beats me.

Messing with capabilities is scary.  As far as I can tell, there never was
any coherent "design" to the semantics of POSIX capabilities in Linux.
It's had a little bit of a feeling of a muddle of accumulated gunk,
so unless you understand it really well, it's hard to know what any
changes you make are safe.  This may have scared people away from fixing
it "the right way".  But if you're volunteering to do the analysis and
figure out how to fix it, I say, sounds good to me.

Then again, I'm an outsider.  Perhaps someone more involved in the
development and maintanence of capabilities knows something that I don't.
