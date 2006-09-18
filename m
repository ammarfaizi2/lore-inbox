Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751794AbWIRPtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbWIRPtJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 11:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbWIRPtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 11:49:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24252 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751794AbWIRPtH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 11:49:07 -0400
Date: Mon, 18 Sep 2006 11:47:07 -0400
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
Message-ID: <20060918154707.GJ3951@redhat.com>
References: <450D182B.9060300@opersys.com> <20060917112128.GA3170@localhost.usen.ad.jp> <20060917143623.GB15534@elte.hu> <20060917153633.GA29987@Krystal> <20060918000703.GA22752@elte.hu> <450DF28E.3050101@opersys.com> <20060918011352.GB30835@elte.hu> <20060918122527.GC3951@redhat.com> <20060918150231.GA8197@elte.hu> <1158594491.6069.125.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A9z/3b/E4MkkD+7G"
Content-Disposition: inline
In-Reply-To: <1158594491.6069.125.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--A9z/3b/E4MkkD+7G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi -

alan wrote:

> I think your implementation is questionable if it causes any kind of
> jumps and conditions, even marked unlikely. Just put the needed data in
> a seperate section which can be used by the debugging tools. [...]
> No need to actually mess with the code for the usual cases.

Trouble is that it is specifically the *unusual* cases that need
compiler assistance via static markers, otherwise we'd manage with
just k/djprobes & debuginfo type efforts.

- FChE

--A9z/3b/E4MkkD+7G
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFFDr97VZbdDOm/ZT0RArQmAJ9Ae6J5RJK42fXpDhvGDXUXtiQhaQCfWLn0
0NRZRcIT4JtLPFggxewEuNM=
=zdic
-----END PGP SIGNATURE-----

--A9z/3b/E4MkkD+7G--
