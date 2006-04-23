Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbWDWNkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWDWNkU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 09:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWDWNkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 09:40:19 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:27561 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1750957AbWDWNkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 09:40:18 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [RFC: 2.6 patch] kernel/kthread.c: make kthread_stop_sem() static
Date: Sun, 23 Apr 2006 15:37:40 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060423114022.GJ5010@stusta.de>
In-Reply-To: <20060423114022.GJ5010@stusta.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1465138.SUvbNQamJl";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200604231537.55205.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1465138.SUvbNQamJl
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Adrian,

On Sunday, 23. April 2006 13:40, Adrian Bunk wrote:
> This patch makes the needlessly global kthread_stop_sem() static.

Could you cleanup the code paths as well?

Now s is always NULL in kthread_stop_sem() and
kthread_stop_sem() is degenerated to kthread_stop().
So it can be folded into the latter.


Regards

Ingo Oeser

--nextPart1465138.SUvbNQamJl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBES4MzU56oYWuOrkARAsf7AJ9tga01s2gof9enmSU4ihwG3ZV8JACdFzMz
mqvZDx+khCJWvtwxPyoZqMU=
=aPUe
-----END PGP SIGNATURE-----

--nextPart1465138.SUvbNQamJl--
