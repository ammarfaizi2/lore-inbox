Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318229AbSIKAQ0>; Tue, 10 Sep 2002 20:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318230AbSIKAQ0>; Tue, 10 Sep 2002 20:16:26 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:3054 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S318229AbSIKAQ0>; Tue, 10 Sep 2002 20:16:26 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: James Bottomley <James.Bottomley@steeleye.com>
Date: Wed, 11 Sep 2002 10:21:04 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15742.35952.363082.526569@notabene.cse.unsw.edu.au>
Cc: Lars Marowsky-Bree <lmb@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Multi-path IO in 2.5/2.6 ?
In-Reply-To: message from James Bottomley on Monday September 9
References: <200209091458.g89Evv806056@localhost.localdomain>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday September 9, James.Bottomley@steeleye.com wrote:
> 
> Well, neither of the people most involved in the development (that's Neil 
> Brown for md in general and Ingo Molnar for the multi-path enhancements) made 
> any comments---see if you can elicit some feedback from either of them.

I'm fairly un-interested in multipath.  I try not to break it while
tidying up the generic md code, but apart from that I leave it alone.

For failover, I suspect that md is an appropriate place for multipath,
though it would be nice to get more detail error information from the
lower levels.

For load balancing you really need something lower down, just below
the elevator would seem right: at the request_fn level rather than
make_request_fn.

But all that has pretty much been said.

NeilBrown
