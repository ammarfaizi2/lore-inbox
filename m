Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbTIWBUR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 21:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262799AbTIWBUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 21:20:17 -0400
Received: from newsmtp.golden.net ([199.166.210.106]:7698 "EHLO
	newsmtp.golden.net") by vger.kernel.org with ESMTP id S261762AbTIWBUN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 21:20:13 -0400
Date: Mon, 22 Sep 2003 21:19:47 -0400
From: Paul Mundt <lethal@linux-sh.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, Robert Walsh <rjwalsh@durables.org>,
       wangdi <wangdi@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] netpoll-core
Message-ID: <20030923011947.GA9873@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
	Robert Walsh <rjwalsh@durables.org>, wangdi <wangdi@clusterfs.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20030922184526.GL2414@waste.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <20030922184526.GL2414@waste.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 22, 2003 at 01:45:26PM -0500, Matt Mackall wrote:
> +static void zap_completion_queue(void)
> +{
> +	unsigned long flags;
> +	struct softnet_data *sd = &get_cpu_var(softnet_data);
> +
> +	if (sd->completion_queue) {
> +		struct sk_buff *clist;
> +
> +		local_irq_save(flags);
> +		clist = sd->completion_queue;
> +		sd->completion_queue = NULL;
> +		local_irq_save(flags);
		^^^^^^^^^^^^^^^^^^^^^

Two consecutive local_irq_save()'s?


--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/b5+z1K+teJFxZ9wRAhuvAJ9rrcJXSiji0zJT8gqjx25iipS4WACdEKgF
Llyxc68kAYYpTrT5M5eItrE=
=OZ7g
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
