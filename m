Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161137AbVKDKVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161137AbVKDKVg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 05:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161136AbVKDKVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 05:21:36 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:56218 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161134AbVKDKVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 05:21:35 -0500
Date: Fri, 4 Nov 2005 11:21:18 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Bernd Petrovitsch <bernd@firmix.at>
Cc: Andrew Morton <akpm@osdl.org>, Badari Pulavarty <pbadari@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>, jdike@addtoit.com, rob@landley.net,
       nickpiggin@yahoo.com.au, gh@us.ibm.com, kamezawa.hiroyu@jp.fujitsu.com,
       haveblue@us.ibm.com, mel@csn.ul.ie, mbligh@mbligh.org,
       kravetz@us.ibm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [patch] swapin rlimit
Message-ID: <20051104102118.GA26388@elte.hu>
References: <E1EXEfW-0005ON-00@w-gerrit.beaverton.ibm.com> <200511021747.45599.rob@landley.net> <43699573.4070301@yahoo.com.au> <200511030007.34285.rob@landley.net> <20051103163555.GA4174@ccure.user-mode-linux.org> <1131035000.24503.135.camel@localhost.localdomain> <20051103205202.4417acf4.akpm@osdl.org> <20051104072628.GA20108@elte.hu> <1131099267.30726.43.camel@tara.firmix.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131099267.30726.43.camel@tara.firmix.at>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Bernd Petrovitsch <bernd@firmix.at> wrote:

> On Fri, 2005-11-04 at 08:26 +0100, Ingo Molnar wrote:
> > * Andrew Morton <akpm@osdl.org> wrote:
> > 
> > > Similarly, that SGI patch which was rejected 6-12 months ago to kill 
> > > off processes once they started swapping.  We thought that it could be 
> > > done from userspace, but we need a way for userspace to detect when a 
> > > task is being swapped on a per-task basis.
> > 
> > wouldnt the clean solution here be a "swap ulimit"?
> 
> Hmm, where is the difference to "mlockall(MCL_CURRENT|MCL_FUTURE);"? 
> OK, mlockall() can only be done by root (processes).

what do you mean? mlockall pins down all pages. swapin ulimit kills the 
task (and thus frees all the RAM it had) when it touches swap for the 
first time. These two solutions almost oppose each other!

	Ingo
