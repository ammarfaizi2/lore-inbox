Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWGMNiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWGMNiG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 09:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbWGMNiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 09:38:06 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:3811 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750790AbWGMNiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 09:38:05 -0400
Subject: Re: utrace vs. ptrace
From: Arjan van de Ven <arjan@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Albert Cahalan <acahalan@gmail.com>,
       torvalds@osdl.org, alan@lxorguk.ukuu.org.uk, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>
In-Reply-To: <200607131534.16819.ak@suse.de>
References: <787b0d920607122243g24f5a003p1f004c9a1779f75c@mail.gmail.com>
	 <200607131521.52505.ak@suse.de>
	 <1152797295.3024.50.camel@laptopd505.fenrus.org>
	 <200607131534.16819.ak@suse.de>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 15:37:50 +0200
Message-Id: <1152797870.3024.54.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-13 at 15:34 +0200, Andi Kleen wrote:
> On Thursday 13 July 2006 15:28, Arjan van de Ven wrote:
> > 
> > > That said extended core dumping (e.g. automatic processing of the output) 
> > > in user space makes sense. I had a prototype for that once that uploaded
> > > a simple crash report to a web 
> > 
> > the script I use for that is at
> > http://www.fenrus.org/bt.sh
> > 
> > it tries to include things like rpm versions of the package it was in
> > etc, and suggests/downloads the right debuginfo rpms to improve the
> > backtrace. Clearly that's all userspace stuff; but it can run from a
> > daemon easily; eg have all core dumps go to a special directory where
> > the daemon reaps them and analyzes.
> 
> You can't do that right now because core_pattern doesn't support slashes.
> The coredumps will be always all over the fs or not be there at all
> if the cwd is write protected.

are you sure? I had this working in the 2.6.9 timeframe, I could set
core pattern to /tmp/corefiles/core and such just fine..
(and the core files ended up in the /tmp/corefiles/ directory as well)

