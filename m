Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVCCPIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVCCPIm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 10:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVCCPIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 10:08:42 -0500
Received: from eth0-0.arisu.projectdream.org ([194.158.4.191]:57312 "EHLO
	b.mx.projectdream.org") by vger.kernel.org with ESMTP
	id S261216AbVCCPIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 10:08:34 -0500
Date: Thu, 3 Mar 2005 16:08:51 +0100
From: Thomas Graf <tgraf@suug.ch>
To: "David S. Miller" <davem@davemloft.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303150851.GW31837@postel.suug.ch>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <42264F6C.8030508@pobox.com> <20050302162312.06e22e70.akpm@osdl.org> <42265A6F.8030609@pobox.com> <20050302165830.0a74b85c.davem@davemloft.net> <42267737.4070702@pobox.com> <20050302200508.16acd5cf.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050302200508.16acd5cf.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David S. Miller 2005-03-02 20:05
> On Wed, 02 Mar 2005 21:32:23 -0500
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> > I also note that part of the problem that motivates the even/odd thing 
> > is a tacit acknowledgement that people only _really_ test the official 
> > releases.
> > 
> > Which IMHO backs up my opinion that we simply need more frequent releases.
> 
> This more frequent release idea will basically mimmick what the
> even/odd idea will do, except that even/odd will have specific
> engineering goals.  Development vs. pure bug fixing.

Agreed, more frequent releases, even/odd, and 2.6.x.y all get down to
the same idea being making it easier for the end-user to test it and
thus achieving releases with less regressions.

I don't see any difference between 2.6.x.y and even/odd regarding
the process just after a stable release. The 2.6.x.y clearly has
the advantage that all those small nasty bugfixes such as missing
exports, typos and all the other one-liners can be brought to the end
user more easly in the middle of a development cycle. The even/odd
idea cleary has the advantage of a clear statement regarding what will
be the final release candidate. So let's combine both ideas and
get the advantages of both.

I think it is completely unimportant how to call it, be it .odd,
.even-test, .even-final-rc, 2.6.x.0 or whathever. The most important
part is to communicate this to the end-user. A well formed release
diagram on kernel.org would do just fine.

Basically it gets down to this:

 + > start of development cycle
 |            |<--+
 |            v   |
 |           rcX -+
 |            |
 |            v
 |         final rc
 |            | (Only fixes here)
 |            v
 +----- stable release -----> fixes branch---+
                         ^                   |
                         +-------------------+

It's already like this right now except that the final rc isn't
marked as such and a branch for stable release fixes (including
only the very imporant fixes) is missing.  The situation for the
maintainers wouldn't change a bit.

Applied to combined even/odd and 2.6.x.y it would be:

    2.6.12 -> 2.6.13-rcX -> 2.6.13 -> 2.6.14 -> 2.6.15-rcX
                                        |
                                        v
                                     2.6.14.y

My personal preference would be to suffix the final odd release with
-test just to more clearly mark it but that's a very minor cosmetic thing.

I'm not sure wehther the test release thing will increase the number
of testers but it's sure worth a try. A real advantage would be that
everyone interested in a smooth migration to the next stable release
can give the test release a try and will see eventual regressions
fixed before the final stable release with a very low risk of new
regressions.
