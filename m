Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWDWHpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWDWHpb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 03:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbWDWHpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 03:45:31 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:7859 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751344AbWDWHpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 03:45:31 -0400
Date: Sun, 23 Apr 2006 09:45:11 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jim Ramsay <kernel@jimramsay.com>
Cc: Thiago Galesi <thiagogalesi@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Possible MTD bug in 2.6.15
Message-ID: <20060423074511.GA19326@wohnheim.fh-wedel.de>
References: <1145723704.3524.TMDA@mail.tag.jimramsay.com> <4789af9e0604220949i2757e408qa5de3a9e728e966f@mail.gmail.com> <82ecf08e0604221008ieb22a4cuc59be570cf025bba@mail.gmail.com> <4789af9e0604222048g5a10b573pf687f137a2e99042@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4789af9e0604222048g5a10b573pf687f137a2e99042@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 April 2006 21:48:28 -0600, Jim Ramsay wrote:
> 
> And really, it's not a big stretch from what the code currently does
> to what my patch changes.  At this point in the code, we know for a
> fact that we already have at least one flash chip.  The math that's
> going on here with the 'max_chips' variable is to check if there is
> actually more than one physical chip implementing the entire reported
> size.  The only mistake is that the math goes too far, shifting the
> count down to zero if the reported size is too small.  This
> 'max_chips' should never be allowed to be lower than 1, because we
> really do know that there is at least one flash chip.

In a setup like yours, someone should go and educate hardware
developers.

Anyway, if you add a CONFIG_BROKEN_HARDWARE of some sorts to your
patch and send it to the proper list (linux-mtd@lists.infradead.org),
I don't have a problem with your patch.

Jörn

-- 
To announce that there must be no criticism of the President, or that we
are to stand by the President, right or wrong, is not only unpatriotic
and servile, but is morally treasonable to the American public.
-- Theodore Roosevelt, Kansas City Star, 1918
