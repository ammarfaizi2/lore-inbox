Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbVBRRxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVBRRxU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 12:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbVBRRxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 12:53:20 -0500
Received: from adsl-69-230-8-158.dsl.pltn13.pacbell.net ([69.230.8.158]:48090
	"EHLO mail.west.spy.net") by vger.kernel.org with ESMTP
	id S261440AbVBRRu5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 12:50:57 -0500
In-Reply-To: <20050218090900.GA2071@opteron.random>
References: <20050214020802.GA3047@bitmover.com> <200502172105.25677.pmcfarland@downeast.net> <421551F5.5090005@tupshin.com> <20050218090900.GA2071@opteron.random>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <bc647aafb53842b58dd0279161fb48e0@spy.net>
Content-Transfer-Encoding: 8BIT
Cc: lm@bitmover.com, Tupshin Harper <tupshin@tupshin.com>,
       darcs-users@darcs.net, linux-kernel@vger.kernel.org
From: Dustin Sallings <dustin@spy.net>
Subject: Re: [darcs-users] Re: [BK] upgrade will be needed
Date: Fri, 18 Feb 2005 09:50:52 -0800
To: Andrea Arcangeli <andrea@suse.de>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Feb 18, 2005, at 1:09, Andrea Arcangeli wrote:

> darcs scares me a bit because it's in haskell, I don't believe very 
> much
> in functional languages for compute intensive stuff, ram utilization

	It doesn't sound like you've programmed in functional languages all 
that much.  While I don't have any practical experience in Haskell, I 
can say for sure that my functional code in ocaml blows my C code away 
in maintainability and performance.  Now, if I could only get it to 
dump core...

	Haskell was a draw for me.  It's very rare to find someone who 
actually knows C and can write bulletproof code in it.

> On Fri, Feb 18, 2005 at 12:53:09PM +0100, Erik Bågfors wrote:
>> RCS/SCCS format doesn't make much sence for a changeset oriented SCM.
>
> The advantage it will provide is that it'll be compact and a backup 
> will
> compress at best too. Small compressed tarballs compress very badly
> instead, it wouldn't be even comparable. Once the thing is very compact
> it has a better chance to fit in cache, and if it fits in cache
> extracting diffs from each file will be very fast. Once it'll be 
> compact
> the cost of a changeset will be diminished allowing it to scale better
> too.

	Then what gets transferred over the wire?  The full modified ,v file?  
Do you need a smart server to create deltas to be applied to your ,v 
files?  What do you do when someone goes in with an rcs command to 
destroy part of the history (since the storage is now mutable).

	I use both darcs and arch regularly.  darcs is a lot nicer to use from 
a human interface point of view (and the merging is really a lot 
nicer), but the nicest thing about arch is that a given commit is 
immutable.  There are no tools to modify it.  This is also why the 
crypto signature stuff was so easy to fit in.

	RCS and SCCS storage throws away most of those features.

-- 
Dustin Sallings

