Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267957AbUHWW6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267957AbUHWW6M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 18:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267994AbUHWW43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 18:56:29 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:17039 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S267957AbUHWWy2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 18:54:28 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 23 Aug 2004 15:54:23 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] lazy TSS's I/O bitmap copy ...
In-Reply-To: <Pine.LNX.4.58.0408231500160.17766@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0408231552270.3222@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.58.0408231311460.3221@bigblue.dev.mdolabs.com>
 <20040823233249.09e93b86.ak@suse.de> <Pine.LNX.4.58.0408231436370.3222@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0408231500160.17766@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2004, Linus Torvalds wrote:

> On Mon, 23 Aug 2004, Davide Libenzi wrote:
> > 
> > The eventually double GPF would happen only on TSS-IObmp-lazy tasks, ie 
> > tasks using the I/O bitmap.
> 
> You could also check for the error code (at least the low 16 bits) being 
> 0, I guess, just to cut down the noise.

I think, not sure though (gonna test right now), that the "Segment 
Selector Index" part of the error code might be the TSS selector index, 
that will enable an even more selective reissue.



- Davide

