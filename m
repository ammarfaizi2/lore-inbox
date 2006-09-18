Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965292AbWIRQSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965292AbWIRQSR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 12:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965290AbWIRQSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 12:18:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59861 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965287AbWIRQSO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 12:18:14 -0400
Date: Mon, 18 Sep 2006 12:15:26 -0400
From: "Frank Ch. Eigler" <fche@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>, "Frank Ch. Eigler" <fche@redhat.com>,
       Paul Mundt <lethal@linux-sh.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: tracepoint maintainance models
Message-ID: <20060918161526.GL3951@redhat.com>
References: <20060917143623.GB15534@elte.hu> <20060917153633.GA29987@Krystal> <20060918000703.GA22752@elte.hu> <450DF28E.3050101@opersys.com> <20060918011352.GB30835@elte.hu> <20060918122527.GC3951@redhat.com> <20060918150231.GA8197@elte.hu> <1158594491.6069.125.camel@localhost.localdomain> <20060918152230.GA12631@elte.hu> <1158596341.6069.130.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AGZzQgpsuUlWC1xT"
Content-Disposition: inline
In-Reply-To: <1158596341.6069.130.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AGZzQgpsuUlWC1xT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi -

alan wrote:

> [...] So its L1 misses more register reloads and the like. Sounds
> more and more like wasted clock cycles for debug. [...]

But it's not just "for debug"!  It is for system administrators,
end-users, developers.

> Its one thing to dump trace helper data into the kernel, its another
> when we all get to pay for it all the time when we don't need to
> [...]

Indeed, there will be some non-zero execution-time cost.  We must be
willing to pay *something* in order to enable this functionality.  One
question (still: http://lkml.org/lkml/2006/2/22/166) is trading
time/space cost; others include cross-platform vs. porting necessity;
robustness w.r.t. data-collectionand control-flow preservation.

- FChE

--AGZzQgpsuUlWC1xT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFFDsYeVZbdDOm/ZT0RAkcQAKCHE9UBqwcPb9kK9ilLOsp/qiS7cQCcDZB5
y5Mb9NxXT0sChPYB9B7JbEA=
=y185
-----END PGP SIGNATURE-----

--AGZzQgpsuUlWC1xT--
