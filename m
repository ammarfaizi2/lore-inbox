Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267968AbUJLVtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267968AbUJLVtZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 17:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267903AbUJLVtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 17:49:25 -0400
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:52363 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267936AbUJLVsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 17:48:50 -0400
Message-ID: <416C5122.9040001@kolivas.org>
Date: Wed, 13 Oct 2004 07:48:18 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
Cc: netdev@oss.sgi.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       davem@redhat.com
Subject: Re: [PATCH] netconsole support for b44
References: <416BC26B.6090603@kolivas.org> <20041012180949.GW5414@waste.org>
In-Reply-To: <20041012180949.GW5414@waste.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBF3A108614D7BD67726F038C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBF3A108614D7BD67726F038C
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Matt Mackall wrote:
> On Tue, Oct 12, 2004 at 09:39:23PM +1000, Con Kolivas wrote:
> 
>>This patch adds poll support to the b44 driver to allow netconsole 
>>support. Style lifted straight from 8139too.c
>>
>>here is the dmesg output with it in place:
>>
>>netconsole: device eth0 not up yet, forcing it
>>netconsole: carrier detect appears flaky, waiting 10 seconds
>>b44: eth0: Link is down.
>>b44: eth0: Link is up at 100 Mbps, full duplex.
>>b44: eth0: Flow control is on for TX and on for RX.
>>netconsole: network logging started
>>
>>output confirmed by netcat on other system.
>>
>>Signed-off-by: Con Kolivas <kernel@kolivas.org>
> 
> 
> +       disable_irq(dev->irq);
> +       b44_interrupt (dev->irq, dev, NULL);
> +       enable_irq(dev->irq);
> 
> Aside from this bizarre whitespace convention and neglecting to cc:
> me, looks good.
> 

sorry,sorry,thanks.

Can you explain where I went wrong in the whitespace so I don't make the 
same mistake again? It looked pretty standard to me.

Should I nudge akpm with this or will it go via another route?

Cheers,
Con

--------------enigBF3A108614D7BD67726F038C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBbFEkZUg7+tp6mRURAlWCAJ4oaRD1BZfn4t1aFQdzT5GHZA14mwCfZ08d
c/pMvPFNLqseH5ekm/xyvZY=
=wXV5
-----END PGP SIGNATURE-----

--------------enigBF3A108614D7BD67726F038C--
