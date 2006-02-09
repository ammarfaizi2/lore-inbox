Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422879AbWBIKu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422879AbWBIKu6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 05:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422880AbWBIKu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 05:50:58 -0500
Received: from tower.bj-ig.de ([194.127.182.2]:11218 "EHLO fs.bj-ig.de")
	by vger.kernel.org with ESMTP id S1422879AbWBIKu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 05:50:57 -0500
From: Ralf =?iso-8859-1?q?M=FCller?= <ralf@bj-ig.de>
To: linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Thu, 9 Feb 2006 11:50:48 +0100
User-Agent: KMail/1.8.2
References: <200602031724.55729.luke@dashjr.org> <20060208165330.GB17534@voodoo> <43EB0DEB.nail52A1LVGUO@burner>
In-Reply-To: <43EB0DEB.nail52A1LVGUO@burner>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4657729.MI5K1bNgX7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602091150.53113@bj-ig.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4657729.MI5K1bNgX7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Donnerstag 09 Februar 2006 10:39, you wrote:
> Are you _really_ missing basic know how to understand that fsck is
> using the block layer of a virtual "block device" emulated by UNIX
> while libscg is offering _direct_ acces to _any_ type of device
> allowing you to send _commands_ understood by the device?

You mix things up. As this thread is about writing CD's and cdrecord,=20
nobody here really wants you to use libscg to do your IO. Nobody here=20
wants cdrecord to be able to access any type of device - all of the=20
users of cdrecord just care about CD writers (and maybe DVD writers).=20
That is because you call your program cdrecord and not scanimage oder=20
cpuinfo. Actually none of the users of cdrecord even cares about how it=20
is able to talk to CD writers. They know that all other operations to=20
the CD writer can be done via /dev/cdrw, or however it is called on=20
their system, and would like to use the same device name to write a CD.=20
If libscg is unable to handle device names and needs to be feed with=20
strange numbers to address the writer, then libscg may be the wrong=20
tool.

> Please explain me:
>
> -	how to use /dev/hd* in order to scan an image from a scanner
>
> -	how to use /dev/hd* in order to talk to a CPU device
>
> -	how to use /dev/hd* in order to talk to a tape device
>
> -	how to use /dev/hd* in order to talk to a printer
>
> -	how to use /dev/hd* in order to talk to a jukebox
>
> -	how to use /dev/hd* in order to talk to a graphical device

I don't expect cdrecord to be able to do any of these jobs. I'd just=20
like to write a CD. To be honest - even if libscg would be able to peel=20
carrots I couldn't care less.

As for cdrecord I'm just one of those stupid users. I have a problem=20
(write a CD) - I'd like to solve this problem. And if the device=20
addressing scheme of cdrecord is different to all I've seen before from=20
all the other tools in my system, I blame cdrecord to be annoying not=20
the rest of my system - just because I have to investigate how to deal=20
with this program, instead of just being able to use it like all the=20
rest.

My 2 cents
Ralf

=2D-=20
Van Roy's Law: -------------------------------------------------------
       An unbreakable toy is useful for breaking other toys.

--nextPart4657729.MI5K1bNgX7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD6x6NZcF+4X5mWz8RAriJAKCUkk0koxts3LEHUINY0Jo+lnS6kQCfaf+6
vt3JCDwU/jQQ8/r0CsJ/wfA=
=kdlV
-----END PGP SIGNATURE-----

--nextPart4657729.MI5K1bNgX7--
