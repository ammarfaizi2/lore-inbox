Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbUCJJ7A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 04:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbUCJJ7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 04:59:00 -0500
Received: from smtp-out3.xs4all.nl ([194.109.24.13]:8715 "EHLO
	smtp-out3.xs4all.nl") by vger.kernel.org with ESMTP id S262291AbUCJJ6u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 04:58:50 -0500
In-Reply-To: <20040309113046.40271dc8.davem@redhat.com>
References: <684501482.20040309132741@bitdefender.com> <20040309113046.40271dc8.davem@redhat.com>
Mime-Version: 1.0 (Apple Message framework v612)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-30--329450049"
Message-Id: <F750F6B1-7271-11D8-AFFE-000A95CD704C@wagland.net>
Content-Transfer-Encoding: 7bit
Cc: "Viorel Canja, Softwin" <vcanja@bitdefender.com>,
       linux-kernel@vger.kernel.org
From: Paul Wagland <paul@wagland.net>
Subject: Re: problem in tcp_v4_synq_add ?
Date: Wed, 10 Mar 2004 10:04:41 +0100
To: "David S. Miller" <davem@redhat.com>
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.612)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-30--329450049
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Mar 9, 2004, at 20:30, David S. Miller wrote:

> On Tue, 9 Mar 2004 13:27:41 +0200
> "Viorel Canja, Softwin" <vcanja@bitdefender.com> wrote:
>
>> Shouldn't  "write_lock(&tp->syn_wait_lock);" be moved before
>> "req->dl_next = lopt->syn_table[h];" to avoid a race condition ?
>
> Nope, the listening socket's socket lock is held, and all things that
> add members to these hash chains hold that lock.

Is that the same as saying that the write_lock() is not needed at all? 
Since it is already guaranteed to be protected with a different lock?

Cheers,
Paul

--Apple-Mail-30--329450049
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFATtoptch0EvEFvxURAq6NAJ0cRdHuU4qiI/nR3E5wtRWTFfHIMwCfdNXj
rX7n9E8ffdL/YWGEacy9O/4=
=+jFX
-----END PGP SIGNATURE-----

--Apple-Mail-30--329450049--

