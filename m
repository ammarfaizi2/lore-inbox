Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316664AbSGYXE4>; Thu, 25 Jul 2002 19:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316678AbSGYXE4>; Thu, 25 Jul 2002 19:04:56 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:57805 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S316664AbSGYXEz>;
	Thu, 25 Jul 2002 19:04:55 -0400
From: Cort Dougan <cort@fsmlabs.com>
Date: Thu, 25 Jul 2002 17:01:13 -0600
To: Andrea Arcangeli <andrea@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cheap lookup of symbol names on oops()
Message-ID: <20020725170113.F5326@host110.fsmlabs.com>
References: <20020725110033.G2276@host110.fsmlabs.com> <20020725181126.A17859@infradead.org> <20020725112142.I2276@host110.fsmlabs.com> <20020725190445.GO1180@dualathlon.random> <20020725142716.N2276@host110.fsmlabs.com> <20020725205910.GR1180@dualathlon.random> <20020725150525.Q2276@host110.fsmlabs.com> <20020725220643.GT1180@dualathlon.random> <20020725160559.X2276@host110.fsmlabs.com> <20020725225613.GW1180@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020725225613.GW1180@dualathlon.random>; from andrea@suse.de on Fri, Jul 26, 2002 at 12:56:13AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote the critter on my x86 laptop and dualathlon desktop.  I only did
additional testing on PPC.  Both give me bunches of symbols.

Stock redhat 7.2 gives me hundreds of module symbols when I load up a bunch
of modules (via ksyms -a or cat /proc/ksyms).  A cross-build of
stock modutils-2.4.16 for x86->ppc gives me the same.

} It's really weird that the patch works in a generic manner for you, maybe our
} userspace side is different than, or maybe it's a difference on ppc where
} you're not trimming the symbol list to the exported functions?

I'm testing with multi .c modules.  I haven't tested with a single
.c module though.

} I guess it worked for you because you've single file .c modules, that interface
} with each other, so there every extern function is going to be exported.
} 
} modutils could build the whole symbol table if asked to, so with a change of
} insmod you could make your patch to work in a generic manner for all
} module symbols too, but it would be a waste of ram like kksymoops.
