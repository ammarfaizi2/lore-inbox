Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265654AbUGNErW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265654AbUGNErW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 00:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266905AbUGNErW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 00:47:22 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:37829 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S265654AbUGNErV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 00:47:21 -0400
Date: Wed, 14 Jul 2004 06:47:04 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: peter@mysql.com, linux-kernel@vger.kernel.org
Subject: Re: VM Problems in 2.6.7 (Too active OOM Killer)
Message-ID: <20040714044704.GY974@dualathlon.random>
References: <1089771823.15336.2461.camel@abyss.home> <20040714031701.GT974@dualathlon.random> <1089776640.15336.2557.camel@abyss.home> <20040714041026.GX974@dualathlon.random> <20040713212204.08fda0d6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040713212204.08fda0d6.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 09:22:04PM -0700, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > The oom killer is forbidden to run
> >  as long as `free` tells you that >= 4k of swap are still available to the
> >  OS.
> 
> That code was recently removed, so the OOM killer now kicks in if we run
> out of normal zone due to pinned allocations (stack pages, etc).

ah I didn't notice thanks for the info (I see it in the CVS), however he
was running 2.6.7 so the code I mentioned is still there in 2.6.7 and in
turn my suggestion will work fine there since it'll remove the oom
killer out of his way.
