Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263483AbUE1UEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263483AbUE1UEq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 16:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263843AbUE1UEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 16:04:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14039 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263483AbUE1UEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 16:04:42 -0400
Date: Fri, 28 May 2004 22:03:28 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Nivedita Singhvi <niv@us.ibm.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Jeff Garzik <jgarzik@pobox.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Andrew Morton <akpm@osdl.org>,
       Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_IRQBALANCE for AMD64?
Message-ID: <20040528200328.GJ9898@devserv.devel.redhat.com>
References: <7F740D512C7C1046AB53446D372001730182BAE2@scsmsx402.amr.corp.intel.com> <40B7797F.2090204@pobox.com> <17750000.1085766378@flay> <20040528175724.GC9898@devserv.devel.redhat.com> <40B7984E.7040208@us.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/D3X8sky0X3AmG5"
Content-Disposition: inline
In-Reply-To: <40B7984E.7040208@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--W/D3X8sky0X3AmG5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 28, 2004 at 12:51:42PM -0700, Nivedita Singhvi wrote:
> The irqbalanced is a user space daemon that attempts to
> balance irqs across CPUs. It keeps track of the current
> irq counts on the CPUs, and at regular intervals applies
> changes to irq binding in order to implement the desired
> policy. It achieves a high-level long term balance of irqs
> across CPUs.
> 
> This is a fairly expensive but generally arch independent
> (as long as they support cpu binding of irqs) method to
> achieve long term distribution of interrupts.

it's not THAT expensive. Really.


> I think this is best used for fairly balanced (over time)
> long running workloads. For short workloads which demonstrate
> intense activity in bursts, this won't be as effective.

intense bursts average out... and to be honest, in bursts the last thing you
want to do is move it to different cpus all the time since then you get so
much cross cpu cache misses and you are far slower....


--W/D3X8sky0X3AmG5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAt5sPxULwo51rQBIRAivMAJ9T0Nw2D/xUrMq+51mHymBAPznQigCgmvMv
NFxTMla8nVRsG+mRTfKtL7w=
=NYqB
-----END PGP SIGNATURE-----

--W/D3X8sky0X3AmG5--
