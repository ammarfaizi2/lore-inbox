Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263778AbUISUld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbUISUld (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 16:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbUISUld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 16:41:33 -0400
Received: from [63.227.221.253] ([63.227.221.253]:53440 "EHLO home.keithp.com")
	by vger.kernel.org with ESMTP id S263778AbUISUlM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 16:41:12 -0400
X-Mailer: exmh version 2.3.1 11/28/2001 with nmh-1.1
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Keith Packard <keithp@keithp.com>,
       dri-devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Design for setting video modes, ownership of sysfs attributes 
From: Keith Packard <keithp@keithp.com>
In-Reply-To: Your message of "Sun, 19 Sep 2004 12:46:13 EDT."
             <9e47339104091909465c9a483f@mail.gmail.com> 
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_186259440P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 19 Sep 2004 13:40:43 -0700
Message-Id: <E1C98UF-0002Tn-DG@evo.keithp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_186259440P
Content-Type: text/plain; charset=us-ascii


Around 12 o'clock on Sep 19, Jon Smirl wrote:

> This is going to require some more thought. Mode setting needs two
> things, a description of the mode timings and a location of the scan
> out buffer.  With multiple heads you can't just assume that the buffer
> starts at zero.  There also the problem of the buffer increasing in
> size and needing to be moved since it won't fit where it is.
> 
> Keith, how should this work for X?

I just need to know where the frame buffer lives; it can move or change 
pitch at any time.  I can even deal with the frame buffer moving without 
warning if necessary.  What I can't handle is off-screen memory suddenly 
disappearing on me; I need to be able to pull any off-screen data back to 
main memory before things get shuffled around.

This, of course, is related rather strongly with any memory management 
system, for which I'd like to have applications allocate main-memory space 
for any off-screen resources so that the kernel can pull things off the 
video card without needing cooperation from the X server at switch time.

-keith



--==_Exmh_186259440P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Exmh version 2.3.1 11/28/2001

iD8DBQFBTe7KQp8BWwlsTdMRAkwGAKCtXzC66I95/s7GIKuXQd71sEbAUQCeOTcG
ZcJlChriLsPvqqLiizFQ9jg=
=NvoG
-----END PGP SIGNATURE-----

--==_Exmh_186259440P--
