Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261814AbVDKPj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbVDKPj5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 11:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbVDKPj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 11:39:57 -0400
Received: from mx1.elte.hu ([157.181.1.137]:48831 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261814AbVDKPj3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 11:39:29 -0400
Date: Mon, 11 Apr 2005 17:39:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Jackson <pj@engr.sgi.com>, pasky@ucw.cz, rddunlap@osdl.org,
       ross@jose.lug.udel.edu, linux-kernel@vger.kernel.org,
       git@vger.kernel.org
Subject: Re: [rfc] git: combo-blobs
Message-ID: <20050411153905.GA7284@elte.hu>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050411113523.GA19256@elte.hu> <20050411074552.4e2e656b.pj@engr.sgi.com> <20050411151204.GA5562@elte.hu> <Pine.LNX.4.58.0504110826140.1267@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504110826140.1267@ppc970.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> > to construct the combo blob later on, we do have to unpack sched.c (and 
> > if it's already a combo-blob that is not cached then we'd have to unpack 
> > all parents until we arrive at some full blob).
> 
> I really don't want to have this. Having chains of dependencies is 
> really painful, and now if _any_ of them gets corrupted, you're 
> screwed.

if a repository is corrupted then it pretty much needs to be dropped 
anyway. Also, with a 'replicate the full object on every 8th commit' 
rule the risk would be somewhat mitigated as well.

but yeah, i can very much see the point of trying to avoid that 
complexity. (Also, it's not like delta blobs couldnt be introduced later 
on, if there's enough (if any) pressure to reduce storage overhead.)

	Ingo
