Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263835AbUC3TMb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 14:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263833AbUC3TMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 14:12:31 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:23229
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263846AbUC3TMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 14:12:20 -0500
Date: Tue, 30 Mar 2004 21:12:18 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: mapped pages being truncated [was Re: 2.6.5-rc2-aa5]
Message-ID: <20040330191218.GE3808@dualathlon.random>
References: <20040330190102.GD3808@dualathlon.random> <Pine.LNX.4.44.0403302002090.23584-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403302002090.23584-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 08:06:42PM +0100, Hugh Dickins wrote:
> On Tue, 30 Mar 2004, Andrea Arcangeli wrote:
> > On Tue, Mar 30, 2004 at 07:48:42PM +0100, Hugh Dickins wrote:
> > > 
> > > Do you have enough evidence that it's the very same bug?
> > 
> > yes, see the two stack traces, they trigger in the same place and it's
> > the very same workload. Andrew just noticed that xfs indeed calls
> > truncate_inode_pages before vmtruncate. It will trigger with your
> > patches too.
> 
> Yes, Andrew has got it (and I agree XFS is wrong to be doing that).

indeed.

> > Ok I see what you mean, this should fix it, agreed?
> 
> Yes, that's exactly the fix (for when COWing a reserved page).

thanks, great spotting!
