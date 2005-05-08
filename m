Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbVEHX0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbVEHX0r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 19:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263006AbVEHX0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 19:26:47 -0400
Received: from mail26.syd.optusnet.com.au ([211.29.133.167]:59077 "EHLO
	mail26.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263003AbVEHX0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 19:26:40 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Haoqiang Zheng <haoqiang@gmail.com>
Subject: Re: [RFC PATCH] swap-sched: schedule with dynamic dependency detection (2.6.12-rc3)
Date: Mon, 9 May 2005 09:26:55 +1000
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <d6e6e6dd050507231174d99fb0@mail.gmail.com> <200505081733.31907.kernel@kolivas.org> <d6e6e6dd05050808556d83feb7@mail.gmail.com>
In-Reply-To: <d6e6e6dd05050808556d83feb7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1345835.UHGjYLbM1n";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505090926.59335.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1345835.UHGjYLbM1n
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, 9 May 2005 01:55, Haoqiang Zheng wrote:
> I am not quite sure about what do you mean for " a ring of dependent
> tasks".  Do you mean the situation that A depends on B while at the
> same time B depends on A?  It shouldn't happen since in swap-sched,
> the dependency is generated on the fly. Task A depends on B only when
> A blocks on waiting for B. For example, if task A blocks on
> "read(pipe_fd,...)" and B is the task that can do
> "write(pipe_fd,...)", then A is depending on B.  Once A is waked up,
>  A no longer depends on any other task. So the "ring of dependent
> tasks" shouldn't happen, otherwise it's a deadlock.

Ok so how does it respond to process_load in contest?

Cheers,
Con

--nextPart1345835.UHGjYLbM1n
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCfqBDZUg7+tp6mRURAl71AJ97336+EZ4oku76Z5xj07C2mKTBKACdE0yn
57yjAUcXoixdDmUDhvcmJtM=
=u2+Q
-----END PGP SIGNATURE-----

--nextPart1345835.UHGjYLbM1n--
