Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289226AbSBXVAs>; Sun, 24 Feb 2002 16:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291281AbSBXVAi>; Sun, 24 Feb 2002 16:00:38 -0500
Received: from lsanca1-ar27-4-63-184-089.lsanca1.vz.dsl.gtei.net ([4.63.184.89]:2688
	"EHLO barbarella.hawaga.org.uk") by vger.kernel.org with ESMTP
	id <S291251AbSBXVAT>; Sun, 24 Feb 2002 16:00:19 -0500
Date: Sun, 24 Feb 2002 13:00:00 -0800 (PST)
From: Ben Clifford <benc@hawaga.org.uk>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.5-dj1 - problem with /dev/input/mice
In-Reply-To: <20020222022329.A3533@suse.cz>
Message-ID: <Pine.LNX.4.33.0202241249540.11220-100000@barbarella.hawaga.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> >  -dj includes a different input layer to Linus' tree, which requires

I've just moved from Linus 2.5.3 to 2.5.5-dj1.

I've tried the following both with modules and linked into bzImage.

I've tried pointing the software at /dev/input/mice and also at /dev/psaux
which I created as a symlink to /dev/input/mice (to maintain compatibility
with my working 2.5.3 setup)

I have a PS/2 mouse.

I've loaded mousedev.o and psmouse.o

gpm works. (**1)

cat /dev/input/mice
gives random binary spew that looks pretty much like mouse input.

When I run my Xserver, the mouse pointer doesn't move. If I then kill off
the Xserver, gpm doesn't work any more and cat/dev/input/mice doesn't
generate anything any more.

If I unload psmouse.o and then load it again, I am back to (**1) until I
load the Xserver again.

- -- 
Ben Clifford     benc@hawaga.org.uk     GPG: 30F06950
Job Required in Los Angeles - Will do most things unix or IP for money.
http://www.hawaga.org.uk/resume/resume001.pdf
Live Ben-cam: http://barbarella.hawaga.org.uk/benc-cgi/watchers.cgi


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8eVRTsYXoezDwaVARAv8nAJ4s0sH7Zh295dna6i7UI1PML0JavgCcCtS5
mrYEP5nWJ2i6eCqp4hncSG0=
=sfBd
-----END PGP SIGNATURE-----

