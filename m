Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQLGJPc>; Thu, 7 Dec 2000 04:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129406AbQLGJPW>; Thu, 7 Dec 2000 04:15:22 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:62724
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S129345AbQLGJPG>; Thu, 7 Dec 2000 04:15:06 -0500
Date: Thu, 7 Dec 2000 21:44:36 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Donald Becker <becker@scyld.com>
Cc: Francois Romieu <romieu@cogenit.fr>, Russell King <rmk@arm.linux.org.uk>,
        Ivan Passos <lists@cyclades.com>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: [RFC] Configuring synchronous interfaces in Linux
Message-ID: <20001207214436.A7974@metastasis.f00f.org>
In-Reply-To: <20001203075958.A1121@metastasis.f00f.org> <Pine.LNX.4.10.10012021412560.16980-100000@vaio.greennet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012021412560.16980-100000@vaio.greennet>; from becker@scyld.com on Sat, Dec 02, 2000 at 02:48:10PM -0500
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2000 at 02:48:10PM -0500, Donald Becker wrote:

    It's certainly possible to break the driver up, but it will be
    even more of a problem to maintain.  Some of the complicated
    media selection code applies to several generations.  Splitting
    the driver to have a copy for each generation means a lot of
    duplicated code, which quickly leads to version skew.

So how does someone, like me for example, try to cleanly add support
for something like ethtool when the only hardware they have is say
3c920 and they could care less about the rest?

The best thing I can see to do is to restructure the driver as is and
try to get common paths for things like media setting and remove the
module parameter hacks we now have; that way it should be possible to
add ethtool support that works for everything...

... how does that sound?



  --cw

P.S. Also, since only _two_ drivers actually support ethtool (hme and
     acenic) is everyone 100% happy they want this API? Surely now is
     the best time to invite discussion and promote ideas if people
     have requirements that ethtool can't satisfy?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
