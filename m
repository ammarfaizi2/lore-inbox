Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbUKWSlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbUKWSlq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 13:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbUKWSjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 13:39:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:11739 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261479AbUKWSha (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 13:37:30 -0500
Date: Tue, 23 Nov 2004 10:37:24 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: Matthew Wilcox <matthew@wil.cx>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove pointless <0 comparison for unsigned variable in
 fs/fcntl.c
In-Reply-To: <Pine.LNX.4.61.0411231916410.3389@dragon.hygekrogen.localhost>
Message-ID: <Pine.LNX.4.58.0411231035500.20993@ppc970.osdl.org>
References: <Pine.LNX.4.61.0411212351210.3423@dragon.hygekrogen.localhost>
 <20041122010253.GE25636@parcelfarce.linux.theplanet.co.uk> <41A30612.2040700@dif.dk>
 <Pine.LNX.4.58.0411230958260.20993@ppc970.osdl.org>
 <Pine.LNX.4.61.0411231916410.3389@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 23 Nov 2004, Jesper Juhl wrote:
>
> Shutting up gcc is not the primary goal here, the goal is/was to  
> a) review the code and make sure that it is safe and correct, and fix it 
> when it is not.
> b) remove comparisons that are just a waste of CPU cycles when the result 
> is always true or false (in *all* cases on *all* archs).

Well, I'm convinced that (b) is unnecessary, as any compiler that notices 
the range thing enough to warn will also be smart enough to just remove 
the test internally.

But yes, as long as the thing is a "review and fix bugs" and not a quest 
to remove warnings which may well be compiler figments, that's obviously 
ok.

			Linus
