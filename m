Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWHBF5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWHBF5q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 01:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWHBF5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 01:57:46 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:8664 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1750702AbWHBF5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 01:57:45 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: deprecate and convert some sleep_on variants.
Date: Wed, 2 Aug 2006 08:00:22 +0200
User-Agent: KMail/1.9.3
Cc: arjan@infradead.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <20060801180643.GD22240@redhat.com>
In-Reply-To: <20060801180643.GD22240@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1629074.Ui1iQRsWqJ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200608020800.22802.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1629074.Ui1iQRsWqJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Dienstag, 1. August 2006 20:06 schrieb Dave Jones:
> We've been carrying this for a dogs age in Fedora. It'd be good to get
> this in -mm, so that it stands some chance of getting upstreamed at some
> point.
>
> Signed-off-by: Arjan van de Ven <arjan@infradead.org>
> Signed-off-by: Dave Jones <davej@redhat.com>
>
> diff -urNp --exclude-from=/home/davej/.exclude
> linux-1060/drivers/block/DAC960.c linux-1070/drivers/block/DAC960.c ---
> linux-1060/drivers/block/DAC960.c
> +++ linux-1070/drivers/block/DAC960.c
> @@ -6132,6 +6132,9 @@ static boolean DAC960_V2_ExecuteUserComm
>    unsigned long flags;
>    unsigned char Channel, TargetID, LogicalDriveNumber;
>    unsigned short LogicalDeviceNumber;
> +  wait_queue_t __wait;
> +
> +  init_waitqueue_entry(&__wait, current);

Is this only my opinion or is this really a bad choice for the queues name?

Eike

--nextPart1629074.Ui1iQRsWqJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBE0D92XKSJPmm5/E4RAjtgAKCicdYmaxNMIqBwqitzgcvRBY5XnQCfd+sx
0hZeOLz7J74sDUk9hHHEudY=
=E76r
-----END PGP SIGNATURE-----

--nextPart1629074.Ui1iQRsWqJ--
