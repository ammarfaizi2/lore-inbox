Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265354AbUAAKmx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 05:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265379AbUAAKmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 05:42:53 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:18306 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S265354AbUAAKmv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 05:42:51 -0500
Subject: Re: swapper: page allocation failure. order:3, mode:0x20
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Anton Blanchard <anton@samba.org>
Cc: Joonas Kortesalmi <joneskoo@derbian.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <20040101102720.GL28023@krispykreme>
References: <20040101093553.GA24788@derbian.org>
	 <20040101101541.GJ28023@krispykreme>  <20040101102720.GL28023@krispykreme>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-v3iCwPJgf8NDwW811ufo"
Organization: Red Hat, Inc.
Message-Id: <1072953755.4429.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 01 Jan 2004 11:42:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-v3iCwPJgf8NDwW811ufo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-01-01 at 11:27, Anton Blanchard wrote:
>  regardless it still makes sense to explore
> rx skb refill outside of interrupt context idea.

could be done in 2 steps; eg have a "normal path" that starts refilling
from process context if, say, half the skbs are used but an emergency
fallback to do it from irq context if for whatever reason the process
context didn't get around to it....

--=-v3iCwPJgf8NDwW811ufo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/8/mZxULwo51rQBIRAvHQAJ9g5Lt+ZQOTbrroZLAoyVq4RdEcvQCggP+J
OK/FE5rZXk+ybQpQ+cZs1Fs=
=x3E6
-----END PGP SIGNATURE-----

--=-v3iCwPJgf8NDwW811ufo--
