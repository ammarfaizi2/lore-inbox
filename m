Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbVE3SYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVE3SYQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 14:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVE3SYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 14:24:09 -0400
Received: from fire.osdl.org ([65.172.181.4]:41429 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261686AbVE3SXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 14:23:50 -0400
Date: Mon, 30 May 2005 11:25:13 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: Pekka Enberg <penberg@cs.helsinki.fi>, Pekka Enberg <penberg@gmail.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PROBLEM] Machine Freezes while Running Crossover Office
In-Reply-To: <Pine.LNX.4.58.0505301120290.1876@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0505301123050.1876@ppc970.osdl.org>
References: <1117291619.9665.6.camel@localhost> <Pine.LNX.4.58.0505291059540.10545@ppc970.osdl.org>
 <84144f0205052911202863ecd5@mail.gmail.com> <Pine.LNX.4.58.0505291143350.10545@ppc970.osdl.org>
 <1117399764.9619.12.camel@localhost> <Pine.LNX.4.58.0505291543070.10545@ppc970.osdl.org>
 <1117466611.9323.6.camel@localhost> <Pine.LNX.4.58.0505301024080.10545@ppc970.osdl.org>
 <FC5325FE-7730-4A66-BDA8-B6C035E6276F@mac.com> <Pine.LNX.4.58.0505301120290.1876@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 30 May 2005, Linus Torvalds wrote:
> 
> So it's either a kernel scheduling problem, or Crossover running with RT 
> priority and screwing up.

Btw, crossover being screwed up and runnign with RT priority would also 
explain why stracing it makes the problem go away - the tracing will cause 
the RT process to halt at system calls and yield to the tracer, which 
isn't RT.

Of course, the same goes for a scheduler bug, so it's not like this proves 
anything one way or the other, but considering that others aren't 
reporting this problem with other programs..

		Linus
