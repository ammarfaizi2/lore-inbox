Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268695AbUILMoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268695AbUILMoy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 08:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268700AbUILMoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 08:44:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58051 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268695AbUILMov (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 08:44:51 -0400
Date: Sun, 12 Sep 2004 14:44:20 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu,
       viro@parcelfarce.linux.theplanet.co.uk, wli@holomorphy.com
Subject: Re: /proc/sys/kernel/pid_max issues
Message-ID: <20040912124420.GA29587@devserv.devel.redhat.com>
References: <20040912085609.GK32755@krispykreme> <1094991480.2626.0.camel@laptop.fenrus.com> <20040912122959.GN25741@krispykreme>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <20040912122959.GN25741@krispykreme>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 12, 2004 at 10:30:00PM +1000, Anton Blanchard wrote:
> 
> Hmm can you point the 16bit counter out? I can create 1 million NPTL
> threads on ppc64 easily, so why not?

/*
 * the semaphore definition
 */
struct rw_semaphore {
        /* XXX this should be able to be an atomic_t  -- paulus */
        signed int              count;
#define RWSEM_UNLOCKED_VALUE            0x00000000
#define RWSEM_ACTIVE_BIAS               0x00000001
#define RWSEM_ACTIVE_MASK               0x0000ffff

that counter is split in 2 16 bit entities....


--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBRESjxULwo51rQBIRAmwyAJ4jMR1h4SIRNpWJXZzrXZmv1wnPPACgoOIw
MJJU4i8MUAuCX2/t5guJiSs=
=4+jS
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
