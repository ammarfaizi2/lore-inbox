Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264182AbUE2IqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264182AbUE2IqZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 04:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264188AbUE2IqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 04:46:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56475 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264124AbUE2IqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 04:46:07 -0400
Date: Sat, 29 May 2004 10:45:26 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: michael@optusnet.com.au
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_IRQBALANCE for AMD64?
Message-ID: <20040529084526.GB29552@devserv.devel.redhat.com>
References: <7F740D512C7C1046AB53446D372001730182BB40@scsmsx402.amr.corp.intel.com> <2750000.1085769212@flay> <20040528184411.GE9898@devserv.devel.redhat.com> <m1zn7r7hh1.fsf@mo.optusnet.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Content-Disposition: inline
In-Reply-To: <m1zn7r7hh1.fsf@mo.optusnet.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 29, 2004 at 06:41:46PM +1000, michael@optusnet.com.au wrote:
> Arjan van de Ven <arjanv@redhat.com> writes:
> > On Fri, May 28, 2004 at 11:33:32AM -0700, Martin J. Bligh wrote:
> [...]
> > > Also, we may well have more than 1 CPU's worth of traffic to
> > > process in a large network server.
> > 
> > One NIC? I've yet to see that ;)
> 
> Oh, and another corner case. 
> 
> Say you have a cpu-bound process on an SMP box.
> Say you're also using a large chunk of a CPU processing
> interrupts from a single IRQ.
> 
> What stops the cpu-bound process being scheduled onto
> the same CPU as the interrupt handlers?
> 
> Now you've got one idle CPU, and one seriously overloaded
> CPU.

yes and the only real answer here is to make the scheduler move the process.
"balancing" the irq (say every other irq) will actually use BOTH cpus 100%
(yes balancing is that expensive due to cache misses :)


--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAuE2lxULwo51rQBIRAtCyAJ43mrm8CAWFydUreEKPI4J1jGY+bgCfeXZc
x1RloXyhborG3skjBtL69Zc=
=uSfi
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--
