Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132417AbRA2PsZ>; Mon, 29 Jan 2001 10:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132928AbRA2PsP>; Mon, 29 Jan 2001 10:48:15 -0500
Received: from host213-120-148-5.btopenworld.com ([213.120.148.5]:30192 "EHLO
	nvlonlx01.netvoyager.co.uk") by vger.kernel.org with ESMTP
	id <S132417AbRA2PsI>; Mon, 29 Jan 2001 10:48:08 -0500
Date: Mon, 29 Jan 2001 15:46:40 +0000 (UTC)
From: Mo McKinlay <mmckinlay@gnu.org>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
cc: Mo McKinlay <mmckinlay@gnu.org>, Peter Samuelson <peter@cadcamlab.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: named streams, extended attributes, and posix
In-Reply-To: <3A758A57.CB019330@holly-springs.nc.us>
Message-ID: <Pine.LNX.4.30.0101291545230.4142-100000@nvws005.nv.london>
Organization: inter/open Labs
X-URL: http://www.interopen.org/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Today, Michael Rothwell (rothwell@holly-springs.nc.us) wrote:

  > So, openstream() is probably the most painless way to get named streams
  > support into Linux in the immediate future. Openstream() will have to
  > fail on filesystems that do not support streams, ideally without
  > changing those filesystems.

Agree - I'd imagine with the same error that trying to symlink on a
filesystem which does not support symlinks produces ("Operation not
permitted"?).

  >  And as long as we're adding a system call to
  > deal with streams, we should consider adding the functions for extended
  > attributes at the same time.

Agree.

  > >From http://www.flyingbuttmonkeys.com/streams-on-posix.txt ...
  >
  > Minimum VFS Support
  > vop_eattr_get - read an EA
  > vop_eattr_set - set an EA
  > vop_eattr_remove - remove an EA
  > vop_eattr_list - list the EAs like vop_readdir would a directory.
  >
  > Optional Support
  > vop_eattr_create - Create an EA or error if it exists.
  > vop_eattr_multi - perform a sequence of EA vops atomically.
  > vop_eattr_rename - change the name of an EA
  > vop_eattr_serialize - export all the EAs as a stream of entries.
  >
  > Thoughts? You mught want to refer back to the paper to get the whole EAs
  > proposal...

I shall, and get back to you this evening (workworkworkwork... :)

Mo.

- -- 
Mo McKinlay
mmckinlay@gnu.org
- -------------------------------------------------------------------------
GnuPG/PGP Key: pub  1024D/76A275F9 2000-07-22





-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjp1kGIACgkQRcGgB3aidfmBWQCfSODBdYvh0QhqwxHUWB3IGUxg
NY4AoLG1i01AmjYASQwwQMh58t2b1Ut7
=bwEX
-----END PGP SIGNATURE-----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
