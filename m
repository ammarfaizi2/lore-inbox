Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268257AbUHWXMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268257AbUHWXMM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 19:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268168AbUHWXKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 19:10:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:18309 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268190AbUHWXJZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 19:09:25 -0400
Date: Mon, 23 Aug 2004 16:09:17 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] lazy TSS's I/O bitmap copy ...
In-Reply-To: <Pine.LNX.4.58.0408231552270.3222@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.58.0408231607450.17766@ppc970.osdl.org>
References: <Pine.LNX.4.58.0408231311460.3221@bigblue.dev.mdolabs.com>
 <20040823233249.09e93b86.ak@suse.de> <Pine.LNX.4.58.0408231436370.3222@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0408231500160.17766@ppc970.osdl.org>
 <Pine.LNX.4.58.0408231552270.3222@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 23 Aug 2004, Davide Libenzi wrote:
> 
> I think, not sure though (gonna test right now), that the "Segment 
> Selector Index" part of the error code might be the TSS selector index, 
> that will enable an even more selective reissue.

I don't think so. Generally the error code is 0 for all normal GP cases. 
The error code tends to be non-zero only for the "load segment" things, 
when it shows what the incorrect segment was.

So I bet you'll see a zero error code and that checking for it won't 
actually cut down _that_ much on the double GP faults.

		Linus
