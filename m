Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265285AbTAJQYP>; Fri, 10 Jan 2003 11:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265368AbTAJQYP>; Fri, 10 Jan 2003 11:24:15 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:53906
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265285AbTAJQYM>; Fri, 10 Jan 2003 11:24:12 -0500
Subject: Re: any chance of 2.6.0-test*?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030110161012.GD2041@holomorphy.com>
References: <20030110161012.GD2041@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042219147.31848.65.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 10 Jan 2003 17:19:08 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-10 at 16:10, William Lee Irwin III wrote:
> Any specific concerns/issues/wishlist items you want taken care of
> before doing it or is it a "generalized comfort level" kind of thing?
> Let me know, I'd be much obliged for specific directions to move in.

IDE is all broken still and will take at least another three months to
fix - before we get to 'improve'. The entire tty layer locking is terminally
broken and nobody has even started fixing it. Just try a mass of parallel
tty/pty activity . It was problematic before, pre-empt has taken it  to dead, 
defunct and buried. 

Most of the drivers still don't build either.

I think its important that we get to the stage that we can actually say

- It compiles (as close to all the mainstream bits of it as possible)
- The stuff that is destined for the bitbucket is marked in Config and people
  agree it should go
- It works (certainly the common stuff)
- Its statistically unlikely to eat your computer
- It passes Cerberus uniprocessor and smp with/without pre-empt

Otherwise everyone wil rapidly decide that ".0-pre" means ".0 as in Windows"
at which point you've just destroyed your testing base.

Given all the new stuff should be in, I'd like to see a Linus the meanie
round of updating for a while which is simply about getting all the 2.4 fixes
and the 2.5 driver compile bugs nailed, and if it doesn't fix a compile bug
or a logic bug it doesn't go in.

No more "ISAPnP TNG" and module rewrites please

Alan

