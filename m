Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbTIGV55 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 17:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbTIGV55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 17:57:57 -0400
Received: from ns.suse.de ([195.135.220.2]:41676 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261663AbTIGV5z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 17:57:55 -0400
To: peter_daum@t-online.de (Peter Daum)
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.4 patch] fix CONFIG_X86_L1_CACHE_SHIFT
References: <20030907195557.GK14436@fs.tum.de.suse.lists.linux.kernel>
	<Pine.LNX.4.30.0309072228110.9987-100000@swamp.bayern.net.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 07 Sep 2003 23:57:52 +0200
In-Reply-To: <Pine.LNX.4.30.0309072228110.9987-100000@swamp.bayern.net.suse.lists.linux.kernel>
Message-ID: <p73pticjm73.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

peter_daum@t-online.de (Peter Daum) writes:

> ... actually, the problems also occurred when running on machines
> with Pentium II/Pentium Pro CPUs - even on these machines, I only
> could use kernels compiled with "CONFIG_MPENTIUM4".
> 
> Adrian's patch does fix these problems. What is amazing, is that
> in kernel version 2.4.20, the same values were used for
> "CONFIG_X86_L1_CACHE_SHIFT". The problems that I described,
> however, occur only with 2.4.22 - the same machines with the same
> configuration work just fine with 2.4.20. Maybe, there's
> something else involved, too?

Yes it very much sounds like some memory corruption that is just
masked by the bigger cacheline padding.

Maybe you should try to compile with CONFIG_DEBUG_SLAB on 
and see if it triggers something?

The padding itself is a pure optimization, if it changes any behaviour
that's a bug.

-Andi
