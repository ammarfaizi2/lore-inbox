Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267602AbUGWKgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267602AbUGWKgH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 06:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267605AbUGWKgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 06:36:07 -0400
Received: from viefep13-int.chello.at ([213.46.255.15]:55070 "EHLO
	viefep13-int.chello.at") by vger.kernel.org with ESMTP
	id S267602AbUGWKgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 06:36:03 -0400
To: linux-kernel@vger.kernel.org
Subject: User-space Keyboard input?
From: Mario Lang <mlang@delysid.org>
Date: Fri, 23 Jul 2004 12:36:20 +0200
Message-ID: <87y8lb80yj.fsf@lexx.delysid.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi.

I'm working on BRLTTY[1], a user-space daemon which handles braille displays
on UNIX platforms.  One of our display drivers recently gained the ability
to receive (set 2) scancodes from a keyboard connected directly to the display.
This is a very cool feature, since the display in question has
a bluetooth interface, making it effectively into a complete wireless
terminal (input and output through the same connection).

However, this creates some problems.  First of all, we now have to deal
with keyboard layouts.  Additionally, since we currently insert via
TIOCSTI I think this might get problematic as soon as one switches
to an X Windows console and modifiers come into play.

Does anyone know (and can point me into the right direction) if
Linux has some mechanism to allow for user-space keyboard data to
be processed by the kernel as if it were received from the system
keyboard?  I.e., keyboard layout would be handled by the same
mapping which is configured for the system.

-- 
Thanks,
  Mario

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBAOo23/wCKmsRPkQRAr5hAJ9/WD0JnDirClmm7mBhhTMq/DQ3vwCfejIL
xOURfbcv9jEI/gHYB/QlJt0=
=Fn9i
-----END PGP SIGNATURE-----
--=-=-=--
