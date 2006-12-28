Return-Path: <linux-kernel-owner+w=401wt.eu-S1754955AbWL1UKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754955AbWL1UKt (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 15:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754956AbWL1UKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 15:10:49 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:58582 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754948AbWL1UKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 15:10:48 -0500
Subject: Re: 2.6.19 file content corruption on ext3
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Jones <davej@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Petri Kaukasoina <kaukasoina610meov7e@sci.fi>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Martin Michlmayr <tbm@cyrius.com>
In-Reply-To: <20061228193943.GC8940@redhat.com>
References: <Pine.LNX.4.64.0612171716510.3479@woody.osdl.org>
	 <Pine.LNX.4.64.0612171725110.3479@woody.osdl.org>
	 <Pine.LNX.4.64.0612171744360.3479@woody.osdl.org>
	 <45861E68.3060403@yahoo.com.au> <20061217214308.62b9021a.akpm@osdl.org>
	 <20061219085149.GA20442@torres.l21.ma.zugschlus.de>
	 <20061228180536.GB7385@torres.zugschlus.de>
	 <Pine.LNX.4.64.0612281014190.4473@woody.osdl.org>
	 <20061228190541.GA23128@elektroni.phys.tut.fi>
	 <Pine.LNX.4.64.0612281119370.4473@woody.osdl.org>
	 <20061228193943.GC8940@redhat.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 28 Dec 2006 21:10:33 +0100
Message-Id: <1167336633.20929.31.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-28 at 14:39 -0500, Dave Jones wrote:
> On Thu, Dec 28, 2006 at 11:21:21AM -0800, Linus Torvalds wrote:
>  > 
>  > 
>  > On Thu, 28 Dec 2006, Petri Kaukasoina wrote:
>  > > > me up), and that seems to show the corruption going way way back (ie going 
>  > > > back to Linux-2.6.5 at least, according to one tester).
>  > > 
>  > > That was a Fedora kernel. Has anyone seen the corruption in vanilla 2.6.18
>  > > (or older)?
>  > 
>  > Well, that was a really _old_ fedora kernel. I guarantee you it didn't 
>  > have the page throttling patches in it, those were written this summer. So 
>  > it would either have to be Fedora carrying around another patch that just 
>  > happens to result in the same corruption for _years_, or it's the same 
>  > bug.
> 
> The only notable VM patch in Fedora kernels of that vintage that I recall
> was Ingo's 4g/4g thing.

which does tlb flushes *all the time* so that even rules out (well
almost) a stale tlb somewhere...


