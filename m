Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131204AbRAGMNd>; Sun, 7 Jan 2001 07:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131208AbRAGMNX>; Sun, 7 Jan 2001 07:13:23 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:21765
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S131204AbRAGMNL>; Sun, 7 Jan 2001 07:13:11 -0500
Date: Mon, 8 Jan 2001 01:13:08 +1300
From: Chris Wedgwood <cw@f00f.org>
To: David Ford <david@linux.com>
Cc: Ben Greear <greearb@candelatech.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission policy!)
Message-ID: <20010108011308.A2575@metastasis.f00f.org>
In-Reply-To: <20010107162905.B1804@metastasis.f00f.org> <Pine.LNX.4.10.10101070220410.4173-100000@Huntington-Beach.Blue-Labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10101070220410.4173-100000@Huntington-Beach.Blue-Labs.org>; from david@linux.com on Sun, Jan 07, 2001 at 02:22:31AM -0800
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2001 at 02:22:31AM -0800, David Ford wrote:

    BIND copes just fine, how would it not?  I haven't heard any
    problems with routing daemons either.

Bind knows about multiple virtual interfaces; but we can also have
multiple addresses on a single interface and have no virtual
interfaces at all.

I doubt bind knows about this nor handles it.

<pause>

OK, I'm a liar -- bind does handle this. Cool.

Jan  8 01:09:12 tapu named[599]: listening on [127.0.0.1].53 (lo)
Jan  8 01:09:12 tapu named[599]: listening on [10.0.0.1].53 (lo)
Jan  8 01:09:12 tapu named[599]: listening on [x.x.x.x].53 (x0)
Jan  8 01:09:12 tapu named[599]: Forwarding source address is [0.0.0.0].1032

This is good news, because it means there is a precedent for multiple
addresses on a single interface so we can kill the <ifname>:<n>
syntax in favor of the above which is cleaner of more accurately
represents what is happening.



  --cw
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
