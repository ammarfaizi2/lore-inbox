Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262409AbVGFRYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbVGFRYa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 13:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbVGFRXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 13:23:30 -0400
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:47786 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261788AbVGFNEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 09:04:16 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: rt-preempt build failure
Date: Wed, 6 Jul 2005 23:03:58 +1000
User-Agent: KMail/1.8.1
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200507052308.43970.kernel@kolivas.org> <20050705135143.GA13614@elte.hu>
In-Reply-To: <20050705135143.GA13614@elte.hu>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1850615.vujcIGIsii";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507062304.03944.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1850615.vujcIGIsii
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tue, 5 Jul 2005 23:51, Ingo Molnar wrote:
> * Con Kolivas <kernel@kolivas.org> wrote:
> > Hi Ingo
> >
> > This config on i386:
> > http://ck.kolivas.org/crap/rt-config
> >
> > realtime-preempt-2.6.12-final-V0.7.50-51
> > fails to build with these errors:
>
> thanks, i have fixed this and have uploaded the -51-00 patch.

Thanks. boots and runs stable after a swag of these initially (?netconsole=
=20
related):

BUG: scheduling with irqs disabled: swapper/0x00000000/1
caller is __down_mutex+0x143/0x200
 [<c02dd908>] schedule+0x95/0xf5 (8)
 [<c02de5b6>] __down_mutex+0x143/0x200 (28)
 [<c02422c3>] b44_start_xmit+0x23/0x3ee (84)
 [<c0292beb>] find_skb+0xa4/0xe4 (8)
 [<c0292c3e>] netpoll_send_skb+0x13/0xb0 (48)
 [<c0243dcb>] write_msg+0x5f/0xb6 (16)
 [<c0243d6c>] write_msg+0x0/0xb6 (12)
 [<c011c3e1>] __call_console_drivers+0x41/0x4d (8)
 [<c011c551>] call_console_drivers+0xec/0x109 (20)
 [<c011c973>] release_console_sem+0x24/0xd4 (32)
 [<c0243e7e>] init_netconsole+0x40/0x74 (24)
 [<c03fa9ac>] do_initcalls+0x55/0xc7 (12)
 [<c010038b>] init+0x8a/0x1b3 (32)
 [<c0100301>] init+0x0/0x1b3 (16)
 [<c0100f71>] kernel_thread_helper+0x5/0xb (8)

There's a 75KB dmesg with all of them (not sure if any differ) here:
http://ck.kolivas.org/crap/rt.dmesg

same config:
http://ck.kolivas.org/crap/rt-config

Cheers,
Con

--nextPart1850615.vujcIGIsii
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCy9bDZUg7+tp6mRURAvIxAJ9QXAviEMgbPxHjITKp69T7td4lcgCaAwsg
ABAdBszjZULNetIJT4jx9UY=
=y+BC
-----END PGP SIGNATURE-----

--nextPart1850615.vujcIGIsii--
