Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264346AbUHGU0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbUHGU0c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 16:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbUHGU0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 16:26:32 -0400
Received: from colin2.muc.de ([193.149.48.15]:48647 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264346AbUHGU0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 16:26:31 -0400
Date: 7 Aug 2004 22:26:30 +0200
Date: Sat, 7 Aug 2004 22:26:30 +0200
From: Andi Kleen <ak@muc.de>
To: Kasper Sandberg <lkml@metanurb.dk>
Cc: Linus Torvalds <torvalds@osdl.org>, James Morris <jmorris@redhat.com>,
       LKML Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re-implemented i586 asm AES (updated)
Message-ID: <20040807202630.GB16382@muc.de>
References: <2qbyt-1Op-45@gated-at.bofh.it> <2qemF-3Pj-49@gated-at.bofh.it> <m3wu0cgv6q.fsf@averell.firstfloor.org> <Pine.LNX.4.58.0408060941550.24588@ppc970.osdl.org> <1091864985.9992.0.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091864985.9992.0.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 07, 2004 at 09:49:45AM +0200, Kasper Sandberg wrote:
> i dont know anything at all about this, but wouldnt it be possible to
> optimize it even more, if there were a version for each cpu, like one
> for athlon-xp and one for p4?

I also haven't looked at the code (It seems except for Linus/James
everybody posting to this thread is clueless about the actual code -
is that a good sign or a bad one? ;-).

But if someone wanted to write such optimized versions .altinstructions
would make it easy to switch to the right version at runtime.  There 
is no bit for Athlon-XP right now, but for AMD K8 B/C and for P3/P4. 
A bit for XP could be relatively easily added. You can also test
for SSE2, MMX etc. which may be more generic.

-Andi
