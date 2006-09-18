Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751882AbWIRTpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbWIRTpt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 15:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751883AbWIRTpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 15:45:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42926 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751882AbWIRTps (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 15:45:48 -0400
Date: Mon, 18 Sep 2006 15:39:52 -0400
From: "Frank Ch. Eigler" <fche@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Vara Prasad <prasadav@us.ibm.com>, "Frank Ch. Eigler" <fche@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Paul Mundt <lethal@linux-sh.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       systemtap <systemtap@sourceware.org>
Subject: Re: tracepoint maintainance models
Message-ID: <20060918193952.GR3951@redhat.com>
References: <20060918011352.GB30835@elte.hu> <20060918122527.GC3951@redhat.com> <20060918150231.GA8197@elte.hu> <1158594491.6069.125.camel@localhost.localdomain> <20060918152230.GA12631@elte.hu> <1158596341.6069.130.camel@localhost.localdomain> <20060918161526.GL3951@redhat.com> <1158598927.6069.141.camel@localhost.localdomain> <450EEF2E.3090302@us.ibm.com> <1158608981.6069.167.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S66JdqtemGhvbcZP"
Content-Disposition: inline
In-Reply-To: <1158608981.6069.167.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--S66JdqtemGhvbcZP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi -

On Mon, Sep 18, 2006 at 08:49:40PM +0100, Alan Cox wrote:
> [...]
> Then what we really need by the sound of it is enough gcc smarts to do
> something of the form [...]
> 	.section "debugbits"
> [...]
> Can gcc do any of that for us today ?

This is not that different from what gcc does for DWARF.  Trouble is,
there appear to exist optimization transformations which make such
data difficult or impossible to generate.  (In particular, it is
unlikely to be easier to create specialized data like this if the
compiler can't be made to create first-class DWARF for the same probe
points / data values.)

- FChE

--S66JdqtemGhvbcZP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFFDvYIVZbdDOm/ZT0RArc1AJ9GfTUPAgyp/bEeTbn4v9xl6K6bkQCcCor1
Ep2Wcgg7R0lKp/Hey04W/2o=
=nJYr
-----END PGP SIGNATURE-----

--S66JdqtemGhvbcZP--
