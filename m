Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267731AbUGWN7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267731AbUGWN7i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 09:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267732AbUGWN7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 09:59:38 -0400
Received: from hera.kernel.org ([63.209.29.2]:27610 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S267731AbUGWN7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 09:59:36 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: A users thoughts on the new dev. model
Date: Fri, 23 Jul 2004 13:58:27 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <cdr5i3$568$1@terminus.zytor.com>
References: <40FFD760.8060504@unix.eng.ua.edu> <cdpee5$otu$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1090591107 5321 127.0.0.1 (23 Jul 2004 13:58:27 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 23 Jul 2004 13:58:27 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <cdpee5$otu$1@gatekeeper.tmr.com>
By author:    Bill Davidsen <davidsen@tmr.com>
In newsgroup: linux.dev.kernel
> 
> I confess I feel that this new model is a return to the bad old days 
> when the stable tree wasn't. Sounds as if Andrew is bored with the idea 
> of letting 2.7 be the development tree and just being the gatekeeper of 
> STABLE new features for 2.6. Perhaps 2.7 should be opened and Andrew 
> will have a place to play, and features can drift to 2.6 more slowly.
> 

I think the discussion we had at the kernel summit has been somewhat
misrepresented by LWN et al.  What we discussed was really more of a
"soft fork", with the -mm tree serving the purpose of 2.7, rather than
a hard fork with a separate maintainer and putting ourselves in
back/forward-porting hell all over again.

Note that Andrew's -mm tree *specificially* has infrastructure to keep
changes apart and thus backporting to 2.6 mainstream of patches which
have proven themselves becomes trivial.

Thus:

	- Andrew will put experimental patches into -mm;
	- Andrew will continue to forward-port 2.6 mainstream fixes to
	  -mm;
	- Patches which have proven themselves stable and useful get
	  backported to 2.6;
	- If the delta between 2.6 and -mm becomes too great we'll
	  consider a hard fork AT THAT TIME, i.e. fork lazily instead
	  of the past model of forking eagerly.

Why the change?  Because the model already has proven itself, and
shown itself to be more functional than what we've had in the past.
2.6 is probably the most stable mainline tree we've had since 1.2 or
so, and yet Linus and Andrew process *lots* of changes.  The -mm tree
has become a very effective filter for what should go into mainline,
whereas the odd-number forks generally *haven't* been, because
backporting to mainline has usually been an afterthought.

I for one welcome our new -mm overlords.

	-hpa
