Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135947AbRAGHPv>; Sun, 7 Jan 2001 02:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135948AbRAGHPl>; Sun, 7 Jan 2001 02:15:41 -0500
Received: from Cantor.suse.de ([194.112.123.193]:30989 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S135947AbRAGHPg>;
	Sun, 7 Jan 2001 02:15:36 -0500
Date: Sun, 7 Jan 2001 08:15:33 +0100
From: Andi Kleen <ak@suse.de>
To: Ben Greear <greearb@candelatech.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission policy!) (Benchmarks)
Message-ID: <20010107081533.A16077@gruyere.muc.suse.de>
In-Reply-To: <3A578F27.D2A9DF52@candelatech.com> <20010107042959.A14330@gruyere.muc.suse.de> <3A580B31.7998C783@candelatech.com> <20010107062744.A15198@gruyere.muc.suse.de> <3A58249F.86DD52BC@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A58249F.86DD52BC@candelatech.com>; from greearb@candelatech.com on Sun, Jan 07, 2001 at 01:11:11AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2001 at 01:11:11AM -0700, Ben Greear wrote:
> > Packet socket binding or SO_BINDTODEVICE will search the list, but it is unlikely
> > that these paths are worth optimizing for.
> 
> The patch has been written, so even if it helps just a little more than it
> hurts, it might be worth including.  Of course, it may actually hurt more
> than help.
> 
> I'd be very interested in lucid arguments as to why adding the patch would
> actually be worse than not adding it, not just why I'm lame for considering
> it *grin* :)

It's like David said: it's not a very good idea to tune things that are not
commonly used. If some user really realistically has some workload where the
linear search is a bottleneck it can be considered. Currently it doesn't look
like it.




-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
