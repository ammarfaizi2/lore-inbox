Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbWCHDFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbWCHDFz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 22:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbWCHDFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 22:05:55 -0500
Received: from mail11.syd.optusnet.com.au ([211.29.132.192]:28303 "EHLO
	mail11.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S964888AbWCHDFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 22:05:54 -0500
References: <200603081013.44678.kernel@kolivas.org> <200603081322.02306.kernel@kolivas.org> <1141784834.767.134.camel@mindpipe> <200603081330.56548.kernel@kolivas.org> <b8bf37780603071852r6bf3821fr7610597a54ad305b@mail.gmail.com>
Message-ID: <cone.1141787137.882268.19235.501@kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: =?ISO-8859-1?B?QW5kcuk=?= Goddard Rosa <andre.goddard@gmail.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, ck@vds.kolivas.org
Subject: Re: [PATCH] mm: yield during swap prefetching
Date: Wed, 08 Mar 2006 14:05:37 +1100
Mime-Version: 1.0
Content-Type: multipart/signed;
    boundary="=_mimegpg-kolivas.org-19235-1141787137-0001";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.

--=_mimegpg-kolivas.org-19235-1141787137-0001
Content-Type: text/plain; format=flowed; charset="ISO-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Mime-Autoconverted: from 8bit to quoted-printable by mimegpg

Andr=E9 Goddard Rosa writes:

> [...]
>> > > Because being a serious desktop operating system that we are
>> > > (bwahahahaha) means the user should not have special privileges to ru=
n
>> > > something as simple as a game. Games should not need special scheduli=
ng
>> > > classes. We can always use 'nice' for a compile though. Real time aud=
io
>> > > is a completely different world to this.
> [...]
>> Well as I said in my previous reply, games should _not_ need special
>> scheduling classes. They are not written in a real time smart way and the=
y do
>> not have any realtime constraints or requirements.
> 
> Sorry Con, but I have to disagree with you on this.
> 
> Games are very complex software, involving heavy use of hardware resources
> and they also have a lot of time constraints. So, I think they should
> use RT priorities
> if it is necessary to get the resources needed in time.

Excellent, I've opened the can of worms.

Yes, games are a in incredibly complex beast.

No they shouldn't need real time scheduling to work well if they are coded 
properly. However, witness the fact that most of our games are windows 
ports, therefore being lower quality than the original. Witness also the 
fact that at last with dual core support, lots and lots (but not all) of 
windows games on _windows_ are having scheduling trouble and jerky playback,=
 
forcing them to crappily force binding to one cpu. As much as I'd love to 
blame windows, it is almost certainly due to the coding of the application 
since better games don't exhibit this problem. Now the games in question 
can't be trusted to even run on SMP; do you really think they could cope 
with good real time code? Good -complex- real time coding is very difficult.=
 
If you take any game out there that currently exists and throw real time 
scheduling at it, almost certainly it will hang the machine. No, I don't 
believe games need realtime scheduling to work well; they just need to be 
written well and the kernel needs to be unintrusive enough to work well with=
 
them. Otherwise gaming would have needed realtime scheduling from day 
one on all operating systems. Generic kernel activities should not cause 
game stuttering either as users have little control over them. I do expect 
users to not run too many userspace programs while trying to play games 
though. I do not believe we should make games work well in the presence of 
updatedb running for example.

Cheers,
Con


--=_mimegpg-kolivas.org-19235-1141787137-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBEDkoBZUg7+tp6mRURAoszAJ92VIxqHRxyBVfHfIY7KUxBDGMzDgCfWsrt
ABs88x3ldlS0BZE8WKrM110=
=q1Ii
-----END PGP SIGNATURE-----

--=_mimegpg-kolivas.org-19235-1141787137-0001--
