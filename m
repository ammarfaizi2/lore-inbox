Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbVDCOOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbVDCOOk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 10:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbVDCOOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 10:14:39 -0400
Received: from smtp1.adl2.internode.on.net ([203.16.214.181]:2313 "EHLO
	smtp1.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S261779AbVDCOOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 10:14:20 -0400
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
Organization: IBM LTC
To: Linux Kernel list <linux-kernel@vger.kernel.org>, paulmck@us.ibm.com
Subject: Re: [RFC,PATCH 2/4] Deprecate synchronize_kernel, GPL replacement
Date: Mon, 4 Apr 2005 00:11:56 +1000
User-Agent: KMail/1.7.2
Cc: dipankar@in.ibm.com, shemminger@osdl.org, manfred@colorfullife.com,
       bunk@stusta.de
References: <20050403062149.GA1656@us.ibm.com>
In-Reply-To: <20050403062149.GA1656@us.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1744802.u3783VJgXj";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200504040012.00616.michael@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1744802.u3783VJgXj
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Paul,

I'm not quite clear on the difference between the two synchronize functions=
 ,=20
the comment for synchronize_sched() seems to have a bit missing? (see below)

cheers

On Sun, 3 Apr 2005 16:21, Paul E. McKenney wrote:
> +/**
> + * synchronize_sched - block until all CPUs have exited any non-preempti=
ve
> + * kernel code sequences.
> + *
> + * This means that all preempt_disable code sequences, including NMI and
> + * hardware-interrupt handlers, in progress on entry will have completed
> + * before this primitive returns.  However, this does not guarantee that
> + * softirq handlers will have completed, since in some kernels

??

> + *
> + * This primitive provides the guarantees made by the (deprecated)
> + * synchronize_kernel() API.  In contrast, synchronize_rcu() only
> + * guarantees that rcu_read_lock() sections will have completed.
> + */
> +#define synchronize_sched() synchronize_rcu()

--nextPart1744802.u3783VJgXj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCT/mwdSjSd0sB4dIRAhBxAKCzl3ZO3KYGoyCTHEmzQx9l5K5iFQCeJlXN
kMESIG3J5aqygr/YmSJOZGw=
=BGH2
-----END PGP SIGNATURE-----

--nextPart1744802.u3783VJgXj--
