Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbVEaNye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbVEaNye (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 09:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVEaNyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 09:54:33 -0400
Received: from stark.xeocode.com ([216.58.44.227]:34480 "EHLO
	stark.xeocode.com") by vger.kernel.org with ESMTP id S261611AbVEaNyb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 09:54:31 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Pekka Enberg <penberg@cs.helsinki.fi>,
       Pekka Enberg <penberg@gmail.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PROBLEM] Machine Freezes while Running Crossover Office
References: <1117291619.9665.6.camel@localhost>
	<Pine.LNX.4.58.0505291059540.10545@ppc970.osdl.org>
	<84144f0205052911202863ecd5@mail.gmail.com>
	<Pine.LNX.4.58.0505291143350.10545@ppc970.osdl.org>
	<1117399764.9619.12.camel@localhost>
	<Pine.LNX.4.58.0505291543070.10545@ppc970.osdl.org>
	<1117466611.9323.6.camel@localhost>
	<Pine.LNX.4.58.0505301024080.10545@ppc970.osdl.org>
	<FC5325FE-7730-4A66-BDA8-B6C035E6276F@mac.com>
	<Pine.LNX.4.58.0505301120290.1876@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505301120290.1876@ppc970.osdl.org>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 31 May 2005 09:54:17 -0400
Message-ID: <87ekbnwlfa.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Mon, 30 May 2005, Kyle Moffett wrote:
> > 
> > If X is hung and not accepting data on any of its sockets, then this
> > could hang the Xterm in the background, and therefore hang the printout
> > from the "date" process.
> 
> Nope. There's a pty in between, and the pty buffer is much bigger than 
> just a few lines, so even if an xterm is hung, the program displaing on an 
> xterm wouldn't be affected normally (unless it reads from the tty or 
> outputs several kB of data).

Well "date" won't hang but you won't actually see any output for it on the
XTerm.

But I'm unclear how switching to VT1 is going to work since that requires that
X capture the VT keypress. If X is hung and not responding to keyboard and
mouse inputs it's not going to see that keypress either and isn't going to
switch.


I think the best way to test in this situation is to SSH in from another
machine and run commands like this over SSH. Even better would be a serial
console.


-- 
greg

