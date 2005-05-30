Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbVE3SVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVE3SVl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 14:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbVE3SVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 14:21:41 -0400
Received: from fire.osdl.org ([65.172.181.4]:23765 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261667AbVE3SVZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 14:21:25 -0400
Date: Mon, 30 May 2005 11:22:48 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: Pekka Enberg <penberg@cs.helsinki.fi>, Pekka Enberg <penberg@gmail.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PROBLEM] Machine Freezes while Running Crossover Office
In-Reply-To: <FC5325FE-7730-4A66-BDA8-B6C035E6276F@mac.com>
Message-ID: <Pine.LNX.4.58.0505301120290.1876@ppc970.osdl.org>
References: <1117291619.9665.6.camel@localhost> <Pine.LNX.4.58.0505291059540.10545@ppc970.osdl.org>
 <84144f0205052911202863ecd5@mail.gmail.com> <Pine.LNX.4.58.0505291143350.10545@ppc970.osdl.org>
 <1117399764.9619.12.camel@localhost> <Pine.LNX.4.58.0505291543070.10545@ppc970.osdl.org>
 <1117466611.9323.6.camel@localhost> <Pine.LNX.4.58.0505301024080.10545@ppc970.osdl.org>
 <FC5325FE-7730-4A66-BDA8-B6C035E6276F@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 30 May 2005, Kyle Moffett wrote:
> 
> If X is hung and not accepting data on any of its sockets, then this
> could hang the Xterm in the background, and therefore hang the printout
> from the "date" process.

Nope. There's a pty in between, and the pty buffer is much bigger than 
just a few lines, so even if an xterm is hung, the program displaing on an 
xterm wouldn't be affected normally (unless it reads from the tty or 
outputs several kB of data).

So it's either a kernel scheduling problem, or Crossover running with RT 
priority and screwing up.

		Linus
