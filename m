Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263784AbUE1SpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263784AbUE1SpY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 14:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263786AbUE1SpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 14:45:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2734 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263784AbUE1SpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 14:45:16 -0400
Date: Fri, 28 May 2004 20:44:11 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
       linux-kernel@vger.kernel.org
Subject: Re: CONFIG_IRQBALANCE for AMD64?
Message-ID: <20040528184411.GE9898@devserv.devel.redhat.com>
References: <7F740D512C7C1046AB53446D372001730182BB40@scsmsx402.amr.corp.intel.com> <2750000.1085769212@flay>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ryJZkp9/svQ58syV"
Content-Disposition: inline
In-Reply-To: <2750000.1085769212@flay>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ryJZkp9/svQ58syV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 28, 2004 at 11:33:32AM -0700, Martin J. Bligh wrote:
> Here's my start at a list ... I'm sure it's woefully incomplete.
> 
> 1. Utilize all CPUs roughly evenly for IRQ processing load (anything that's
> not measured by the scheduler at least, because it's unfair to other 
> processes).

yep; irqbalance approximates irq processing load by irq count, which seems
to be ok-ish so far.

> Also, we may well have more than 1 CPU's worth of traffic to
> process in a large network server.

One NIC? I've yet to see that ;)

> 2. Provide some sort of cache-affinity for network interrupt processing,
> which also helps us not get into out-of-order packet situations.

yep; irqbalance does that 

> 3. Utilize idle CPUs where possible to shoulder the load.

this is in direct conflict with 2; esp since cpus are idle very short times
all the time in busy scenarios (and non-busy scenarios are boring wrt irq
loadf ;)

 
> 4. Provide such a solution for all architectures.

irqbalanced in principle arch independent since the /proc interface is quite
generic..

--ryJZkp9/svQ58syV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAt4h6xULwo51rQBIRAkC8AJ0dgvJwyEdXMUvWrvcEra6tbXJZiACfZ0CY
o6uZbyxnRW6SM2w8uIw4VIw=
=j+4E
-----END PGP SIGNATURE-----

--ryJZkp9/svQ58syV--
