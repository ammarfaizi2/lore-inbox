Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293347AbSCSA3E>; Mon, 18 Mar 2002 19:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293348AbSCSA2y>; Mon, 18 Mar 2002 19:28:54 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:60940 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S293347AbSCSA2v>;
	Mon, 18 Mar 2002 19:28:51 -0500
From: Cort Dougan <cort@fsmlabs.com>
Date: Mon, 18 Mar 2002 17:27:05 -0700
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: 7.52 second kernel compile
Message-ID: <20020318172705.O4783@host110.fsmlabs.com>
In-Reply-To: <20020318153637.J4783@host110.fsmlabs.com> <Pine.LNX.4.33.0203181446200.10517-100000@penguin.transmeta.com> <20020318.162217.44270627.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It would be easy to do with the debug registers on PPC but they're
supervisor level only.  Users have no need to profile their code, after
all.

A logic analyzer would be really handy here.  Dave, think you can swing
one? :)

I ended up using averages for my tests with the PPC when doing the MM
optimizations.  Wall-clock time tells you if you did a good thing or not,
but not what it was that you actually did :)

Any suggestions for a structure, Dave?

}    On Mon, 18 Mar 2002, Cort Dougan wrote:
}    > The cycle timer in this case is about 16.6MHz.
}    
}    Oh, you're cycle timer is too slow to be interesting, apparently ;(
} 
} We could modify the test program to use more portably timing functions
} and doing the TLB accesses several times over.  While this would get
} us something more reasonable on PPC, and be more portable, the results
} would be a bit less accurate because we'd be dealing effectively with
} averages instead of real cycle count samples.
