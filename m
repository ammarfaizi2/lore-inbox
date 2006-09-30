Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751733AbWI3X5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbWI3X5R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 19:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751739AbWI3X5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 19:57:16 -0400
Received: from mail.suse.de ([195.135.220.2]:25258 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751721AbWI3X5Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 19:57:16 -0400
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
Date: Sun, 1 Oct 2006 01:56:52 +0200
User-Agent: KMail/1.9.3
Cc: Eric Rannaud <eric.rannaud@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, Chandra Seetharaman <sekharan@us.ibm.com>,
       Jan Beulich <jbeulich@novell.com>
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com> <200610010002.46634.ak@suse.de> <Pine.LNX.4.64.0609301554310.3952@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609301554310.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610010156.52675.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 01 October 2006 00:55, Linus Torvalds wrote:
> 
> On Sun, 1 Oct 2006, Andi Kleen wrote:
> > 
> > No, it's not. On x86-64 it can be three or more stacks nested in
> > complicated ways (process stack, interrupt stack, exception stack)
> > The exception stack can happen multiple times.
> 
> And you don't think that's true on x86?

On i386 it is simpler (only one interrupt stack and one process stack)
However there can be still nasty corner cases, like the temporary NMI stacks
that were added recently. It could be probably all handled in a state machine,
but it would be ugly (at least I heard complaints about the x86 code that
does it) 
 
> Read the x86 code. Please. The one _before_ you added unwinding.

It's still the same if you disable unwinding.

-Andi
