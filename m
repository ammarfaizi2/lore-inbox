Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVDSEdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVDSEdv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 00:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVDSEdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 00:33:51 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:60422 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S261318AbVDSEdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 00:33:49 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: Fortuna
Date: Tue, 19 Apr 2005 04:31:47 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <d421jj$vi$1@abraham.cs.berkeley.edu>
References: <20050414141538.3651.qmail@science.horizon.com> <20050418191316.GL21897@waste.org> <d419gl$qvq$2@abraham.cs.berkeley.edu> <20050419040116.GA6517@thunk.org>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1113885107 1010 128.32.168.222 (19 Apr 2005 04:31:47 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Tue, 19 Apr 2005 04:31:47 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o  wrote:
>For one, /dev/urandom and /dev/random don't use the same pool
>(anymore).  They used to, a long time ago, but certainly as of the
>writing of the paper this was no longer true.  This invalidates the
>entire last paragraph of Section 5.3.

Ok, you're right, this is a serious flaw, and one that I overlooked.
Thanks for elaborating.  (By the way, has anyone contacted to let them
know about these two errors?  Should I?)

I see three remaining criticisms from their Section 5.3:
1) Due to the way the documentation describes /dev/random, many
   programmers will choose /dev/random by default.  This default
   seems inappropriate and unfortunate.
2) There is a widespread perception that /dev/urandom's security is
   unproven and /dev/random's is proven.  This perception is wrong.
   On a related topic, it is "not at all clear" that /dev/random provides
   information-theoretic security.
3) Other designs place less stress on the entropy estimator, and
   thus are more tolerant to failures of entropy estimation.  A failure
   in the entropy estimator seems more likely than a failure in the
   cryptographic algorithms.
These three criticisms look right to me.

Apart from the merits or demerits of Section 5.3, the rest of the paper
seemed to have some interesting ideas for how to simplify and possibly
improve the /dev/random generator, which might be worth considering at
some point.
