Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129184AbRAZPFE>; Fri, 26 Jan 2001 10:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129390AbRAZPEp>; Fri, 26 Jan 2001 10:04:45 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:43535 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S129184AbRAZPEh>; Fri, 26 Jan 2001 10:04:37 -0500
Date: Fri, 26 Jan 2001 16:03:42 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: James Sutherland <jas88@cam.ac.uk>, "David S. Miller" <davem@redhat.com>,
        Matti Aarnio <matti.aarnio@zmailer.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
Message-ID: <20010126160342.B7096@pcep-jamie.cern.ch>
In-Reply-To: <20010126124426.O2360@marowsky-bree.de> <Pine.SOL.4.21.0101261344120.11126-100000@red.csi.cam.ac.uk> <20010126154447.L3849@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010126154447.L3849@marowsky-bree.de>; from lmb@suse.de on Fri, Jan 26, 2001 at 03:44:47PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars Marowsky-Bree wrote:
> First, you are ignoring a TCP_RST, which means "stop trying". 

That's why we stop when we receive the second TCP RST.
It's just like dropping due to congestion, which is of course perfectly
safe in moderation.

> You would have to retry a connection with a new source port. How do
> you handle cases where the application explicitly bound the socket to
> a specific source port / source IP ?

Applications tend not to.  Do we care about those that do?

> Caching whether the site is able to speak ECN or not is also
> suboptimal if the local site is opening lots of outgoing connections,
> like a proxy server. (Of course, memory has gotten cheap)
> 
> _And_ it is solving the problem on the wrong end.

It would not solve the problem at all, if there's no incentive to switch
to ECN.  But then, why force people to use ECN if there's no advantage
to it anyway?

Does ECN provide perceived benefits to the node using it?

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
