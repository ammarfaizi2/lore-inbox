Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVFAVi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVFAVi7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 17:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbVFAViL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 17:38:11 -0400
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:45212 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261184AbVFAVg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 17:36:59 -0400
From: Con Kolivas <kernel@kolivas.org>
To: steve.rotolo@ccur.com
Subject: Re: SD_SHARE_CPUPOWER breaks scheduler fairness
Date: Thu, 2 Jun 2005 07:37:16 +1000
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, bugsy@ccur.com
References: <1117561608.1439.168.camel@whiz> <200506020047.16752.kernel@kolivas.org> <1117651285.22879.73.camel@bonefish>
In-Reply-To: <1117651285.22879.73.camel@bonefish>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1493069.24kyQzLVK7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506020737.20098.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1493069.24kyQzLVK7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thu, 2 Jun 2005 04:41, Steve Rotolo wrote:
> I guess the bottom-line is: given N logical cpus, 1/N of all
> SCHED_NORMAL tasks may get stuck on a sibling cpu with no chance to
> run.  All it takes is one spinning SCHED_FIFO task.  Sounds like a bug.

You're right, and excuse me for missing it. We have to let SCHED_NORMAL tas=
ks=20
run for some period with rt tasks. There shouldn't be any combination of=20
mutually exclusive tasks for siblings.

I'll work on something.

Cheers,
Con

--nextPart1493069.24kyQzLVK7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCniqQZUg7+tp6mRURAiwHAJ0TF/MZct4Qg+Zu3mMqNH+2bN4v8ACffJXQ
vnrVYogdTp2zpul3Ut6ZP64=
=2bah
-----END PGP SIGNATURE-----

--nextPart1493069.24kyQzLVK7--
