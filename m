Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbWINHnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbWINHnc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 03:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWINHnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 03:43:32 -0400
Received: from agent.admingilde.org ([213.95.21.5]:30649 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP
	id S1751439AbWINHnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 03:43:31 -0400
Date: Thu, 14 Sep 2006 09:43:06 +0200
From: Martin Waitz <tali@admingilde.org>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 4/11] LTTng-core 0.5.108 : core
Message-ID: <20060914074306.GQ17042@admingilde.org>
Mail-Followup-To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
	Michel Dagenais <michel.dagenais@polymtl.ca>
References: <20060914034308.GE2194@Krystal>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PtLnLSExlPr13a2X"
Content-Disposition: inline
In-Reply-To: <20060914034308.GE2194@Krystal>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PtLnLSExlPr13a2X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Sep 13, 2006 at 11:43:08PM -0400, Mathieu Desnoyers wrote:
> +int ltt_module_register(enum ltt_module_function name, void *function,
> +		struct module *owner)
> +{
> +	int ret =3D 0;
> +=09
> +	/* Protect these operations by disallowing them when tracing is
> +	 * active */
> +	if(ltt_traces.num_active_traces) {
> +		ret =3D -EBUSY;
> +		goto end;
> +	}

what would happen otherwise?
can it happen that someone enables tracing between this check and
the rest of the function?

> +	new_trace->transport =3D transport;
> +	new_trace->ops =3D &transport->ops;
> +
> +	err =3D -new_trace->ops->create_dirs(new_trace);
              ^ typo or intentional?


--=20
Martin Waitz

--PtLnLSExlPr13a2X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFCQgKj/Eaxd/oD7IRAu5UAJ4hdLLLXA84BFwxquyL0wk1hEwkQACeO/jG
7JxzcMlAKGiGi7WTGM0raN0=
=qnl1
-----END PGP SIGNATURE-----

--PtLnLSExlPr13a2X--
