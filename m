Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264541AbUEYDuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264541AbUEYDuf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 23:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264543AbUEYDue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 23:50:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:56499 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264541AbUEYDub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 23:50:31 -0400
Date: Mon, 24 May 2004 20:50:28 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Albert Cahalan <albert@users.sourceforge.net>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Explicitly documenting patch submission
In-Reply-To: <1085439926.951.971.camel@cube>
Message-ID: <Pine.LNX.4.58.0405242044260.32189@ppc970.osdl.org>
References: <1085439926.951.971.camel@cube>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 May 2004, Albert Cahalan wrote:
> 
> The wordy mix-case aspect is kind of annoying, and for
> all that we don't get to differentiate actions.

I actually really really don't want to differentiate actions. There's 
really no reason to try to separate things out, and quite often the 
actions are mixed anyway. Besides, if they all end up having the same 
technical meaning ("I have the right to pass on this patch") having 
separate flags is just sure to confuse the process.

So what I want is something _really_ simple. Something that is
unambigious, and cannot be confused with something else. And in
particular, I want that sign-off line to be "strange" enough that there is
no possibility of ever writing that line by mistake - so that it is clear 
that the only reason anybody would write something like "Signed-off-by:" 
is because it meant _that_ particular thing.

In contrast, your suggestion of "modified:" is something that people might 
actually write when they write a changelog entry. 

One reason for uniqueness is literally for automatic parsing - having 
scripts that pick up on this, and send ACK messages, or do statistics on 
who patches tend to go through etc etc. 

		Linus
