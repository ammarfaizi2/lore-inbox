Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267514AbSIRRdR>; Wed, 18 Sep 2002 13:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267603AbSIRRdQ>; Wed, 18 Sep 2002 13:33:16 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:37848 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S267514AbSIRRdQ>;
	Wed, 18 Sep 2002 13:33:16 -0400
From: Cort Dougan <cort@fsmlabs.com>
Date: Wed, 18 Sep 2002 11:35:51 -0600
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, Rik van Riel <riel@conectiva.com.br>,
       Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process() elimination, 2.5.35-BK
Message-ID: <20020918113551.A654@host110.fsmlabs.com>
References: <Pine.LNX.4.44.0209181902000.23619-100000@localhost.localdomain> <Pine.LNX.4.44.0209181026550.1230-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0209181026550.1230-100000@home.transmeta.com>; from torvalds@transmeta.com on Wed, Sep 18, 2002 at 10:30:35AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's also not a bad idea to sometimes say "Linux cannot do that".  Trying
to make the system do _everything_ will result in it doing many things very
poorly.

} Again, you're talking about entirely theoretical numbers that have no 
} relevance for real life. 
} 
} Sure, you can do that. But a real life box? Nope.
} 
} >						 Or in 1.25 hours
} > on an 8-way box. And then we are back to step #1: trying to pass over
} > already allocated PIDs by destroying the contents of the L1 and L2 cache
} > once for each allocated PID passed.
} 
} So? It happens very rarely, and..
} 
} >			 Sure, with 2 billion PIDs space that
} > averages out, but it's an algorithm with a very nasty worst-case behavior,
} > which is not so hard to trigger.
} 
} ... the worst-case-behaviour is basically impossible to trigger with any 
} real load. 
} 
} The worst case does not happen for "100k threads" like you've made it 
} sound like.
} 
} The worst case happens for "100k threads consecutive in the pid space".
} 
} Which means that not only do you have to roll over, you have to roll over 
} with a humungous number of threads _still_ occupying their old consecutive 
} positions when you roll over.
} 
} I repeat: you're making up schenarios that simply have no relevance to 
} real life.
} 
} 		Linus
} 
} -
} To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
} the body of a message to majordomo@vger.kernel.org
} More majordomo info at  http://vger.kernel.org/majordomo-info.html
} Please read the FAQ at  http://www.tux.org/lkml/
