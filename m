Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279761AbRJ0C7u>; Fri, 26 Oct 2001 22:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279765AbRJ0C7l>; Fri, 26 Oct 2001 22:59:41 -0400
Received: from rosebud.imaginos.net ([64.173.180.66]:49545 "EHLO
	rosebud.imaginos.net") by vger.kernel.org with ESMTP
	id <S279761AbRJ0C7V>; Fri, 26 Oct 2001 22:59:21 -0400
Date: Fri, 26 Oct 2001 19:59:41 -0700 (PDT)
From: Jim Hull <imaginos@imaginos.net>
X-X-Sender: <imaginos@rosebud>
To: Duncan Sands <duncan.sands@math.u-psud.fr>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: dvd issue now only occurs in 2.4.13
In-Reply-To: <01102522415500.00896@baldrick>
Message-ID: <Pine.LNX.4.33.0110261948440.19023-100000@rosebud>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Yeah, unfortunatly that did not fix my issue, although I have been trying
to  follow the many different threads and from it appears, correct me if
i'm wrong .... the problem resides in the new VM implementation and file
readahead. I have been setting my file readahead to 2 megs (mainly cause my
son scratched the hell out of one of my dvd's and this seemed to correct
most of the crc errors I was recieving.) Anyhow, I set it to 0
(echo file_readahead:0 >/proc/ide/hdd/settings) and my dvd player is no
longer hanging. Odly enough, and maybe someone can explain this to me, my
scratched dvd plays perfect as to before it skipped like mad.


So is this an issue thats going to remain like this ? Will I no longer
need to set file readahead in the device itself under /proc ?


			Jim


============================
They that give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety.

- --Benjamin Franklin,
Historical Review of Pennyslvania, 1759



On Thu, 25 Oct 2001, Duncan Sands wrote:

This might be the same as the problem discussed in the
thread
  "xine pauses with recent (not -ac) kernels"
(try searching the list archive).  The conclusion seemed
to be that since there was a workaround if you are
using raw io (doing a

         sleep 100000 < /dev/dvd-device &

in the background before starting xine), the fix could wait
for the 2.5 kernels.

I hope this helps,

Duncan.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE72iMmdygyS8O4zQ0RAiisAJ9MsBoDuu0Js+wQuEAkPG78W3KIZwCfYTF6
ymoyT+QZDkLFE4mYAV5s1h8=
=WVCH
-----END PGP SIGNATURE-----


