Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264724AbRGNS3D>; Sat, 14 Jul 2001 14:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264754AbRGNS2x>; Sat, 14 Jul 2001 14:28:53 -0400
Received: from opal.spod.org ([195.92.249.250]:7173 "EHLO mail.spod.org")
	by vger.kernel.org with ESMTP id <S264724AbRGNS2r>;
	Sat, 14 Jul 2001 14:28:47 -0400
Date: Sat, 14 Jul 2001 19:30:05 +0100 (BST)
From: Mo McKinlay <mmckinlay@gnu.org>
X-X-Sender: <mckinlay@opal.spod.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Jonathan Lundell <jlundell@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>
Subject: Re: __KERNEL__ removal
In-Reply-To: <3B508D34.180A07A0@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0107141925010.14554-100000@opal.spod.org>
Organization: inter/open Labs
X-URL: http://www.interopen.org/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Today, Jeff Garzik (jgarzik@mandrakesoft.com) wrote:

  > If we want to avoid the retyping (which is IMHO the most clean
  > separation for all cases, even if it involves drudgery) then separating
  > out code into libc-only headers would be nice.

I agree...the "worst" case is that the libc and kernel become out of step.
Big deal. If that was to have a bad effect, then statically-compiled
programs would fail to work as well... and if this happened, well, it'd
generally be universally accepted as a bug in the particular release of
the kernel.

I know it takes time and effort, but so does fixing and working around all
of the problems created by using kernelspace headers in userspace.
/usr/src/kernel/include should never *ever* be seen by anything except the
kernel and kernel-level drivers. Everything else should either have its
own headers, or use the libc's (which should have its own set defining the
appropriate types and structures needed for syscalls and ioctls).

This really isn't *that* difficult to get your head around.

Mo.

- -- 
Mo McKinlay
mmckinlay@gnu.org
- -------------------------------------------------------------------------
GnuPG/PGP Key: pub  1024D/76A275F9 2000-07-22





-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.0 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjtQj7AACgkQRcGgB3aidfmTlACgmT1+c9JH0ShTp/roTgewMHq3
c70AoIyj/baePWnPgjI7TahB/VXl8BNy
=gKji
-----END PGP SIGNATURE-----


